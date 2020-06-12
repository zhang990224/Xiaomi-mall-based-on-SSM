<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/10
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小米商城-订单中心</title>
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/css/style1.css">
</head>
<body>
<!-- start header -->
<jsp:include page="header.jsp" />
<!-- end header -->
<div class="grzxbj">
    <div class="selfinfo center">
        <div class="lfnav fl">
            <div class="ddzx">订单中心</div>
            <div class="subddzx">
                <ul>
                    <li><a style="color:#ff6700;font-weight:bold;" href="${pageContext.request.contextPath}/order/disOrderById.do?page=1">我的订单</a></li>
                    <li><a href="${pageContext.request.contextPath}/${pageContext.request.contextPath}/category/disCommentByUname.do?page=1">评价晒单</a></li>
                </ul>
            </div>
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/user_msg.jsp">我的个人中心</a></li>
                </ul>
            </div>
        </div>
        <div class="rtcont fr">
            <div class="ddzxbt">交易订单（${orders.totalCount}）</div>
            <c:forEach items="${orders.list}" var="order" varStatus="o">
            <div class="ddxq">
                <div class="ddbh fl">订单号:${order.order_id}</div>
                <div class="ztxx fr">
                    <ul>
                        <li style="cursor: pointer" class="paystate" onclick="pay('${order.order_id}',${order.paystate},${o.count})">${order.paystate==0? '未支付' : '已支付'}</li>
                        <li>${order.deliverstate==0? '未发货' : '已发货'}
                            <c:if test="${order.deliverstate == 1}">
                                <div style="font-size: 15px;font-weight: bold;color: red;cursor: pointer;" class="arrive">
                                    <c:if test="${order.arrivestate==1}">
                                        <a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=1&order_id=${order.order_id}&isuser=0">可评论</a>
                                    </c:if>
                                    <c:if test="${order.arrivestate==0}">
                                        <a href="#tishimodal1" class="modaltrigger" onclick="disarrive('${order.order_id}',${o.count})">确定收货</a>
                                    </c:if>
                                    <c:if test="${order.arrivestate==2}">
                                        订单已完成
                                    </c:if>
                                </div>
                            </c:if>
                            <c:if test="${order.deliverstate == 0}">
                                <div style="font-size: 15px;font-weight: bold;color: red;cursor: pointer;" class="tixing" onclick="tixing('${order.order_id}',${o.count})">
                                    <a href="" >提醒发货</a>
                                </div>
                            </c:if>
                        </li>
                        <li>￥${order.price}</li>
                        <li>${order.createtime}</li>
                        <li><a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=1&order_id=${order.order_id}&isuser=0">订单详情></a></li>
                        <div class="clear"></div>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
    <div class="pagination">
        <!--  disablepage nextpage-->
        <ul>
            <li>
                <c:if test="${orders.currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/order/disOrderById.do?page=${orders.currentPage-1}">上一页</a>
                </c:if>
            </li>
            当前第${orders.currentPage}页/总${orders.totalPage}页
            <li>
                <c:if test="${orders.currentPage < orders.totalPage}">
                    <a href="${pageContext.request.contextPath}/order/disOrderById.do?page=${orders.currentPage+1}">下一页</a>
                </c:if>
            </li>
        </ul>
    </div>
</div>
<div id="tishimodal1" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">是否确定收货</p><div style="display: none"><span id="order_id"></span><span id="i"></span></div>
    <input type="button" name="btn1" id="btn1" class="flatbtn-blu" value="确定" tabindex="1" onclick="arrive()">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btn1" id="btn2" class="flatbtn-blu" value="取消" tabindex="2" >
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

    function pay(id,paystate,i) {
        var pay = document.getElementsByClassName("paystate")[i-1];
        if (paystate==0) {
            var open = prompt("输入支付密码（默认123）订单号："+id);
            if (open=="123") {
                $.ajax({
                    url:"${pageContext.request.contextPath}/order/updatePState.do",
                    type:"POST",
                    async:"true",
                    data:{"order_id":id},
                    success:function (data) {
                        if (data==1){
                            pay.innerHTML = "已支付";
                            alert("支付成功，正在为您保存支付订单");
                        }else{
                            alert("未登录，操作失败");
                        }
                    },dataType:"text"
                });
            }else{
                alert("密码错误！");
            }
        }else{
            alert("已完成支付");
        }
    }

    function disarrive(id,i) {
        var order_id = document.getElementById("order_id");
        var ia = document.getElementById("i");
        order_id.innerHTML = id;
        ia.innerHTML = i-1;
    }

    function tixing(id,i) {
        var ia = document.getElementsByClassName("tixing")[i-1];
        alert("已提醒商家，请耐心等待");
        ia.innerHTML = "已提醒";
    }
    
    function arrive() {
        var i = document.getElementById("i").innerHTML;
        var id = document.getElementById("order_id").innerHTML;
        var arrivestate = document.getElementsByClassName("arrive")[i];
            $.ajax({
                url:"${pageContext.request.contextPath}/order/updateAState.do",
                type:"POST",
                async:"true",
                data:{"order_id":id},
                success:function (data) {
                    if (data==1){
                        arrivestate.innerHTML = "可评论";
                    }else{
                        alert("未登录，操作失败");
                    }
                },dataType:"text"
            });
    }
</script>
</body>
</html>
