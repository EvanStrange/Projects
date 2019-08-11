package com.evanstrange.collegeofthesouthpacific;

/**
 * Created by admin on 2018-07-20.
 */

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.app.ActionBar;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;

import com.evanstrange.collegeofthesouthpacific.news.LazyNewsAdapter;
import com.evanstrange.collegeofthesouthpacific.news.News;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import java.io.ByteArrayOutputStream;
import java.io.StringReader;
import java.util.ArrayList;

public class NewsActivity extends AppCompatActivity {
    private String xmlData;
    private ListView listView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.news_layout);

        Bundle extras = getIntent().getExtras();
        xmlData = extras.getString("xmlData");

        final ArrayList<News> newsData = getNewsData(xmlData);
        listView = (ListView) findViewById(R.id.news_list);
        listView.setAdapter(new LazyNewsAdapter(this, newsData));

    }

    @Override
    public void onDestroy()
    {
        listView.setAdapter(null);
        super.onDestroy();
    }

    @Override
    public void onBackPressed() {
        Intent intent = new Intent(this, MainActivity.class);
        startActivity(intent);
    }
    private ArrayList<News> getNewsData(String src) {
        ArrayList<News> listData = new ArrayList<News>();
        String ntitle = new String();
        String ndate = new String();
        String nimage = new String();
        String nurl = new String();
        String ndescription = new String();


        try {
            StringReader sr = new StringReader(src);
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            factory.setNamespaceAware(true);
            XmlPullParser xpp = factory.newPullParser();
            xpp.setInput(sr);

            int eventType = xpp.getEventType();

            while (eventType != XmlPullParser.END_DOCUMENT) {
                String name = null;
                switch(eventType) {
                    case XmlPullParser.START_TAG :
                        name = xpp.getName();

                        if(name.equals("ntitle")) {
                            ntitle = xpp.nextText();
                            ntitle = ntitle.trim();
                        }
                        else if(name.equals("ndate")) {
                            ndate = xpp.nextText();
                            ndate = ndate.trim();
                        }
                        else if(name.equals("nimage")) {
                            nimage = xpp.nextText();
                            nimage = nimage.trim();
                            nurl = "http://branko-cirovic.appspot.com/etcapp/news/images/" + nimage;
                        }
                        else if(name.equals("ndescription")) {
                            ndescription = xpp.nextText();
                            ndescription = ndescription.trim();

                            News n = new News();
                            n.setNewsTitle(ntitle);
                            n.setNewsDate(ndate);
                            n.setNewsUrl(nurl);
                            n.setNewsDescription(ndescription);
                            listData.add(n);
                        }
                        break;
                }
                eventType = xpp.next();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return listData;
    }
}
