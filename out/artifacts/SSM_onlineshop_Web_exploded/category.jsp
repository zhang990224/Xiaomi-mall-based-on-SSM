<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/1/26
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小米商城-商品列表</title>
</head>
<body>
<!-- start header -->
<jsp:include page="header.jsp" />
<!-- end header -->
<!-- start danpin -->
<div class="danpin center">
    <div class="biaoti center">${ctype}:共${num}件商品</div>
    <div style="display: inline-block;margin-left: 150px;">
        <a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=${ctype}&page=1&paixu=1">升序</a>
        &nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=${ctype}&page=1&paixu=2">降序</a></div>
    <div class="main center mb20"  style="width: 1240px;">
        <c:forEach items="${category.list}" var="category" varStatus="ca">
        <div class="mingxing fl mb20" style="margin-right: 14px;border:2px solid #fff;width:230px;cursor:pointer;" onmouseout="this.style.border='2px solid #fff'" onmousemove="this.style.border='2px solid red'">
            <div class="sub_mingxing"><a href="${pageContext.request.contextPath}/category/disCategoryItemById.do?id=${category.id}" target="_blank"><img src="${pageContext.request.contextPath}/${category.img}" alt=""></a></div>
            <div class="pinpai"><a href="${pageContext.request.contextPath}/category/disCategoryItemById.do?id=${category.id}" target="_blank">${category.cname}</a></div>
            <div class="youhui">${category.cdiscount}</div>
            <div class="jiage">${category.cpricel}元</div>
        </div>
        </c:forEach>
    </div>
</div>
<div class="pagination" style="margin-top: 375px">
    <!--  disablepage nextpage-->
    <ul>
            <li>
                <c:if test="${category.currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=${ctype}&page=${category.currentPage-1}&paixu=${paixu}">上一页</a>
                </c:if>
            </li>
            <li>
                    当前第${category.currentPage}页/总${category.totalPage}页
            </li>
            <li>
                <c:if test="${category.currentPage < category.totalPage}">
                    <a href="${pageContext.request.contextPath}/category/disCategoryByCtype.do?ctype=${ctype}&page=${category.currentPage+1}&paixu=${paixu}">下一页</a>
                </c:if>
            </li>
    </ul>
</div>
<%--<jsp:include page="footer.jsp" />--%>
<!-- end danpin -->
</body>
</html>
