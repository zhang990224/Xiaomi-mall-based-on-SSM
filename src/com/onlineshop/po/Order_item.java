package com.onlineshop.po;

public class Order_item {

    private int orderitem_id;
    private String order_id;
    private int ci_id;//产品id
    private int buynum;//购买的数量
    private Order order;//订单
    private Category_item category_item;//产品
    private int totalprice;
    private int commentstate;//是否评论

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public int getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(int totalprice) {
        this.totalprice = totalprice;
    }

    public int getOrderitem_id() {
        return orderitem_id;
    }

    public void setOrderitem_id(int orderitem_id) {
        this.orderitem_id = orderitem_id;
    }

    public int getCi_id() {
        return ci_id;
    }

    public void setCi_id(int ci_id) {
        this.ci_id = ci_id;
    }

    public int getBuynum() {
        return buynum;
    }

    public void setBuynum(int buynum) {
        this.buynum = buynum;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Category_item getCategory_item() {
        return category_item;
    }

    public void setCategory_item(Category_item category_item) {
        this.category_item = category_item;
    }

    public int getCommentstate() {
        return commentstate;
    }

    public void setCommentstate(int commentstate) {
        this.commentstate = commentstate;
    }

    @Override
    public String toString() {
        return "Order_item{" +
                "orderitem_id=" + orderitem_id +
                ", order_id='" + order_id + '\'' +
                ", ci_id=" + ci_id +
                ", buynum=" + buynum +
                ", order=" + order +
                ", category_item=" + category_item +
                ", totalprice=" + totalprice +
                ", commentstate=" + commentstate +
                '}';
    }
}
