<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/1/18
  Time: 20:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="author" content="order by dede58.com"/>
    <title>用户注册</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    function getPic(){
        $("#checkCode").attr("src","${pageContext.request.contextPath}/user/checkCode.do?flag="+Math.random());
    };

    $(function () {
        //为输入框绑定事件
        $("#username").blur(function () {
            //1.失去焦点后获取输入框内容
            var usernameInput = $(this).val();
            //2.去服务器校验用户名是否存在--ajax
            if (usernameInput!=""){
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/findUsername.do",
                    async:true,
                    type:"POST",
                    data: "username="+usernameInput,
                    success:function (data) {
                        if (data=="true"){
                            $("#uname").css("color","red");
                            $("#uname").html("该用户名已存在");
                        } else{
                            $("#uname").css("color","green");
                            $("#uname").html("该用户名可使用");
                        }
                    },dataType:"text"
                });
            } else{
                $("#uname").css("color","red");
                $("#uname").html("用户名不能为空");
            }
        });

        $("#password").blur(function () {
            var psw = $("#password").val();
            if (psw.length<6){
                $("#psw").css("color","red");
                $("#psw").html("密码应大于6位");
            } else{
                $("#psw").css("color","green");
                $("#psw").html("✔");
            }
        });

        $("#repassword").blur(function () {
            var psw = $("#password").val();
            var pswt = $("#repassword").val();
            if (psw!=pswt){
                $("#pswt").css("color","red");
                $("#pswt").html("两次密码输入不一致");
            } else{
                $("#pswt").css("color","green");
                $("#pswt").html("✔");
            }
        });

        $("#phone").blur(function () {
           var phone = $(this).val();
           if (phone!=""){
               $.post(
                   "${pageContext.request.contextPath}/user/findUserPhone.do",
                   {"phone":phone},
                   function (data) {
                       if (data=="0"){
                           $("#ph").css("color","red");
                           $("#ph").html("该手机号已使用过！");
                       } else if (data=="1"){
                           $("#ph").css("color","green");
                           $("#ph").html("✔");
                       } else {
                           $("#ph").css("color","red");
                           $("#ph").html("手机号格式错误!");
                       }
                   },"text"
               )
           }else {
               $("#ph").css("color","red");
               $("#ph").html("手机号不能为空!");
           }
        });

        $("#sub").click(function () {
            var uname = document.getElementById("uname").innerHTML;;
            var psw = document.getElementById("psw").innerHTML;
            var pswt = document.getElementById("pswt").innerHTML;
            var phone = document.getElementById("ph").innerHTML;
            var form = document.getElementById("form1");
            if (uname=="该用户名可使用" && psw=="✔" && pswt=="✔" && phone=="✔") {
                form.submit();
            }else{
                alert("信息有误，注册失败");
            }
       });
    });
</script>
<body>
<form  method="post" action="${pageContext.request.contextPath}/user/register.do" id="form1">
    <div class="regist">
        <div class="regist_center">
            <div class="regist_top">
                <div class="left fl">会员注册</div>
                <div class="right fr"><a href="${pageContext.request.contextPath}/index.jsp" target="_self">小米商城</a></div>
                <div class="clear"></div>
                <div class="xian center"></div>
            </div>
            <div class="regist_main center">
                <div class="username">用&nbsp;&nbsp;户&nbsp;&nbsp;名:&nbsp;&nbsp;<input class="shurukuang" type="text" name="username" id="username" placeholder="请输入你的用户名"/><span>请不要输入空格</span><span id="uname" name="uname"></span></div>
                <div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="shurukuang" type="password" id="password" name="password" placeholder="请输入你的密码"/><span>请输入6位以上字符</span><span id="psw" name="psw"></span></div>

                <div class="username">确认密码:&nbsp;&nbsp;<input class="shurukuang" type="password" name="repassword" id="repassword" placeholder="请确认你的密码"/><span>两次密码要输入一致哦</span><span id="pswt" name="pswt"></span></div>
                <div class="username">手&nbsp;&nbsp;机&nbsp;&nbsp;号:&nbsp;&nbsp;<input class="shurukuang" type="text" name="phone" id="phone" placeholder="请填写正确的手机号"/><span>填写下手机号吧，方便我们联系您！</span></span><span id="ph" name="ph"></span></div>
                <div class="username">
                    <div class="left fl">验&nbsp;&nbsp;证&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="yanzhengma" type="text" name="yzm" placeholder="请输入验证码"/></div>
                    <div class="right fl"><img src="${pageContext.request.contextPath}/user/checkCode.do" id="checkCode" title="看不清，点击换一张" alt="" width="100" height="32" class="center-block" style="height:43px;cursor:pointer;" onclick="getPic()"/></div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="regist_submit">
                <input class="submit" type="button" name="sub" id="sub" value="立即注册" >
            </div>
        </div>
    </div>
</form>
</body>
</html>
