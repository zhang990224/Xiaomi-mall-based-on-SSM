<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/1/31
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小米商城-商品详情</title>
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<body>
<jsp:include page="header.jsp" />
<!-- xiangqing -->
<form action="post" method="">
    <div class="xiangqing">
        <div class="neirong w">
            <nav class="fr">
                <li><a href="${pageContext.request.contextPath}/category/disCategoryItemById.do?id=${cid}">概述</a></li>
                <li>|</li>
                <li>|</li>
                <li style="font-weight: bold"><a href="${pageContext.request.contextPath}/category/disComment.do?page=1&cid=${cid}">用户评价</a></li>
                <div class="clear"></div>
            </nav>
            <div class="clear"></div>
        </div>
    </div>
    <div class="jieshao mt20 w">
        <div class="left fl" style="width: 562px;height: 562px"><img  id="cimg" src="${pageContext.request.contextPath}/${categories.img}" style="width: 562px;height: 562px"></div>
        <div class="right fr">
            <h3>
                全部 <span>（${allnum}）</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                好评 <span>（${hnum}）</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                中评 <span>（${znum}）</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                差评 <span>（${bnum}）</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </h3>
            <br>
            <ul>
                <c:forEach items="${all.list}" var="comment">
                    <span style="font-size: 17px">（${comment.co_level}）${comment.co_content}&nbsp;【${comment.order_item.category_item.cname}&nbsp;${comment.order_item.category_item.csize}&nbsp;${comment.order_item.category_item.ccolor}】</span>
                    <br><br>
                    <span style="font-size: 15px">${comment.ci_username}&nbsp;&nbsp;&nbsp;${comment.co_createtime}</span>
                    <br><hr/><br>
                </c:forEach>
            </ul>
            <div class="pagination">
                <!--  disablepage nextpage-->
                <ul>
                    <li>
                        <c:if test="${all.currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/category/disComment.do?page=${all.currentPage-1}&cid=${cid}">上一页</a>
                        </c:if>
                    </li>
                    当前第${all.currentPage}页/总${all.totalPage}页
                    <li>
                        <c:if test="${all.currentPage < all.totalPage}">
                            <a href="${pageContext.request.contextPath}/category/disComment.do?page=${all.currentPage+1}&cid=${cid}">下一页</a>
                        </c:if>
                    </li>
                </ul>
            </div>
        </div>
        </div>
        <div class="clear"></div>
    </div>
</form>
<br>
<jsp:include page="footer.jsp" />
</body>
</html>
