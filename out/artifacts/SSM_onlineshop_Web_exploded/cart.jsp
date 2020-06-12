<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/3
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="order by dede58.com"/>
    <title>我的购物车-小米商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/css/style1.css">
</head>
<body>
<!-- start header -->
<!--end header -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    function changeNum(id,cnum,i,pr) {
        var price = document.getElementsByClassName("price")[i-1];
        var number = document.getElementsByClassName("shuliang")[i-1];
        $.ajax({
            url:"${pageContext.request.contextPath}/category/updateCart.do",
            type:"POST",
            async:"true",
            data:{"ci_id":id,"ci_num":cnum},
            success:function (data) {
                if (data==1) {
                    price.innerHTML = (pr * cnum);
                }else{
                    alert("不能购买大于库存的数量");
                    number.value = cnum-1;
                }
            },dataType:"text"
        });
    }
    
    function selectAll() {
        var all = document.getElementsByClassName("quanxuan")[0];
        var dan = document.getElementsByClassName("danxuan");
        var price = document.getElementsByClassName("price");
        var totalprice = 0;
        var allPrice = document.getElementById("totalPrice");
        if (all.checked) {
            for (var a = 0;a<dan.length;a++){
                dan[a].checked = false;
            }
            for (var i = 0;i<price.length;i++){
                totalprice = totalprice +  parseInt(price[i].innerHTML);
                allPrice.innerHTML = totalprice + " 元";
            }
        }else{
            allPrice.innerHTML = "0";
        }
    }

    function selectDan() {
        var all = document.getElementsByClassName("quanxuan")[0];
        var dan = document.getElementsByClassName("danxuan");
        var price = document.getElementsByClassName("price");
        var totalprice = 0;
        var checked = 0;
        var allPrice = document.getElementById("totalPrice");
        for (var a = 0;a<dan.length;a++){
            if (dan[a].checked) {
                totalprice = totalprice +  parseInt(price[a].innerHTML);
                allPrice.innerHTML = totalprice + " 元";
                all.checked = false;
                checked++;
            }
            if (checked==0){
                allPrice.innerHTML = 0 + " 元";
            }
        }
    }

    function addOrder() {
        var dan = document.getElementsByClassName("danxuan");
        var all = document.getElementsByClassName("quanxuan")[0];
        var checked = 0;
        var id=new Array();
        if (all.checked){
            id[0] = 0;
            if (dan.length>0){
                location.href = "${pageContext.request.contextPath}/category/addOrder.do?isall=1&id="+id;
            }
        } else{
            for (var a = 0;a<dan.length;a++){
                if (dan[a].checked) {
                    id[checked] = dan[a].value;
                    checked++;
                }
                if(a==dan.length-1){
                    if (checked>0){
                        location.href = "${pageContext.request.contextPath}/category/addOrder.do?isall=2&id="+id;
                    }else{
                        alert("没有选择购物车中任何商品");
                    }
                }
            }
        }
    }
</script>
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
<div class="gwcxqbj">
    <div class="gwcxd center">
        <div class="top2 center">
            <div class="sub_top fl">
            <input type="checkbox" value="quanxuan" class="quanxuan" onclick="selectAll()"/>全选
        </div>
            <div class="sub_top fl">商品名称</div>
            <div class="sub_top fl">单价（元）</div>
            <div class="sub_top fl">数量</div>
            <div class="sub_top fl">小计（元）</div>
            <div class="sub_top fr">操作</div>
            <div class="clear"></div>
        </div>
        <%--<c:set var="pricesum" value="0"></c:set>--%>
        <c:forEach items="${carts}" var="cart" varStatus="c">
        <div class="cart">
            <div class="content2 center">
                    <div class="sub_content fl ">
                        <input type="checkbox" value="${cart.ci_id}" class="danxuan" onclick="selectDan()" />
                    </div>
                    <div class="sub_content fl"><img style="width:70px;height: 80px;" src="${pageContext.request.contextPath}/${cart.category_item.cimg}"></div>
                    <div class="sub_content fl ft20">${cart.category_item.cname}&nbsp;&nbsp;${cart.category_item.csize}&nbsp;&nbsp;${cart.category_item.ccolor}</div>
                    <div class="sub_content fl ">${cart.ci_price}</div>
                    <div class="sub_content fl">
                        <input class="shuliang" type="number" min="1" onchange="changeNum(${cart.ci_id},this.value,${c.count},${cart.ci_price});" value=${cart.ci_num}>
                    </div>
                    <div class="sub_content fl"><div class="price">${cart.ci_price * cart.ci_num}</div></div>
                    <div class="sub_content fl"><a href="#tishimodal1" class="modaltrigger" onclick="disC(${cart.ci_id},${c.count})">×</a></div>
                    <div class="clear"></div>
            </div>
        </div>

            <%--<c:set var="pricesum" value="${pricesum + entry.key.cprice * entry.value}"></c:set>--%>
        </c:forEach>
    </div>
    <div class="jiesuandan mt20 center">
        <div class="tishi fl ml20">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">|继续购物|</a></li>
                <div class="clear"></div>
            </ul>
        </div>
        <div class="jiesuan fr">
            <div class="jiesuanjiage fl">合计（不含运费）：<span id="totalPrice">0 元</span></div>
            <div class="jsanniu fr"><a href="#tishimodal2" class="modaltrigger" ><input class="jsan" type="button" name="jiesuan"  value="去结算"/></a></div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</div>
<br>
<div id="tishimodal1" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">是否从购物车移除该商品</p><div style="display: none"><span id="ci_id"></span><span id="ic"></span></div>
    <input type="button" name="btn1" id="btn1" class="flatbtn-blu" value="确定" tabindex="1" onclick="deleteCart()">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" name="btn1" id="btn2" class="flatbtn-blu" value="取消" tabindex="2" >
</div>
<div id="tishimodal2" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">确定是否提交选择的商品</p><div style="display: none"></div>
    <input type="button" name="btn1" id="btn3" class="flatbtn-blu" value="确定" tabindex="1" onclick="addOrder()">
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

    function disC(ci_id,i) {
        var c = document.getElementById("ci_id");
        var ic = document.getElementById("ic");
        c.innerHTML = ci_id;
        ic.innerHTML = i-1;
    }

    function deleteCart() {
        var c = document.getElementById("ci_id");
        var ic = document.getElementById("ic").innerHTML;
        var cart = document.getElementsByClassName("cart")[ic];
        $.ajax({
            url:"${pageContext.request.contextPath}/category/deleteCart.do",
            type:"POST",
            async:"true",
            data:{"ci_id":c.innerHTML},
            success:function (data) {
                if (data==1){
                    cart.style.display = "none";
                }else{
                    alert("未登录，操作失败");
                }
            },dataType:"text"
        });
    }
</script>
</body>
</html>
