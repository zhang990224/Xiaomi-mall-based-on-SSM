package com.onlineshop.dao;

import com.onlineshop.po.Comment;
import com.onlineshop.po.Order;
import com.onlineshop.po.Order_item;
import com.onlineshop.po.Pageresult;

import java.util.List;

public interface OrderMapper {
    void insertOrder(Order order);

    void insertOrderItem(Order_item order_item);

    void UpdatePayState(Order order);

    void UpdateDeliverState(Order order);

    void UpdateArriveState(Order order);

    void UpdateCommentState(Order_item order_item);

    List<Order> DisOrderById(Pageresult pageresult);

    Order FindOrderByOrderId(String order_id);

    int CountOrderById(int user_id);

    List<Order_item> DisOrderItemById(Pageresult pageresult);
    void DeleteOrderItem(String order_id);
    void DeleteOrder(String order_id);
    int CountOrderItemById(String order_id);
    void DeleteCommentById(int co_id);
    void AddComment(Comment comment);
    int CountCommentByCid(int cid);
    int CountCommentByUname(String ci_username);
    int CountCommentByCidLevel(Comment comment);
    List<Comment> DisCommentByCid(Pageresult pageresult);
    List<Comment> DisCommentByUname(Pageresult pageresult);

    List<Order> DisAllOrder(Pageresult pageresult);
    int CountAllOrder();
    List<Order> DisSearchOrder(Pageresult pageresult);
    int CountSearchOrder(String order_id);
}
