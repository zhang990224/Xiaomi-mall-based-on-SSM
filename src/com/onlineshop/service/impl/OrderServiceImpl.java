package com.onlineshop.service.impl;

import com.onlineshop.dao.OrderMapper;
import com.onlineshop.po.Comment;
import com.onlineshop.po.Order;
import com.onlineshop.po.Order_item;
import com.onlineshop.po.Pageresult;
import com.onlineshop.service.OrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Resource
    private OrderMapper orderMapper;

    @Override
    public void insertOrder(Order order) {
        orderMapper.insertOrder(order);
    }

    @Override
    public void insertOrderItem(Order_item order_item) {
        orderMapper.insertOrderItem(order_item);
    }

    @Override
    public void UpdatePayState(Order order) {
        orderMapper.UpdatePayState(order);
    }

    @Override
    public void UpdateDeliverState(Order order) {
        orderMapper.UpdateDeliverState(order);
    }

    @Override
    public void UpdateArriveState(Order order) {
        orderMapper.UpdateArriveState(order);
    }

    @Override
    public void UpdateCommentState(Order_item order_item) {
        orderMapper.UpdateCommentState(order_item);
    }

    @Override
    public Pageresult<Order> DisOrderById(int user_id, int page, int pageSize) {
        Pageresult<Order> pr = new Pageresult<>();
        int totalCount = orderMapper.CountOrderById(user_id);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setUser_id(user_id);
        p.setStart(start);
        p.setPageCount(pageSize);
        List<Order> orderList = orderMapper.DisOrderById(p);
        pr.setList(orderList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public Order FindOrderByOrderId(String order_id) {
        Order order = orderMapper.FindOrderByOrderId(order_id);
        return order;
    }

    @Override
    public int CountOrderById(int user_id) {
        int c = orderMapper.CountOrderById(user_id);
        return c;
    }

    @Override
    public void DeleteOrderItem(String order_id) {
        orderMapper.DeleteOrderItem(order_id);
    }

    @Override
    public void DeleteOrder(String order_id) {
        orderMapper.DeleteOrder(order_id);
    }

    @Override
    public Pageresult<Order_item> DisOrderItemById(String order_id, int page, int pageSize) {
        Pageresult<Order_item> pr = new Pageresult<>();
        int totalCount = orderMapper.CountOrderItemById(order_id);
        int totalPage = (int)Math.ceil(totalCount * 1.0/pageSize);
        int start = (page-1)*pageSize;
        int currentPage = page;
        Pageresult p = new Pageresult();
        p.setOrder_id(order_id);
        p.setStart(start);
        p.setPageCount(pageSize);
        List<Order_item> order_items = orderMapper.DisOrderItemById(p);
        pr.setList(order_items);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(currentPage);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountOrderItemById(String order_id) {
        int c = orderMapper.CountOrderItemById(order_id);
        return c;
    }

    @Override
    public void DeleteCommentById(int co_id) {
        orderMapper.DeleteCommentById(co_id);
    }

    @Override
    public void AddComment(Comment comment) {
        orderMapper.AddComment(comment);
    }

    @Override
    public int CountCommentByCid(int cid) {
        int c = orderMapper.CountCommentByCid(cid);
        return c;
    }

    @Override
    public int CountCommentByUname(String ci_username) {
        int c = orderMapper.CountCommentByUname(ci_username);
        return c;
    }

    @Override
    public Pageresult<Comment> DisCommentByUname(String ci_username, int page, int pageSize) {
        Pageresult<Comment> pr = new Pageresult<>();
        int totalCount = orderMapper.CountCommentByUname(ci_username);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setStart(start);
        p.setPageCount(pageSize);
        p.setUsername(ci_username);
        List<Comment> comments = orderMapper.DisCommentByUname(p);
        pr.setList(comments);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountCommentByCidLevel(Comment comment) {
        int c = orderMapper.CountCommentByCidLevel(comment);
        return c;
    }

    @Override
    public Pageresult<Comment> DisCommentByCid(int cid, int page, int pageSize) {
        Pageresult<Comment> pr = new Pageresult<>();
        int totalCount = orderMapper.CountCommentByCid(cid);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setStart(start);
        p.setPageCount(pageSize);
        p.setCid(cid);
        List<Comment> comments = orderMapper.DisCommentByCid(p);
        pr.setList(comments);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public Pageresult<Order> DisAllOrder(int page, int pageSize) {
        Pageresult<Order> pr = new Pageresult<>();
        int totalCount = orderMapper.CountAllOrder();
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setStart(start);
        p.setPageCount(pageSize);
        List<Order> orderList = orderMapper.DisAllOrder(p);
        pr.setList(orderList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountAllOrder() {
        int c = orderMapper.CountAllOrder();
        return c;
    }

    @Override
    public Pageresult<Order> DisSearchOrder(String order_id, int page, int pageSize) {
        Pageresult<Order> pr = new Pageresult<>();
        int totalCount = orderMapper.CountSearchOrder(order_id);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setOrder_id(order_id);
        p.setStart(start);
        p.setPageCount(pageSize);
        List<Order> orderList = orderMapper.DisSearchOrder(p);
        pr.setList(orderList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountSearchOrder(String order_id) {
        int c = orderMapper.CountSearchOrder(order_id);
        return c;
    }
}
