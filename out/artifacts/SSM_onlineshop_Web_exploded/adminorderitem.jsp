<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/15
  Time: 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>adminorderitem</title>
</head>
<style>
    a{text-decoration: none;
        color: #999999;
        font-weight: bold;}
    /*分页*/
    .pagination {
        padding: 5px;
        margin: 5px;
        text-align: center;
    }

    .pagination ul {
        margin: 5px;
        padding: 5px;
        font-size: 12px;
    }

    .pagination li {
        list-style-type: none;
        display: inline;
        padding: 1px;
        margin: 1px;
    }

    .pagination a,.pagination a:visited {
        padding: 5px;
        border: 1px solid #9aafe5;
        text-decoration: none;
        color: #2e6ab1;
    }

    .pagination a:hover,.pagination a:active {
        border: 1px solid #2b66a5;
        color: #000;
        background-color: lightyellow;
    }

    .pagination li.currentpage {
        font-weight: bold;
        padding: 5px;
        border: 1px solid navy;
        background-color: #2e6ab1;
        color: #FFF;
    }

    .pagination li.disablepage {
        padding: 5px;
        border: 1px solid #929292;
        color: #929292;
    }

    .pagination li.nextpage {
        font-weight: bold;
        padding: 5px;
    }
</style>
<body>
<div style="width:1472px;height: 30px;background-color: #000000;padding: 15px;">
    <div style="height: 30px;color: white;font-size: 16px;display: inline-block;">欢迎来到管理员界面，</div>
    <div style="width: 60px;height: 30px;color: white;font-size: 16px;display: inline-block;">${admin.getUsername()}</div>
    <div style="height: 30px;color: red;font-size: 16px;display: inline-block;"><a href="${pageContext.request.contextPath}/user/cannelAdmin.do">【安全退出】</a></div>
</div>
<div style="width: 200px;height:673px;border:double;text-align: center;float: left;">
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;"><a href="${pageContext.request.contextPath}/user/disUser.do?page=1&username=">用户管理</a></div>
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;"><a href="${pageContext.request.contextPath}/category/disCategory.do?page=1&cname=">商品管理</a></div>
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;font-size: 18px;"><a href="${pageContext.request.contextPath}/order/disOrder.do?page=1&order_id=">订单管理</a></div>
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;"><a href="">业绩管理</a></div>
</div>
<div style="width: 1293px;height:673px;border:double;float: left;">
    <div style="margin: 20px">
        <table style="text-align: center;">
            <tr style="font-weight: bold;font-size: 20px;">
                <th style="width: 80px;">序号</th>
                <th style="width: 80px;"></th>
                <th style="width: 300px;">商品信息</th>
                <th style="width: 80px;">数量</th>
            </tr>
        <c:forEach items="${orderitem.list}" var="order" varStatus="o">
            <tr>
                <td style="height: 80px;border: 1px dashed;">${o.count}</td>
                <td style="height: 80px;border: 1px dashed;"><img style="width:70px;height: 80px;" src="${pageContext.request.contextPath}/${order.category_item.cimg}"></td>
                <td style="height: 80px;border: 1px dashed;">${order.category_item.cname}&nbsp;&nbsp;${order.category_item.csize}&nbsp;&nbsp;${order.category_item.ccolor}</td>
                <td style="height: 80px;border: 1px dashed;">${order.buynum}件</td>
            </tr>
        </c:forEach>
        </table>
            <p style="margin-top: 30px;font-size: 20px;">
                收货地址：<span style="width:350px;font-size: 16px;padding: 3px;">${orders.receiverAddress}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <br /> 收货人：&nbsp;&nbsp;&nbsp;
                <span style="width:150px;font-size: 16px;padding: 3px;">${orders.receiverName}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                <br /> 联系方式：<span style="width:150px;font-size: 16px;padding: 3px;">${orders.receiverPhone}</span>&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
            <div style="font-size: 20px;">
                <div>
                    <div>合计（不含运费）：<span style="font-weight: bold">${orders.price}元</span></div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
            </div>
    </div>
    <div class="pagination">
        <!--  disablepage nextpage-->
        <ul>
            <li>
                <c:if test="${orderitem.currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=${orderitem.currentPage-1}&order_id=${orders.order_id}&isuser=1">上一页</a>
                </c:if>
            </li>
            当前第${orderitem.currentPage}页/总${orderitem.totalPage}页
            <li>
                <c:if test="${orderitem.currentPage < orderitem.totalPage}">
                    <a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=${orderitem.currentPage+1}&order_id=${orders.order_id}&isuser=1">下一页</a>
                </c:if>
            </li>
        </ul>
    </div>
</div>
<div style="clear:both"></div>
</body>
</html>

