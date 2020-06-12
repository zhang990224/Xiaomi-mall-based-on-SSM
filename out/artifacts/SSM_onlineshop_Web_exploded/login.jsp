<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/1/18
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="order by dede58.com"/>
    <title>会员登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/css/style1.css">
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    function getPic(){
        $("#checkCode").attr("src","${pageContext.request.contextPath}/user/checkCode.do?flag="+Math.random());
    };

    $(function () {
        $("#login").click(function () {
            var uname = document.getElementById("username").value;;
            var psw = document.getElementById("password").value;
            var yzm = document.getElementById("yzm").value;
            var form = document.getElementById("form1");
            if (uname!="" && psw!="" && yzm!="") {
                form.submit();
            }else{
                alert("内容不能为空");
            }
        });
    });
</script>
<body>
<!-- login -->
<div class="top center">
    <div class="logo center">
        <a href="${pageContext.request.contextPath}/user/returnIndex.do" target="_blank"><img src="${pageContext.request.contextPath}/image/mistore_logo.png" alt=""></a>
    </div>
</div>
<form  method="post" action="${pageContext.request.contextPath}/user/login.do" class="form center" id="form1">
    <div class="login">
        <div class="login_center">
            <div class="login_top">
                <div class="left fl">会员登录</div>
                <div class="right fr">您还不是我们的会员？<a href="${pageContext.request.contextPath}/register.jsp" target="_self">立即注册</a></div>
                <div class="clear"></div>
                <div class="xian center"></div>
            </div>
            <div class="login_main center">
                <div class="username">用户名:&nbsp;<input class="shurukuang" type="text" name="username" placeholder="请输入你的用户名" id="username"/></div>
                <div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;<input class="shurukuang" type="password" name="password" placeholder="请输入你的密码" id="password"/></div>
                <div class="username">
                    <div class="left fl">验证码:&nbsp;<input class="yanzhengma" type="text" name="yzm" placeholder="请输入验证码" id="yzm"/></div>
                    <div class="right fl"><img src="${pageContext.request.contextPath}/user/checkCode.do" id="checkCode" title="看不清，点击换一张" alt="" width="100" height="32" class="center-block" style="height:43px;cursor:pointer;" onclick="getPic()"/></div>
                    <div class="clear"></div>
                </div>
                <a href="#headmodal" class="modaltrigger" target="_self" style="font-weight: bold;font-size: 14px;color: black;">忘记密码</a>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath}/admin_login.jsp" style="font-weight: bold;font-size: 14px;color: black;">管理→</a>
            </div>
            <div class="login_submit">
                <input class="submit" type="button" name="login" value="立即登录" id="login" >
            </div>

        </div>
    </div>
</form>
<footer>
    <div class="copyright">简体 | 繁体 | English | 常见问题</div>
    <div class="copyright">小米公司版权所有-京ICP备10046444-<img src="${pageContext.request.contextPath}/image/ghs.png" alt="">京公网安备11010802020134号-京ICP证110507号</div>
</footer>
<div id="headmodal" style="display:none;">
    <span style="font-size: 18px;font-weight: bold;">忘记密码</span>
    <br><br>
    <span style="font-size: 15px;font-weight: bold;">用户名：</span><input type="text" name="username1" id="username1" placeholder="请输入用户名" class="addinput">
    <span style="font-size: 15px;font-weight: bold;">手机号：</span><input id="phone" name="phone" placeholder="请输入手机号" class="addinput">
    <br>
    <a href="#" class="modaltrigger" id="go" onclick="findUser()" style="font-size: 15px;font-weight: bold;">下一步</a>（点击多次直到有提示。）
</div>
<div id="headmodal2" style="display:none;">
    <div id="exist">
        <span style="font-size: 18px;font-weight: bold;">重置密码</span>
        <br>
        <span style="font-size: 15px;font-weight: bold;">设置密码：</span><input type="password" class="addinput" name="psw1" id="psw1">
        <span style="font-size: 15px;font-weight: bold;">确定密码：</span><input type="password" class="addinput" name="psw2" id="psw2">
        <input type="button" name="updatePsw" id="updatePsw" class="flatbtn-blu" value="确定" tabindex="1" onclick="updatePsw()">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" name="quxiao" id="quxiao" class="flatbtn-blu" value="取消" tabindex="2">
    </div>
    <div id="noexist" style="display: none;text-align: center;">
        <span style="font-size: 15px;font-weight: bold;">用户不存在！</span>
    </div>
    <div style="display: none;">
        <span id="ema"></span>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.leanModal.min.js"></script>
<script type="text/javascript">
    $(function(){
        //弹出层调用语句
        $('.modaltrigger').leanModal({
            top:110,
            overlay:0.45,
            closeButton:"#quxiao",
            backdrop:'static',
            keyboard:false
        });
    });

    function findUser() {
        var username1 = document.getElementById("username1");
        var phone = document.getElementById("phone");
        var exist = document.getElementById("exist");
        var noexist = document.getElementById("noexist");
        var gonext = document.getElementById("go");
        var ema = document.getElementById("ema");
        if (username1.value!="" && phone.value!=""){
            $.ajax({
                url:"${pageContext.request.contextPath}/user/findUserBack.do",
                async:true,
                type:"POST",
                data: {"username":username1.value,"phone":phone.value},
                success:function (data) {
                    if (data==1) {
                        exist.style.display="block";
                        noexist.style.display="none";
                        ema.innerHTML = username1.value;
                        gonext.href = "#headmodal2";
                    }else{
                        noexist.style.display="block";
                        exist.style.display="none";
                        gonext.href = "#headmodal2";
                    }
                },
                error:function () {
                    alert("请求失败");
                },
                dataType:"text"
            });
        }else{
            alert("填写内容不能为空！");
        }
    }

    function updatePsw() {
        var psw1 = document.getElementById("psw1");
        var psw2 = document.getElementById("psw2");
        var ema = document.getElementById("ema");
        if (psw1.value!="" && psw2.value!=""){
            if (psw1.value == psw2.value){
                if (psw1.value.length>=6){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/user/resetUserPsw.do",
                        async:true,
                        type:"POST",
                        data: {"psw":psw1.value,"username":ema.innerHTML},
                        success:function (data) {
                            psw1.value == "";
                            psw2.value == "";
                            alert(data);
                        },
                        error:function () {
                            alert("修改失败");
                        },
                        dataType:"text"
                    });
                } else{
                    alert("密码位数至少六位");
                }
            }else{
                alert("两次密码输入不一样");
            }
        } else{
            alert("密码不能为空");
        }
    }
</script>
</body>
</html>
