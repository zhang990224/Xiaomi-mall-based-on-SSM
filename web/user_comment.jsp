<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/3/10
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小米商城-评价晒单</title>
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
                    <li><a href="${pageContext.request.contextPath}/order/disOrderById.do?page=1" >我的订单</a></li>
                    <li><a href="${pageContext.request.contextPath}/category/disCommentByUname.do?page=1" style="color:#ff6700;font-weight:bold;">评价晒单</a></li>
                </ul>
            </div>
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href=${pageContext.request.contextPath}/user_msg.jsp">我的个人中心</a></li>
                </ul>
            </div>
        </div>
        <div style="margin-left: 20px">
            <div style="font-weight: bold;font-size: 20px;"> 共有${num}条评论</div>
            <table style=" text-align: center" >
                <tr>
                    <th style="width: 50px;">序号</th>
                    <th style="width: 150px;">用户</th>
                    <th style="width: 150px;">商品</th>
                    <th style="width: 80px;">评价</th>
                    <th style="width: 200px;">用户评论</th>
                    <th style="width: 100px;">操作</th>
                </tr>
                <c:forEach items="${all.list}" var="ct" varStatus="c">
                    <tr class="tr1">
                        <td style="height: 80px;border: 1px dashed;">${c.count}</td>
                        <td style="height: 80px;border: 1px dashed;">${ct.ci_username}</td>
                        <td style="height: 80px;border: 1px dashed;">${ct.order_item.category_item.cname}</td>
                        <td style="height: 80px;border: 1px dashed;">${ct.co_level}</td>
                        <td style="height: 80px;border: 1px dashed;">${ct.co_content}</td>
                        <td style="height: 80px;border: 1px dashed;" ><a href="#tishimodal1" class="modaltrigger" onclick="disC(${ct.co_id},${c.count})">删除</a></td>
                    </tr>
                </c:forEach>
                <tr>
                    <td style="height: 30px;">
                        <c:if test="${all.currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/category/disCommentByUname.do?page=${all.currentPage-1}">上一页</a>
                        </c:if>
                    </td>
                    当前第${all.currentPage}页/总${all.totalPage}页
                    <td style="height: 30px;">
                        <c:if test="${all.currentPage < all.totalPage}">
                            <a href="${pageContext.request.contextPath}/category/disCommentByUname.do?page=${all.currentPage+1}">下一页</a>
                        </c:if>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </div>
<div id="tishimodal1" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">是否确定要删除此条评论</p><div style="display: none"><span id="co"></span><span id="ci"></span></div>
    <input type="button" name="btn1" id="btn3" class="flatbtn-blu" value="确定" tabindex="1" onclick="deleteComment()">
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

    function disC(co_id,i) {
        var c = document.getElementById("co");
        var ci = document.getElementById("ci");
        c.innerHTML = co_id;
        ci.innerHTML = i-1;
    }

    function deleteComment() {
        var c = document.getElementById("co");
        var ci = document.getElementById("ci").innerHTML;
        var tr = document.getElementsByClassName("tr1")[ci];
        $.ajax({
            url:"${pageContext.request.contextPath}/order/deleteCommentById.do",
            type:"POST",
            async:"true",
            data:{"co_id":c.innerHTML},
            success:function (data) {
                if (data==1){
                    tr.style.display = "none";
                }else{
                    alert("未登录，操作失败");
                }
            },dataType:"text"
        });
    }
</script>
</body>
</html>
