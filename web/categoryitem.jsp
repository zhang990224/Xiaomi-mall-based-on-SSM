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
<script>
    function SelectSize(i,cszie) {
        var size = document.getElementsByClassName("size");
        var size1 = document.getElementsByClassName("size")[i-1];
        var sz = document.getElementById("sz");
        for(var a=0;a<size.length;a++){
            var size2 = document.getElementsByClassName("size")[a];
            if (size2.style.border!=""){
                size2.style.border="";
            }
        }
        size1.style.border="1px solid #ff6700" ;
        sz.innerHTML = cszie;
    }
    function SelectColor(i,ccolor) {
        var color = document.getElementsByClassName("color");
        var color1 = document.getElementsByClassName("color")[i-1];
        var co = document.getElementById("co");
        for(var a=0;a<color.length;a++){
            var color2 = document.getElementsByClassName("color")[a];
            if (color2.style.border!=""){
                color2.style.border="";
            }
        }
        color1.style.border="1px solid #ff6700" ;
        co.innerHTML = ccolor;
    }

    function findCategory() {
        var sz = document.getElementById("sz");
        var co = document.getElementById("co");
        var nu = document.getElementById("nu");
        var pr = document.getElementById("pr");
        var img = document.getElementById("cimg");
        if (sz.innerHTML!="未选择" && co.innerHTML!="未选择"){
            $.ajax({
                url:"${pageContext.request.contextPath}/category/findCategotyBySC.do",
                type:"POST",
                async:true,
                data:{"csize":sz.innerHTML,"ccolor":co.innerHTML},
                success:function (data) {
                    var arr=data.split(",");
                    nu.innerHTML = arr[0];
                    pr.innerHTML = arr[1];
                    if (arr[0]!="商品已下架"){
                        img.src="${pageContext.request.contextPath}/"+arr[2];
                    }
                },error:function (){
                    alert("error");
                },dataType:"text"
            });
        }
    }

    function AddCart() {
        var sz = document.getElementById("sz");
        var co = document.getElementById("co");
        var nu = document.getElementById("nu");
        var pr = document.getElementById("pr");
        if (sz.innerHTML!="未选择" && co.innerHTML!="未选择" && nu.innerHTML!="商品已下架"){
            $.ajax({
                url:"${pageContext.request.contextPath}/category/addCart.do",
                type:"POST",
                async:true,
                data:{"csize":sz.innerHTML,"ccolor":co.innerHTML,"ci_num":1},
                success:function (data) {
                    alert(data);
                },error:function (){
                    alert("error");
                },dataType:"text"
            });
        }else{
            alert("加入购物车无效,请选择其他商品");
        }
    }

</script>
<body onload="findCategory()">
<jsp:include page="header.jsp" />
<!-- xiangqing -->
<form action="post" method="">
    <div class="xiangqing">
        <div class="neirong w">
            <nav class="fr">
                <li style="font-weight: bold"><a href="${pageContext.request.contextPath}/category/disCategoryItemById.do?id=${cid}">概述</a></li>
                <li>|</li>
                <li>|</li>
                <li><a href="${pageContext.request.contextPath}/category/disComment.do?page=1&cid=${cid}">用户评价</a></li>
                <div class="clear"></div>
            </nav>
            <div class="clear"></div>
        </div>
    </div>
    <div class="jieshao mt20 w">
        <div class="left fl" style="width: 562px;height: 562px"><img  id="cimg" src="${pageContext.request.contextPath}/${categories.img}" style="width: 562px;height: 562px"></div>
        <div class="right fr">
            <div class="h3 ml20 mt20">${categories.cname}</div>
            <div class="jianjie mr40 ml20 mt10">${categories.introduce}</div>
            <div class="jiage ml20 mt10">${categories.cpricel}元-${categories.cpricem}元</div>
            <div class="ft20 ml20 mt20">选择版本</div>
            <div class="xzbb ml20 mt10">

            <c:forEach items="${requestScope.categoryitems}" var="ci" varStatus="c">
                <div class="banben fl">
                    <div class="size" onclick="SelectSize(${c.count},'${ci.csize}');findCategory();">
                        <a href="#">
                            <span>${ci.csize}</span>
                            <span>${ci.cprice}元</span>
                        </a>
                    </div>
                </div>
            </c:forEach>
                <%--<div class="banben fr">--%>
                    <%--<a>--%>
                        <%--<span>全网通版 6GB+128GB</span>--%>
                        <%--<span>2899元</span>--%>
                    <%--</a>--%>
                <%--</div>--%>
                <div class="clear"></div>
            </div>
            <br><br><br>
            <div class="ft20 ml20 mt20">选择颜色</div>
            <div class="xzbb ml20 mt10">
            <c:forEach items="${requestScope.categorycolor}" var="ci" varStatus="c">
                <div class="banben" style="display: inline-block">
                    <div class="color" onclick="SelectColor(${c.count},'${ci.ccolor}');findCategory();">
                        <a>
                            <span class="yuandian"></span>
                            <span class="yanse">${ci.ccolor}</span>
                        </a>
                    </div>
                </div>
            </c:forEach>
            </div>
            <br>
            <div class="xqxq mt20 ml20">
                <div class="top1 mt10">
                    <div class="left1 fl">库存：<span id="nu">未选择</span></div>
                    <div class="right1 fr">内存选择：<span id="sz">未选择</span>&nbsp;&nbsp;|&nbsp;&nbsp;颜色选择：<span id="co">未选择</span></div>
                    <div class="clear"></div>
                </div>
                <div class="bot mt20 ft20 ftbc">总计：<span id="pr">0</span></div>
            </div>
            <div class="xiadan ml20 mt20">
                <input class="jrgwc"  type="button" name="jrgwc" value="立即选购" />
                <input class="jrgwc" type="button" name="jrgwc" value="加入购物车" onclick="AddCart()"/>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</form>
<br>
<jsp:include page="footer.jsp" />
</body>
</html>
