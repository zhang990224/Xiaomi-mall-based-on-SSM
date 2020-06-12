package com.onlineshop.po;

public class Category {
    private int id;
    private String cname;
    private String ctype;
    private int cpricel;
    private int cpricem;
    private String cdiscount;
    private String introduce;
    private String img;
    private int issale;
    private Category_item category_item;

    public int getIssale() {
        return issale;
    }

    public void setIssale(int issale) {
        this.issale = issale;
    }

    public Category_item getCategory_item() {
        return category_item;
    }

    public void setCategory_item(Category_item category_item) {
        this.category_item = category_item;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCtype() {
        return ctype;
    }

    public void setCtype(String ctype) {
        this.ctype = ctype;
    }

    public int getCpricel() {
        return cpricel;
    }

    public void setCpricel(int cpricel) {
        this.cpricel = cpricel;
    }

    public int getCpricem() {
        return cpricem;
    }

    public void setCpricem(int cpricem) {
        this.cpricem = cpricem;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getCdiscount() {
        return cdiscount;
    }

    public void setCdiscount(String cdiscount) {
        this.cdiscount = cdiscount;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", cname='" + cname + '\'' +
                ", ctype='" + ctype + '\'' +
                ", cpricel=" + cpricel +
                ", cpricem=" + cpricem +
                ", cdiscount='" + cdiscount + '\'' +
                ", introduce='" + introduce + '\'' +
                ", img='" + img + '\'' +
                ", category_item=" + category_item +
                '}';
    }
}
