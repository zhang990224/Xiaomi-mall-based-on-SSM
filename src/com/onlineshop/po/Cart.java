package com.onlineshop.po;

public class Cart {
    private int cart_id;
    private int user_id;
    private int ci_id;
    private int ci_num;
    private int ci_price;
    private Category_item category_item;

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getCi_id() {
        return ci_id;
    }

    public void setCi_id(int ci_id) {
        this.ci_id = ci_id;
    }

    public int getCi_num() {
        return ci_num;
    }

    public void setCi_num(int ci_num) {
        this.ci_num = ci_num;
    }

    public int getCi_price() {
        return ci_price;
    }

    public void setCi_price(int ci_price) {
        this.ci_price = ci_price;
    }

    public Category_item getCategory_item() {
        return category_item;
    }

    public void setCategory_item(Category_item category_item) {
        this.category_item = category_item;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cart_id=" + cart_id +
                ", user_id=" + user_id +
                ", ci_id=" + ci_id +
                ", ci_num=" + ci_num +
                ", ci_price=" + ci_price +
                ", category_item=" + category_item +
                '}';
    }
}
