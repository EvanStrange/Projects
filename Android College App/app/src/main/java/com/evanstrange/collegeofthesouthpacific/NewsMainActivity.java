package com.evanstrange.collegeofthesouthpacific;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.view.View;
import android.widget.TextView;
import android.content.Intent;

import com.evanstrange.collegeofthesouthpacific.news.AsyncResponse;
import com.evanstrange.collegeofthesouthpacific.news.FileDownloader;

public class NewsMainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_news);

        ConnectivityManager connManager = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
        NetworkInfo mWifi = connManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
        NetworkInfo mMobile = connManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE);

        if (mWifi.isConnected() == false && mMobile.isConnected() == false) {
            showErrorView();
        }
        else {
            System.out.println("Connected");
            setContentView(R.layout.activity_news);

            findViewById(R.id.loadingPanel).setVisibility(View.VISIBLE);
            FileDownloader news = new FileDownloader("http://branko-cirovic.appspot.com/etcapp/news/news.xml", NewsMainActivity.this);
            news.setOnResultsListener(new AsyncResponse() {
                @Override
                public void processFinish(String output) {
                    Intent newsScreen = new Intent(getApplicationContext(), NewsActivity.class);
                    newsScreen.putExtra("xmlData", output);
                    findViewById(R.id.loadingPanel).setVisibility(View.GONE);
                    startActivity(newsScreen);
                }
            });
            news.execute();
        }
    }

    private void showErrorView() {
        setContentView(R.layout.error_layout);
        TextView errorView = (TextView) findViewById(R.id.errorMessage);
        errorView.setText("App cannot connect to network. Check network settings and try again.");
    }
}
