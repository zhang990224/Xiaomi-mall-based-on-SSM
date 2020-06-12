package com.onlineshop.po;

import java.sql.Date;

public class Comment {
    private int co_id;
    private int oi_id;
    private int cid;
    private String ci_username;
    private String co_level;
    private String co_content;
    private Date co_createtime;
    private Order_item order_item;

    public Order_item getOrder_item() {
        return order_item;
    }

    public void setOrder_item(Order_item order_item) {
        this.order_item = order_item;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getCo_id() {
        return co_id;
    }

    public void setCo_id(int co_id) {
        this.co_id = co_id;
    }

    public int getOi_id() {
        return oi_id;
    }

    public void setOi_id(int oi_id) {
        this.oi_id = oi_id;
    }

    public String getCi_username() {
        return ci_username;
    }

    public void setCi_username(String ci_username) {
        this.ci_username = ci_username;
    }

    public String getCo_level() {
        return co_level;
    }

    public void setCo_level(String co_level) {
        this.co_level = co_level;
    }

    public String getCo_content() {
        return co_content;
    }

    public void setCo_content(String co_content) {
        this.co_content = co_content;
    }

    public Date getCo_createtime() {
        return co_createtime;
    }

    public void setCo_createtime(Date co_createtime) {
        this.co_createtime = co_createtime;
    }
}
