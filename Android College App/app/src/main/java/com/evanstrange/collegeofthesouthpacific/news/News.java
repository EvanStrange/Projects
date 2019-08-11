package com.evanstrange.collegeofthesouthpacific.news;

/**
 * Created by admin on 2018-07-20.
 */

import android.graphics.Bitmap;

public class News {
    private String newsTitle, newsDate, newsUrl, newsDescription;
    private Bitmap newsImage;

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getNewsTitle() {
        return this.newsTitle;
    }

    public void setNewsDate(String newsDate) {
        this.newsDate = newsDate;
    }

    public String getNewsDate() {
        return this.newsDate;
    }

    public void setNewsUrl(String newsUrl) {
        this.newsUrl = newsUrl;
    }

    public String getNewsUrl() {
        return this.newsUrl;
    }

    public void setNewsDescription(String newsDescription) {
        this.newsDescription = newsDescription;
    }

    public String getNewsDescription() {
        return this.newsDescription;
    }

    public void setNewsImage(Bitmap newsImage) {
        this.newsImage = newsImage;
    }

    public Bitmap getNewsImage() {
        return newsImage;
    }
}
