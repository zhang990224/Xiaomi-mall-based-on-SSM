package com.onlineshop.service;

import com.onlineshop.po.Comment;
import com.onlineshop.po.Order;
import com.onlineshop.po.Order_item;
import com.onlineshop.po.Pageresult;

import java.util.List;

public interface OrderService {
    void insertOrder(Order order);

    void insertOrderItem(Order_item order_item);

    void UpdatePayState(Order order);

    void UpdateDeliverState(Order order);

    void UpdateArriveState(Order order);

    void UpdateCommentState(Order_item order_item);

    Pageresult<Order> DisOrderById(int user_id, int page, int pageSize);
    Order FindOrderByOrderId(String order_id);
    int CountOrderById(int user_id);
    void DeleteOrderItem(String order_id);
    void DeleteOrder(String order_id);
    Pageresult<Order_item> DisOrderItemById(String order_id, int page, int pageSize);
    int CountOrderItemById(String order_id);
    //评论
    void DeleteCommentById(int co_id);
    void AddComment(Comment comment);
    int CountCommentByCid(int cid);
    int CountCommentByUname(String ci_username);
    Pageresult<Comment> DisCommentByUname(String ci_username,int page,int pageSize);
    int CountCommentByCidLevel(Comment comment);
    Pageresult<Comment> DisCommentByCid(int cid,int page,int pageSize);

    Pageresult<Order> DisAllOrder(int page,int pageSize);
    int CountAllOrder();
    Pageresult<Order> DisSearchOrder(String order_id,int page,int pageSize);
    int CountSearchOrder(String order_id);
}
