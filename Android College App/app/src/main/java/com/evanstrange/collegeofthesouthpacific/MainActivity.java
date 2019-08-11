package com.evanstrange.collegeofthesouthpacific;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;

public class MainActivity extends AppCompatActivity {

    private ImageButton metrobusButton;
    private ImageButton newsButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        metrobusButton = findViewById(R.id.metrobusButton);
        metrobusButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openMetrobusActivity();
            }
        });

        newsButton = findViewById(R.id.newsButton);
        newsButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                openNewsActivity();
            }
        });
    }
    public void openMetrobusActivity() {
        Intent intent = new Intent(this, MetrobusActivity.class);
        startActivity(intent);
    }
    public void openNewsActivity() {
        Intent intent = new Intent(this, NewsMainActivity.class);
        startActivity(intent);
    }
}