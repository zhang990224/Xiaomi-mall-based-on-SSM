<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/14
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>adminorder</title>
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/css/style1.css">
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
<script>
    function search() {
        var id = document.getElementById("search").value;
        location.href='${pageContext.request.contextPath}/order/disOrder.do?page=1&order_id='+id;
    }
</script>
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
    <div style="font-weight: bold;font-size: 22px;margin: 10px;">交易订单</div>
    <div style="margin-top: 15px;margin-left: 10px;">
            <input type="text" name="search" id="search" style="height: 30px;"/>
            <input type="button" value="搜索" id="sear" onclick="search()" style="height: 30px;width:50px;background-color: white;color: black;cursor: pointer;font-weight: bold;"/>
    </div>
    <div style="margin:10px;">
        <table style=" text-align: center" >
            <tr>
                <th style="width: 50px;">序号</th>
                <th style="width: 150px;">订单号</th>
                <th style="width: 100px;">支付状态</th>
                <th style="width: 100px;">订单状态</th>
                <th style="width: 100px;">支付金额</th>
                <th style="width: 200px;">下单时间</th>
                <th style="width: 100px;">下单用户</th>
                <th style="width: 100px;">订单详情</th>
                <th style="width: 100px;">操作</th>
            </tr>
            <c:forEach items="${all.list}" var="order" varStatus="o">
            <tr>
                <td style="height: 80px;border: 1px dashed;">${o.count}</td>
                <td style="height: 80px;border: 1px dashed;">${order.order_id}</td>
                <td style="height: 80px;border: 1px dashed;">${order.paystate==0? '未支付' : '已支付'}</td>
                <td class="deliver" style="height: 80px;border: 1px dashed;" onclick="disdeliver('${order.order_id}',${o.count})" >
                    <c:if test="${order.deliverstate==0}">
                        <a href="#tishimodal1" class="modaltrigger" style="text-decoration: none;">未发货</a>
                    </c:if>
                    <c:if test="${order.deliverstate==1}">已发货</c:if>
                </td>
                <td style="height: 80px;border: 1px dashed;">${order.price}</td>
                <td style="height: 80px;border: 1px dashed;">${order.createtime}</td>
                <td style="height: 50px;border: 1px dashed;">${order.user.username}</td>
                <td style="height: 50px;border: 1px dashed;"><a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=1&order_id=${order.order_id}&isuser=1">订单详情></a></td>
                <td style="height: 50px;border: 1px dashed;"><a href="#tishimodal2" class="modaltrigger" onclick="disdelete('${order.order_id}')">删除</a></td>
            </tr>
            </c:forEach>
        </table>
    <div style="width:1293px; margin-top: 10px;">
        <div class="pagination">
            <!--  disablepage nextpage-->
            <ul>
                <li>
                    <c:if test="${all.currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/order/disOrder.do?page=${all.currentPage-1}&order_id=${order_id}">上一页</a>
                    </c:if>
                </li>
                当前第${all.currentPage}页/总${all.totalPage}页
                <li>
                    <c:if test="${all.currentPage < all.totalPage}">
                        <a href="${pageContext.request.contextPath}/order/disOrder.do?page=${all.currentPage+1}&order_id=${order_id}">下一页</a>
                    </c:if>
                </li>
            </ul>
        </div>
    </div>
    </div>
    <div style="clear:both"></div>
</div>
<div id="tishimodal1" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">是否确定发货</p><div style="display: none"><span id="order_id"></span><span id="i"></span></div>
    <input type="button" name="btn1" id="btn1" class="flatbtn-blu" value="确定" tabindex="1" onclick="deliver()">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btn1" id="btn2" class="flatbtn-blu" value="取消" tabindex="2" >
</div>
<div id="tishimodal2" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">是否确定要删除此订单</p>
    <input type="button" name="btn1" id="btn3" class="flatbtn-blu" value="确定" tabindex="1" onclick="deleteOrder()">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btn1" id="btn4" class="flatbtn-blu" value="取消" tabindex="2" >
</div>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.leanModal.min.js"></script>
<script type="text/javascript">
    $(function(){
        //弹出层调用语句
        $('.modaltrigger').leanModal({
            top:110,
            overlay:0.45,
            closeButton:".flatbtn-blu",
            backdrop:'static',
            keyboard:false
        });
    });

    function disdeliver(id,i) {
        var order_id = document.getElementById("order_id");
        var ia = document.getElementById("i");
        order_id.innerHTML = id;
        ia.innerHTML = i-1;
    }

    function disdelete(id) {
        var order_id = document.getElementById("order_id");
        order_id.innerHTML = id;
    }

    function deleteOrder() {
        var order_id = document.getElementById("order_id");
        if (order_id.innerHTML!=""){
            location.href="${pageContext.request.contextPath}/order/deleteOrder.do?order_id="+order_id.innerHTML;
        } else{
            alert("没有选择订单");
        }
    }

    function deliver() {
        var i = document.getElementById("i").innerHTML;
        var id = document.getElementById("order_id").innerHTML;
        var deliverstate = document.getElementsByClassName("deliver")[i];
        alert(deliverstate.innerHTML);
        if (deliverstate.innerHTML!="已发货"){
            alert(id);
            $.ajax({
                url:"${pageContext.request.contextPath}/order/updateDState.do",
                type:"POST",
                async:"true",
                data:{"order_id":id},
                success:function (data) {
                    if (data==1){
                        deliverstate.innerHTML = "已发货";
                    }else{
                        alert("未登录，操作失败");
                    }
                },dataType:"text"
            });
        } else {
            alert("该订单已发货")
        }
    }
</script>

</body>
</html>
