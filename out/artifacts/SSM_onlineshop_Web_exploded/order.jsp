<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/9
  Time: 22:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="order by dede58.com"/>
    <title>我的订单-小米商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<!-- start header -->
<!--end header -->
<!-- start banner_x -->
<div class="banner_x center">
    <a href="${pageContext.request.contextPath}/index.jsp" target="_blank"><div class="logo fl"></div></a>

    <div class="wdgwc fl ml40">我的购物车</div>
    <div class="wxts fl ml20">温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</div>
    <div class="dlzc fr">
        <ul>
            <li>
                <c:if test="${user.getUsername()!=null}">
                    <a href="${pageContext.request.contextPath}/user_msg.jsp" target="_blank">你好，${user.getUsername()}</a>
                </c:if>
                <c:if test="${user.getUsername()==null}">
                    <a href="${pageContext.request.contextPath}/user/returnLogin.do" target="_blank">未登录，请登录</a>
                </c:if>
            </li><li style="color: red">
            <c:if test="${user.getUsername()!=null}">
                <a href="${pageContext.request.contextPath}/user/cannelUser.do">【退出】</a>
            </c:if>
            </li>
            <li>|</li>
            <li><a href="${pageContext.request.contextPath}/register.jsp" target="_blank">注册</a></li>
        </ul>

    </div>
    <div class="clear"></div>
</div>
<div class="xiantiao"></div>
<form id="orderForm" action="${pageContext.request.contextPath}/CreateOrderServlet" method="post">
    <div class="gwcxqbj">
        <div class="gwcxd center">
            <div class="top2 center">
                <div class="sub_top fl">
                </div>
                <div class="sub_top fl">商品名称</div>
                <div class="sub_top fl">单价</div>
                <div class="sub_top fl">数量</div>
                <div class="sub_top fl">小计</div>
                <div class="clear"></div>
            </div>
            <c:set var="pricesum" value="0"></c:set>
            <c:forEach items="${carts}" var="cart" varStatus="v">
                <input type="text" value="${cart.ci_id}" class="cid" style="display: none;"/>
                <div class="content2 center">
                    <div class="sub_top fl" style="margin-right: 60px;">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                    <div class="sub_content fl"><img style="width:70px;height: 80px;" src="${pageContext.request.contextPath}/${cart.category_item.cimg}"></div>
                    <div class="sub_content fl ft20">${cart.category_item.cname}&nbsp;&nbsp;${cart.category_item.csize}&nbsp;&nbsp;${cart.category_item.ccolor}</div>
                    <div class="sub_content fl ">${cart.category_item.cprice}</div>
                    <div class="sub_content fl">${cart.ci_num}</div>
                    <div class="sub_content fl">${cart.category_item.cprice * cart.ci_num}</div>
                    <div class="clear"></div>
                </div>
                <c:set var="pricesum" value="${pricesum + cart.category_item.cprice * cart.ci_num}"></c:set>
            </c:forEach>
            <p style="margin-left: 50px;margin-top: 30px;">
                收货地址：<input name="receiverAddress" id="address" type="text" value="${user.getAddress()}" style="width:350px;font-size: 16px;padding: 3px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
                <br /> 收货人：&nbsp;&nbsp;&nbsp;
                <input name="receiverName" type="text" id="name" value="${user.getUsername()}" style="width:150px;font-size: 16px;padding: 3px;" />&nbsp;&nbsp;&nbsp;&nbsp;
                <br /> 联系方式：<input type="text" name="receiverPhone" id="phone" value="${user.getPhone()}" style="width:150px;font-size: 16px;padding: 3px;" />&nbsp;&nbsp;&nbsp;&nbsp;
            </p>
        </div>
        <div class="jiesuandan mt20 center">
            <div class="tishi fl ml20">
                <li style="margin-left: 50px"><span>温馨提示：个人收货信息初始默认</span></li>
                <div class="clear"></div>
            </div>
            <div class="jiesuan fr">
                <div class="jiesuanjiage fl">合计（不含运费）：<span>${pricesum} 元</span></div>
                <div class="jsanniu fr"><input class="jsan" type="button" name="jiesuan" onclick="submitOrder();" value="去结算"/></div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</form>
<script type="text/javascript">
    function submitOrder(){
        var id = new Array();
        var cid = document.getElementsByClassName("cid");
        var address = document.getElementById("address").value;
        var receivername = document.getElementById("name").value;
        var phone = document.getElementById("phone").value;
        for(var i = 0;i<cid.length;i++){
            id[i]=parseInt(cid[i].value);
        }
        if (address!="" && receivername!="" && phone!="") {
            location.href="${pageContext.request.contextPath}/order/addOrder.do?receiverA="+address+"&receiverN="+receivername+"&receiverP="+phone+"&id="+id+"&price="+${pricesum};
        }else{
            alert("请填写好收件人信息！")
        }
    }
</script>
</body>
</html>
