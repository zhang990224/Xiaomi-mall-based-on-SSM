<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/1/22
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="order by dede58.com"/>
    <title>小米商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/css/style1.css">
</head>
<script>
    function search() {
        var cname = document.getElementById("cname").value;
        location.href='${pageContext.request.contextPath}/SearchCategoryServlet?cname='+cname+'&page=1&paixu=0';
    }
</script>
<body>
<!-- start header -->
<header>
    <div class="top center">
        <div class="left fl">
            <ul>
                <li><a href="http://www.mi.com/" target="_blank">小米商城</a></li>
                <li>|</li>
                <li><a href="">MIUI</a></li>
                <li>|</li>
                <li><a href="">米聊</a></li>
                <li>|</li>
                <li><a href="">游戏</a></li>
                <li>|</li>
                <li><a href="">多看阅读</a></li>
                <li>|</li>
                <li><a href="">云服务</a></li>
                <li>|</li>
                <li><a href="">金融</a></li>
                <li>|</li>
                <li><a href="">小米商城移动版</a></li>
                <li>|</li>
                <li><a href="">问题反馈</a></li>
                <li>|</li>
                <li><a href="">Select Region</a></li>
                <div class="clear"></div>
            </ul>
        </div>
        <div class="right fr">
            <a href="${pageContext.request.contextPath}/category/disCartById.do"><div class="gouwuche fr">购物车</div></a>
            <div class="fr">
                <ul>
                    <li>
                        <c:if test="${user.getUsername()!=null}">
                            <a href="${pageContext.request.contextPath}/user_msg.jsp" target="_blank">你好，${user.getUsername()}</a>
                        </c:if>
                        <c:if test="${user.getUsername()==null}">
                            <a href="${pageContext.request.contextPath}/user/returnLogin.do" target="_blank">未登录，请登录</a>
                        </c:if>
                    </li>
                    <li style="color: red">
                        <c:if test="${user.getUsername()!=null}">
                            <a href="${pageContext.request.contextPath}/user/cannelUser.do">【退出】</a>
                        </c:if>
                    </li>
                    <li>|</li>
                    <li><a href="${pageContext.request.contextPath}/register.jsp" target="_blank" >注册</a></li>
                    <li>|</li>
                    <li><a href="">消息通知</a></li>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</header>
<!--end header -->

<!-- start banner_x -->
<div class="banner_x center">
    <a href="./index.jsp" target="_blank"><div class="logo fl"></div></a>
    <a href=""><div class="ad_top fl"></div></a>
    <div class="nav fl">
        <ul>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=小米手机&page=1&paixu=0">小米手机</a></li>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=红米&page=1&paixu=0">红米</a></li>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=平板·笔记本&page=1&paixu=0">平板·笔记本</a></li>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=电视&page=1&paixu=0">电视</a></li>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=盒子·影音&page=1&paixu=0">盒子·影音</a></li>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=路由器&page=1&paixu=0">路由器</a></li>
            <li><a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=智能硬件&page=1&paixu=0">智能硬件</a></li>
            <li><a href="">服务</a></li>
            <li><a href="">社区</a></li>
        </ul>
    </div>
    <div class="search fr">
            <div class="text fl">
                <input type="text" class="shuru" name="cname" id="cname"  placeholder="小米6&nbsp;小米MIX现货">
            </div>
            <div class="submit fl">
                <input type="button" class="sousuo" value="搜索" onclick="search()"/>
            </div>
            <div class="clear"></div>
        <div class="clear"></div>
    </div>
</div>
<!-- end banner_x -->
</body>
</html>
