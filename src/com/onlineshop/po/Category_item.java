package com.onlineshop.po;

public class Category_item {
    private int id;
    private int cid;
    private String cname;
    private String csize;
    private String ccolor;
    private int ccount;
    private int cprice;
    private String cimg;
    private Category category;

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCsize() {
        return csize;
    }

    public void setCsize(String csize) {
        this.csize = csize;
    }

    public String getCcolor() {
        return ccolor;
    }

    public void setCcolor(String ccolor) {
        this.ccolor = ccolor;
    }

    public int getCcount() {
        return ccount;
    }

    public void setCcount(int ccount) {
        this.ccount = ccount;
    }

    public int getCprice() {
        return cprice;
    }

    public void setCprice(int cprice) {
        this.cprice = cprice;
    }

    public String getCimg() {
        return cimg;
    }

    public void setCimg(String cimg) {
        this.cimg = cimg;
    }

    @Override
    public String toString() {
        return "Category_item{" +
                "id=" + id +
                ", cid=" + cid +
                ", cname='" + cname + '\'' +
                ", csize='" + csize + '\'' +
                ", ccolor='" + ccolor + '\'' +
                ", ccount=" + ccount +
                ", cprice=" + cprice +
                ", cimg='" + cimg + '\'' +
                '}';
    }
}
