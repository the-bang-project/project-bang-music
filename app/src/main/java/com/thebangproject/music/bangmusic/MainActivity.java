package com.thebangproject.music.bangmusic;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private TextView mTextMessage;

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            switch (item.getItemId()) {
                case R.id.navigation_feed:
                    mTextMessage.setText(R.string.text_feed);
                    return true;
                case R.id.navigation_search:
                    mTextMessage.setText(R.string.text_search);
                    return true;
                case R.id.navigation_library:
                    mTextMessage.setText(R.string.text_library);
                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Does not work because the settings page isn't on a button - and its for background colour
        //SharedPreferences spf = PreferenceManager.getDefaultSharedPreferences(this);
        //String storeColour = spf.getString(getString(R.string.key_colour),"#3F51B5");

        //RelativeLayout layoutBackC = (RelativeLayout) findViewById(R.id.changeColor);
        //layoutBackC.setBackgroundColor(Color.parseColor(storeColour));

        mTextMessage = (TextView) findViewById(R.id.message);
        BottomNavigationView navigation = (BottomNavigationView) findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.dotmenu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        int id = item.getItemId();

        switch (id)
        {
            case R.id.website:
                String url = "http://the-bang-project.business.site";
                Intent i = new Intent(Intent.ACTION_VIEW);
                i.setData(Uri.parse(url));
                startActivity(i);
        }

        switch (id)
        {
            case R.id.settings:
                Intent intent = new Intent(this, SettingsActivity.class);
                startActivity(intent);
        }

        return true;
    }

    public void openMediaPlayer (View view) {
        Intent intent = new Intent(this, MediaPlayer.class);
        startActivity(intent);
    }

}
