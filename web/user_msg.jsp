<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/1/22
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小米商城-个人中心</title>
</head>
<body>
<!-- start header -->
<jsp:include page="header.jsp" />
<!-- end header -->
<!-- self_info -->
<div class="grzxbj">
    <div class="selfinfo center">
        <div class="lfnav fl">
            <div class="ddzx">订单中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/order/disOrderById.do?page=1" >我的订单</a></li>
                    <li><a href="${pageContext.request.contextPath}/category/disCommentByUname.do?page=1">评价晒单</a></li>
                </ul>
            </div>
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/user_msg.jsp" style="color:#ff6700;font-weight:bold;">我的个人中心</a></li>
                </ul>
            </div>
        </div>
        <div class="rtcont fr">
            <div class="grzlbt ml40">我的资料</div>
            <div class="subgrzl ml40"><span >昵称</span><span>${user.getUsername()}</span></div>
            <div class="subgrzl ml40"><span>手机号</span><span>${user.getPhone()}</span></div>
            <div class="subgrzl ml40"><span>密码</span><span>******</span><span><a href="#headmodal" class="modaltrigger">修改</a></span></div>
            <div class="subgrzl ml40"><span>个性签名</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="sign" value="${user.getSignature()}" style="display: inline-block;font-size: 15px;width: 710px;height: 45px;line-height: 45px;padding-left: 20px;"></div>
            <div class="subgrzl ml40"><span>我的爱好</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="hobby" value="${user.getHobby()}" style="display: inline-block;font-size: 15px;width: 710px;height: 45px;line-height: 45px;padding-left: 20px;"></div>
            <div class="subgrzl ml40"><span>所在地</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="address" value="${user.getAddress()}" style="display: inline-block;font-size: 15px;width: 710px;height: 45px;line-height: 45px;padding-left: 20px;"></div>
            <input type="button" style="margin-left: 40px;margin-top: 10px;margin-bottom: 10px;" name="updateall" id="updateall" class="flatbtn-blu" value="保存" onclick="baocun()">
        </div>
        <div class="clear"></div>
    </div>
</div>
<div id="headmodal" style="display:none;">
    <h4>修改密码</h4>
    <h4>旧密码：</h4>
    <input type="password" class="addinput" name="contact" id="oldp" placeholder="输入旧密码"/>
    <h4>新密码：</h4>
    <input type="password" class="addinput" name="contact" id="newp" placeholder="输入新密码"/>
    <input type="button" name="updatepsw" id="updatepsw" class="flatbtn-blu" value="修改" onclick="UpdatePsw()">
    <span id="ts" style="font-weight: bold;"></span>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.leanModal.min.js"></script>
<script type="text/javascript">
    $(function(){
        //弹出层调用语句
        $('.modaltrigger').leanModal({
            top:110,
            overlay:0.45,
            //closeButton:"#quxiao",
            backdrop:'static',
            keyboard:false
        });
    });

    function baocun() {
        var sign = document.getElementById("sign");
        var hobby = document.getElementById("hobby");
        var address = document.getElementById("address");
        $.ajax({
            url:"${pageContext.request.contextPath}/user/updateUserMsg.do",
            async:true,
            type:"POST",
            data: {"sign":sign.value,"hobby":hobby.value,"address":address.value},
            success:function (data) {
                alert(data);
            },
            error:function () {
                alert("保存失败");
            },dataType:"text"
        });
    }

    function UpdatePsw() {
        var oldp = document.getElementById("oldp");
        var newp = document.getElementById("newp");
        var ts = document.getElementById("ts");
        if (oldp.value!="" && newp.value!="" ){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/updateUserPsw.do",
                async:true,
                type:"POST",
                data: {"oldp":oldp.value,"newp":newp.value},
                success:function (data) {
                    if (data=="修改成功"){
                        ts.style.color="green";
                        ts.innerHTML = data;
                        newp.value = "";
                        oldp.value = "";
                    }else{
                        ts.style.color="red";
                        ts.innerHTML = data;
                    }
                },
                error:function () {
                    alert("保存失败");
                },dataType:"text"
            });
        } else{
            ts.style.color="red";
            ts.innerHTML = "内容不能有空喔！";
        }
    }
</script>
</body>
</html>
