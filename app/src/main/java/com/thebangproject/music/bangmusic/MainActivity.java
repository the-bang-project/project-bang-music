package com.thebangproject.music.bangmusic;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
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
                //case R.id.navigation_settings:
                //    mTextMessage.setText(R.string.text_settings);
                //    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

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
                Toast.makeText(getApplicationContext(),"Whoops that hasn't been added yet.",Toast.LENGTH_SHORT).show();
        }

        switch (id)
        {
            case R.id.settings:
                
                //Toast.makeText(getApplicationContext(),"Whoops that hasn't been added yet.",Toast.LENGTH_SHORT).show();
        }

        return true;
    }
}
