package com.thebangproject.music.bangmusic;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Switch;
import android.widget.CompoundButton;

public class SettingsActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getSupportFragmentManager().beginTransaction()
                .replace(android.R.id.content, new SettingsFragment())
                .commit();

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Get widgets reference from XML layout
        final TextView tView = (TextView) findViewById(R.id.tv);
        Switch sButton = (Switch) findViewById(R.id.nightSwitch);

        //Set a CheckedChange Listener for Switch Button
        sButton.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton cb, boolean on) {
                if (on) {
                    //Do something when Switch button is on/checked
                    tView.setText("Switch is on.....");
                } else {
                    //Do something when Switch is off/unchecked
                    tView.setText("Switch is off.....");
                }
            }
        });
    }
}



