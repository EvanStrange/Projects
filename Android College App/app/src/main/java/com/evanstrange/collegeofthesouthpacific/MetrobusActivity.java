package com.evanstrange.collegeofthesouthpacific;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.webkit.WebView;
import android.webkit.WebViewClient;

public class MetrobusActivity extends AppCompatActivity {
    private WebView webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_metrobus);

        webView = findViewById(R.id.MetrobusWebview);
        webView.setWebViewClient(new WebViewClient());
        webView.loadUrl("http://www.metrobus.com");
    }
}
