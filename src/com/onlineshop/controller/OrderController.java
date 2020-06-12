package com.onlineshop.controller;

import com.onlineshop.po.*;
import com.onlineshop.service.CategoryService;
import com.onlineshop.service.OrderService;
import com.onlineshop.utils.CreateOrderId;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/order")
public class OrderController {
    @Resource
    private OrderService orderService;
    @Resource
    private CategoryService categoryService;

    @RequestMapping("addOrder")
    public String AddOrder(Model model, HttpServletRequest request,String receiverA, String receiverN, String receiverP, int id[], int price){
        User user = (User)request.getSession().getAttribute("user");
        if (user!=null){
            CreateOrderId ci = new CreateOrderId();
            String order_id = (String) ci.doOrderNum();
            Order order = new Order();
            order.setUser_id(user.getId());
            order.setOrder_id(order_id);
            order.setPrice(price);
            order.setReceiverAddress(receiverA.trim());
            order.setReceiverName(receiverN.trim());
            order.setReceiverPhone(receiverP.trim());
            order.setArrivestate(0);
            order.setDeliverstate(0);
            order.setPaystate(0);
            orderService.insertOrder(order);
            Cart cart = new Cart();
            cart.setUser_id(user.getId());
            Order_item order_item = new Order_item();
            order_item.setCommentstate(0);
            for (int i = 0;i<id.length;i++){
                cart.setCi_id(id[i]);
                Cart cart1 = categoryService.findCartById(cart);
                order_item.setBuynum(cart1.getCi_num());
                order_item.setCi_id(id[i]);
                order_item.setOrder_id(order_id);
                order_item.setTotalprice(cart1.getCi_num()*cart1.getCi_price());
                orderService.insertOrderItem(order_item);
                Category_item categoryItem = new Category_item();
                categoryItem.setId(id[i]);
                categoryItem.setCcount(-cart1.getCi_num());
                categoryService.UpdateCcount(categoryItem);
                categoryService.DeleteCartById(cart);
            }
            HttpSession session = request.getSession();
            session.setAttribute("order_id",order_id);
            return "order_success";
        }else{
            model.addAttribute("result","未登录，操作错误");
            return "tishi";
        }
    }

    @RequestMapping("updatePayState")
    public String UpdatePayState(Model model, HttpServletRequest request,int paystate){
        User user = (User)request.getSession().getAttribute("user");
        String order_id = (String)request.getSession().getAttribute("order_id");
        if (user!=null){
            Order order = new Order();
            order.setOrder_id(order_id.trim());
            order.setPaystate(paystate);
            orderService.UpdatePayState(order);
            return "index";
        }else{
            model.addAttribute("result","未登录，操作错误");
            return "tishi";
        }
    }

    @RequestMapping("updatePState")
    public void updatePState(HttpServletRequest request, HttpServletResponse response,String order_id) throws IOException {
        User user = (User)request.getSession().getAttribute("user");
        System.out.println(order_id);
        if (user!=null){
            Order order = new Order();
            order.setOrder_id(order_id.trim());
            order.setPaystate(1);
            orderService.UpdatePayState(order);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("updateDState")
    public void updateDState(HttpServletRequest request, HttpServletResponse response,String order_id) throws IOException {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        System.out.println(order_id);
        if (admin!=null){
            Order order = new Order();
            order.setOrder_id(order_id.trim());
            order.setDeliverstate(1);
            orderService.UpdateDeliverState(order);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("updateAState")
    public void updateAState(HttpServletRequest request, HttpServletResponse response,String order_id) throws IOException {
        User user = (User)request.getSession().getAttribute("user");
        System.out.println(order_id);
        if (user!=null){
            Order order = new Order();
            order.setOrder_id(order_id.trim());
            order.setArrivestate(1);
            orderService.UpdateArriveState(order);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("disOrderById")
    public String DisOrderById(Model model, HttpServletRequest request,int page){
        User user = (User)request.getSession().getAttribute("user");
        if (user!=null){
            Pageresult<Order> orderPageresult = orderService.DisOrderById(user.getId(),page,4);
            System.out.println(orderPageresult);
            model.addAttribute("orders",orderPageresult);
            return "user_order";
        }else{
            model.addAttribute("result","未登录，操作错误");
            return "tishi";
        }
    }

    @RequestMapping("disOrderItemById")
    public String DisOrderItemById(Model model, HttpServletRequest request,int page,String order_id,int isuser){
        User user = (User)request.getSession().getAttribute("user");
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (user!=null || admin!=null){
            Pageresult<Order_item> orderPageresult = orderService.DisOrderItemById(order_id.trim(),page,4);
            Order order = orderService.FindOrderByOrderId(order_id.trim());
            model.addAttribute("orderitem",orderPageresult);
            model.addAttribute("orders",order);
            if (isuser==0){
                return "user_orderitem";
            }else{
                return "adminorderitem";
            }
        }else{
            model.addAttribute("result","未登录，操作错误");
            return "tishi";
        }
    }

    @RequestMapping("disOrder")
    public String DisOrder(Model model,HttpServletRequest request,int page,String order_id){
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            if (order_id.trim() == ""){
                int c = orderService.CountAllOrder();
                Pageresult<Order> orderPageresult = orderService.DisAllOrder(page,6);
                model.addAttribute("num",c);
                model.addAttribute("all",orderPageresult);
                model.addAttribute("order_id",order_id.trim());
            }else{
                int c = orderService.CountSearchOrder(order_id.trim());
                Pageresult<Order> orderPageresult = orderService.DisSearchOrder(order_id.trim(),page,6);
                model.addAttribute("num",c);
                model.addAttribute("all",orderPageresult);
                model.addAttribute("order_id",order_id.trim());
            }
            return "adminorder";
        }else{
            model.addAttribute("result","未登录");
            return "tishi";
        }
    }

    @RequestMapping("deleteOrder")
    public String DeleteOrder(Model model,HttpServletRequest request,String order_id){
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            orderService.DeleteOrder(order_id.trim());
            orderService.DeleteOrderItem(order_id.trim());
            return "redirect:disOrder.do?page=1&order_id=";
        }else{
            model.addAttribute("result","未登录");
            return "tishi";
        }
    }

    @RequestMapping("addComment")
    public void AddComment(HttpServletRequest request, HttpServletResponse response,int oiid,String content,String level) throws IOException {
        User user = (User)request.getSession().getAttribute("user");
        if (user!=null){
            Comment comment = new Comment();
            comment.setOi_id(oiid);
            comment.setCo_level(level.trim());
            comment.setCo_content(content.trim());
            comment.setCi_username(user.getUsername());
            orderService.AddComment(comment);
            Order_item order_item = new Order_item();
            order_item.setCommentstate(1);
            order_item.setOrderitem_id(oiid);
            orderService.UpdateCommentState(order_item);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("deleteCommentById")
    public void DeleteCommentById(HttpServletRequest request, HttpServletResponse response,int co_id) throws IOException {
        User user = (User)request.getSession().getAttribute("user");
        if (user!=null){
            orderService.DeleteCommentById(co_id);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }
}
