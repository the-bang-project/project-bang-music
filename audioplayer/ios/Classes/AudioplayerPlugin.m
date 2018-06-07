#import "AudioplayerPlugin.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

//#import <audioplayer/audioplayer-Swift.h>
static NSString *const CHANNEL_NAME = @"bz.rxla.flutter/audio";
static FlutterMethodChannel *channel;
static AVPlayer *player;
static AVPlayerItem *playerItem;


@interface AudioplayerPlugin()
-(void) pause;
-(void) stop;
-(void) mute: (BOOL) muted;
-(void) seek: (CMTime) time;
-(void) onSoundComplete;
-(void) updateDuration;
-(void) onTimeInterval: (CMTime) time;


@end


@implementation AudioplayerPlugin {
  FlutterResult _result;
  
}
CMTime duration;
CMTime position;
NSString *lastUrl;
BOOL isPlaying = false;
NSMutableSet *observers;
NSMutableSet *timeobservers;
FlutterMethodChannel *_channel;


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
                                   methodChannelWithName:CHANNEL_NAME
                                   binaryMessenger:[registrar messenger]];
  AudioplayerPlugin* instance = [[AudioplayerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  _channel = channel;
}


- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSLog(@"iOS => call %@",call.method);
  
  typedef void (^CaseBlock)();
  
  // Squint and this looks like a proper switch!
  NSDictionary *methods = @{
                            @"play":
                              ^{
                                NSLog(@"play!");
                                NSString *url = call.arguments[@"url"];
                                if (url == nil)
                                  result(0);
                                if (call.arguments[@"isLocal"]==nil)
                                  result(0);
                                int isLocal = [call.arguments[@"isLocal"]intValue] ;
                                NSLog(@"isLocal: %d %@",isLocal, call.arguments[@"isLocal"] );
                                [self togglePlay:url isLocal:isLocal];
                              },
                            @"pause":
                              ^{
                                NSLog(@"pause");
                                [self pause];
                              },
                            @"stop":
                              ^{
                                NSLog(@"stop");
                                [self stop];
                              },
                            @"mute":
                              ^{
                                NSLog(@"mute");
                                [self mute: [call.arguments boolValue]];
                              },
                            @"seek":
                              ^{
                                NSLog(@"seek");
                                [self seek: CMTimeMakeWithSeconds([call.arguments doubleValue], 1)];
                              }
                            };
  
  CaseBlock c = methods[call.method];
  if (c) c(); else {
    NSLog(@"not implemented");
    result(FlutterMethodNotImplemented);
  }
  result(@(1));
}


-(void) togglePlay: (NSString*) url isLocal: (int) isLocal
{
  NSLog(@"togglePlay %@",url );
  if (![url isEqualToString:lastUrl]) {
    [playerItem removeObserver:self
                    forKeyPath:@"player.currentItem.status"];
    
    // removeOnSoundComplete
    // [[ NSNotificationCenter defaultCenter] removeObserver:self];
    for (id ob in observers)
      [[NSNotificationCenter defaultCenter] removeObserver:ob];
    observers = nil;
    
    if( isLocal ){
      playerItem = [[ AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:url]];
    } else {
      playerItem = [[ AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url ]];
    }
    lastUrl = url;
    
    id anobserver = [[ NSNotificationCenter defaultCenter ] addObserverForName: AVPlayerItemDidPlayToEndTimeNotification
                                                                        object: playerItem
                                                                         queue: nil
                                                                    usingBlock:^(NSNotification* note){
                                                                      [self onSoundComplete];
                                                                    }];
    [observers addObject:anobserver];
    
    if (player){
      [ player replaceCurrentItemWithPlayerItem: playerItem ];
    } else {
      player = [[ AVPlayer alloc ] initWithPlayerItem: playerItem ];
      
      // stream player position
      CMTime interval = CMTimeMakeWithSeconds(0.2, NSEC_PER_SEC);
      id timeObserver = [ player  addPeriodicTimeObserverForInterval: interval queue: nil usingBlock:^(CMTime time){
        //NSLog(@"time interval: %f",CMTimeGetSeconds(time));
        [self onTimeInterval: time];
      }];
      [timeobservers addObject:timeObserver];
      
    }
    
    // is sound ready
    [[player currentItem] addObserver:self
                           forKeyPath:@"player.currentItem.status"
                              options:0
                              context:nil];
  }
  
  if (isPlaying == true ){
    pause();
  } else {
    [self updateDuration];
    [ player play];
    isPlaying = true;
  }
}



-(void) updateDuration
{
  CMTime d = [[player currentItem] duration ];
  NSLog(@"ios -> updateDuration...%f", CMTimeGetSeconds(d));
  duration = d;
  if(CMTimeGetSeconds(duration)>0){
    NSLog(@"ios -> invokechannel");
   int mseconds= CMTimeGetSeconds(duration)*1000;
    [_channel invokeMethod:@"audio.onDuration" arguments:@(mseconds)];
  }
}



-(void) onTimeInterval: (CMTime) time {
  NSLog(@"ios -> onTimeInterval...");
  int mseconds =  CMTimeGetSeconds(time)*1000;
  [_channel invokeMethod:@"audio.onCurrentPosition" arguments:@(mseconds)];
}


-(void) pause {
  [ player pause ];
  isPlaying = false;
}


-(void) stop {
  if(isPlaying){
    [ self pause ];
    [ self seek: CMTimeMake(0, 1) ];
    isPlaying = false;
    NSLog(@"stop");
  }
}

-(void) mute: (bool) muted {
    player.muted = muted;
}

-(void) seek: (CMTime) time {
  [playerItem seekToTime:time];
}


-(void) onSoundComplete {
  NSLog(@"ios -> onSoundComplete...");
  isPlaying = false;
  [ self pause ];
  [ self seek: CMTimeMakeWithSeconds(0,1)];
  [ _channel invokeMethod:@"audio.onComplete" arguments: nil];
}


-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
  
  if ([keyPath isEqualToString: @"player.currentItem.status"]) {
    NSLog(@"player status: %ld",(long)[[player currentItem] status ]);
    // Do something with the status…
    if ([[player currentItem] status ] == AVPlayerItemStatusReadyToPlay) {
      [self updateDuration];
    } else if ([[player currentItem] status ] == AVPlayerItemStatusFailed) {
      [_channel invokeMethod:@"audio.onError" arguments:@[(player.currentItem.error.localizedDescription)] ];
    }
  } else {
    // Any unrecognized context must belong to super
    [super observeValueForKeyPath:keyPath
                         ofObject:object
                           change:change
                          context:context];
  }
}


- (void)dealloc {
  for (id ob in timeobservers)
    [player removeTimeObserver:ob];
  timeobservers = nil;
  
  for (id ob in observers)
    [[NSNotificationCenter defaultCenter] removeObserver:ob];
  observers = nil;
}



@end

