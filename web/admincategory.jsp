<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/14
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>admincategory</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style1.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style3.css">
</head>
<style>
    a{
        text-decoration: none;
        color: #999999;
        font-weight: bold;
    }
</style>
<body>
<div style="width:1472px;height: 30px;background-color: #000000;padding: 15px;">
    <div style="height: 30px;color: white;font-size: 16px;display: inline-block;">欢迎来到管理员界面，</div>
    <div style="width: 60px;height: 30px;color: white;font-size: 16px;display: inline-block;">${admin.getUsername()}</div>
    <div style="height: 30px;color: red;font-size: 16px;display: inline-block;"><a href="${pageContext.request.contextPath}/user/cannelAdmin.do">【安全退出】</a></div>
</div>
<div style="width: 200px;height:673px;border:double;text-align: center;float: left;">
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;"><a href="${pageContext.request.contextPath}/user/disUser.do?page=1&username=">用户管理</a></div>
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;font-size: 18px;"><a href="${pageContext.request.contextPath}/category/disCategory.do?page=1&cname=">商品管理</a></div>
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;"><a href="${pageContext.request.contextPath}/order/disOrder.do?page=1&order_id=">订单管理</a></div>
    <div style="margin-top: 30px;margin-right: 20px;font-weight: bold;"><a href="">业绩管理</a></div>
</div>
<div style="width: 1293px;height:673px;border:double;float: left;">
    <form action="${pageContext.request.contextPath}/category/insertCategory.do" method="post" id="forma" enctype="multipart/form-data">
        <div style="margin: 10px;">
            商品名称：<input type="text" name="cname" id="cname" style="height: 30px;margin-right: 10px"/>
            商品分类：<select name="ctype" id="ctype" style="width: 100px; height: 30px;margin-right: 70px;">
            <option value="小米手机">小米手机</option>
            <option value="红米">红米</option>
            <option value="平板·笔记本">平板·笔记本</option>
            <option value="电视">电视</option>
            <option value="盒子·影音">盒子·影音</option>
            <option value="路由器">路由器</option>
            <option value="智能硬件">智能硬件</option>
        </select>
            商品优惠：<input type="text" name="cdiscount" id="cdiscount" style="height: 30px;margin-right: 10px;"/>
        </div>
        <div style="margin:10px;">
            商品介绍：<input type="text" name="introduce" id="introduce" style="height: 30px;margin-right: 10px"/>
            商品价格：<input type="number" name="cprice" id="cprice" style="height: 30px;margin-right: 10px"/>
            上传图片：<input type="file" name="upload" id="upload" style="height: 30px;"/>
        </div>
        <div style="margin: 10px;">
            商品配置：<input type="text" name="csize" id="csize" style="height: 30px;margin-right: 10px"/>
            商品颜色：<input type="text" name="ccolor" id="ccolor" style="height: 30px;margin-right: 10px"/>
            商品库存：<input type="number" name="ccount" id="ccount" style="height: 30px;margin-right: 10px"/>
            <input type="button" value="上架" id="shang" onclick="jianyan()" style="height: 30px;width:50px;margin-left: 50px;background-color: white;color: black;cursor: pointer;font-weight: bold;"/>
            <span id="tishi" style="color: red;"></span>
        </div>
    </form>
<div style="clear:both"></div>
    <div style="margin-top: 15px;margin-left: 10px;">
            <input type="text" name="cname" id="search" style="height: 30px;"/>
            <input type="submit" value="搜索" id="sear"  style="height: 30px;width:50px;background-color: white;color: black;cursor: pointer;font-weight: bold;" onclick="search()"/>
            （有${num}件商品）
        </form>
    </div>
<div style="margin:10px;">
        <table style=" text-align: center" >
            <tr>
                <th style="width: 50px;">序号</th>
                <th style="width: 150px;">商品名称</th>
                <th style="width: 80px;">商品图片</th>
                <th style="width: 80px;">商品价格</th>
                <th style="width: 200px;">商品配置</th>
                <th style="width: 80px;">商品颜色</th>
                <th style="width: 100px;">商品库存</th>
                <th style="width: 100px;">商品状态</th>
                <th style="width: 100px;">操作</th>
            </tr>
            <c:forEach items="${all.list}" var="ca" varStatus="c">
            <tr>
                <td style="height: 80px;border: 1px dashed;">${c.count}</td>
                <td style="height: 80px;border: 1px dashed;"><a href="#headmodal" class="modaltrigger" onclick="DisCategory(${ca.cid},'${ca.category.img}',${ca.category.issale})">${ca.category.cname}</a></td>
                <td style="height: 80px;border: 1px dashed;"><a href="#headmodal1" class="modaltrigger" onclick="DisCategoryItem(${ca.id},'${ca.cimg}',${c.count})"><img src="${pageContext.request.contextPath}/${ca.cimg}" style="width: 70px;height: 70px;"></a></td>
                <td style="height: 80px;border: 1px dashed;" class="cp">${ca.cprice}</td>
                <td style="height: 80px;border: 1px dashed;" class="cs">${ca.csize}</td>
                <td style="height: 80px;border: 1px dashed;" class="cc">${ca.ccolor}</td>
                <td style="height: 50px;border: 1px dashed;" class="cco">${ca.ccount}</td>
                <td style="height: 50px;border: 1px dashed;">
                    <c:if test="${ca.category.issale==0}">
                        下架中
                    </c:if>
                    <c:if test="${ca.category.issale==1}">
                        上架中
                    </c:if>
                </td>
                <td style="height: 50px;border: 1px dashed;"><a href="#tishimodal1" class="modaltrigger" onclick="jiluciid(${ca.cid},${ca.id})">删除</a></td>
            </tr>
            </c:forEach>
            <tr>
                <td style="height: 30px;">
                    <c:if test="${all.currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/category/disCategory.do?page=${all.currentPage-1}&cname=${cname}">上一页</a>
                    </c:if>
                </td>
                当前第${all.currentPage}页/总${all.totalPage}页
                <td style="height: 30px;">
                    <c:if test="${all.currentPage < all.totalPage}">
                        <a href="${pageContext.request.contextPath}/category/disCategory.do?page=${all.currentPage+1}&cname=${cname}">下一页</a>
                    </c:if>
                </td>
            </tr>
        </table>
    </div>
</div><span id="cid" style="display: none;"></span><span id="sale" style="display: none;"></span>
</div><span id="which" style="display: none;"></span><span id="ia" style="display: none;"></span>
<div id="headmodal" style="display:none;">
    <h3>商品信息：<span id="categoryname" style="font-weight: bold;font-size: 18px;"></span></h3>
    <div>
        商品分类：<select name="type" id="type" style="width: 100px; height: 30px;margin-right: 70px;">
        <option value="小米手机">小米手机</option>
        <option value="红米">红米</option>
        <option value="平板·笔记本">平板·笔记本</option>
        <option value="电视">电视</option>
        <option value="盒子·影音">盒子·影音</option>
        <option value="路由器">路由器</option>
        <option value="智能硬件">智能硬件</option></select>
    </div>
    商品价格：<input type="number" name="cpricel" id="cpricel" style="height: 30px;width:55px;"/>
    - <input type="number" name="cpricem" id="cpricem" style="height: 30px;width:55px;margin-right: 10px"/>
    <br>
    商品封面：<img src="" id="fengmian" style="width: 80px;height: 80px;">&nbsp;<a href="#headmodal2" class="modaltrigger" id="genggai">更改</a><br>
    商品优惠：<br>
    <textarea class="uk-textarea" style=" height:100px;width:180px;padding: 5px;margin-top: 5px;margin-right: 10px" id="discount"></textarea><br>
    商品介绍：<br>
    <textarea class="uk-textarea" style=" height:100px;width:180px;padding: 5px;margin-top: 5px;margin-right: 10px" id="intro"></textarea>
    <a href="#" id="baocun" onclick="UpdateCategory()">保存</a>&nbsp;&nbsp;
    <a href="#" id="xiajia" onclick="UpdateCategorySale()">下架</a>
</div>
<div id="headmodal1" style="display:none;">
    <h3>商品详情：<span id="ciname" style="font-weight: bold;font-size: 18px;"></span></h3>
    商品配置：<input type="text" name="size" id="size" style="height: 30px;margin-right: 10px"/><br>
    商品颜色：<input type="text" name="color" id="color" style="height: 30px;margin-right: 10px"/><br>
    商品库存：<input type="number" name="count" id="count" style="height: 30px;margin-right: 10px"/><br>
    商品价格：<input type="number" name="pricez" id="pricez" style="height: 30px;width:55px;"/><br>
    商品图片：<img src="" id="picture" style="width: 80px;height: 80px;">&nbsp;<a href="#headmodal2" class="modaltrigger" id="genggai1">更改</a>&nbsp;&nbsp;&nbsp;
    <a href="#" id="baocun1" onclick="UpdateCategoryItem()">保存</a>&nbsp;&nbsp;
</div>
<div id="headmodal2" style="display:none;">
    <h2>图片修改</h2>
    <form id="headform" name="headform" method="post" action="#">
        <img style="width: 100px;height: 100px;" id="imghead" src="" alt="">
        <input type="file" id="uploadhead" name="uploadhead"  tabindex="1" class="flatbtn-blu hidemodal" style="width: 100px;margin-left:20px;margin-right:10px;display: inline-block;" onchange="returnHead()">
        <input type="button" name="uploadbtn" id="uploadbtn" class="flatbtn-blu hidemodal" value="保存" tabindex="2" onclick="saveHead()">
        <span id="hi" style="display: none"></span>
        <br>
        <span style="font-size:12px;">提示:若图片名含特殊字符可能会导致更换失败</span>
    </form>
</div>
<div id="tishimodal1" style="display:none;">
    <p style="font-size: 16px;font-weight: bold;">是否确定要删除此商品</p><div style="display: none"><span id="c_id"></span><span id="ci_id"></span></div>
    <input type="button" name="btn1" id="btn3" class="flatbtn-blu" value="确定" tabindex="1" onclick="deleteCategory()">
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
            closeButton:"#btn4",
            backdrop:'static',
            keyboard:false
        });
    });

    function jiluciid(c_id,ci_id) {
        var cid = document.getElementById("c_id");
        var ciid = document.getElementById("ci_id");
        cid.innerHTML = c_id;
        ciid.innerHTML = ci_id;

    }

    function deleteCategory() {
        var ciid = document.getElementById("ci_id");
        var cid = document.getElementById("c_id");
        if (ciid.innerHTML!="" && cid.innerHTML!=""){
            location.href="${pageContext.request.contextPath}/category/deleteCategory.do?cid="+cid.innerHTML+"&ciid="+ciid.innerHTML;
        }else{
            alert("没有选择可删除的商品");
        }
    }

    function jianyan() {
        var cname = document.getElementById("cname").value;
        var cprice = document.getElementById("cprice").value;
        var cdiscount = document.getElementById("cdiscount").value;
        var introduce = document.getElementById("introduce").value;
        var img = document.getElementById("upload").value;
        var ccount = document.getElementById("ccount").value;
        var csize = document.getElementById("csize").value;
        var ccolor = document.getElementById("ccolor").value;
        var ctype = document.getElementById("ctype").value;
        var tishi = document.getElementById("tishi");
        if(cname==""||cprice==""||cdiscount==""||introduce==""||ccolor==""||img==""||ccount==""||csize==""||ctype==""){
            alert("内容不能有空的喔，不正规操作！")
        }else{
            $.ajax({
                url:"${pageContext.request.contextPath}/category/IsExistCategory.do",
                async:true,
                type:"POST",
                data: {"cname":cname,"ctype":ctype,"csize":csize,"ccolor":ccolor},
                success:function (data) {
                    if (data!=3){
                        document.getElementById("forma").submit();
                        tishi.style.color="green";
                        tishi.innerHTML="上架成功！";
                    }else {
                        tishi.style.color="red";
                        tishi.innerHTML="该商品已存在，可直接修改内容";
                    }
                },
                error:function () {
                    alert("上传失败");
                },
                dataType:"text"
            });

        }
    }

    function search() {
        var cname = document.getElementById("search").value;
        location.href='${pageContext.request.contextPath}/category/disCategory.do?page=1&cname='+cname;
    }

    function DisCategory(id,head,issale){
        var cname = document.getElementById("categoryname");
        var pricel = document.getElementById("cpricel");
        var pricem = document.getElementById("cpricem");
        var cdiscount = document.getElementById("discount");
        var introduce = document.getElementById("intro");
        var img = document.getElementById("fengmian");
        var xiajia = document.getElementById("xiajia");
        var sale = document.getElementById("sale");
        var cid = document.getElementById("cid");
        var imghead = document.getElementById("imghead");
        var which = document.getElementById("which");
        imghead.src="${pageContext.request.contextPath}/"+head;
        cid.innerHTML = id;
        sale.innerHTML = issale;
        which.innerHTML = "1";
        if (sale.innerHTML == 0){
            xiajia.innerHTML = "下架";
        }else{
            xiajia.innerHTML = "上架";
        }
        $.ajax({
            url:"${pageContext.request.contextPath}/category/returnCategory.do",
            async:true,
            type:"POST",
            data: {"cid":id},
            success:function (data) {
                var da = data.split(",");
                if (da[0]!=0){
                    cname.innerHTML = da[0];
                    var selected=da[1];
                    $("#type").find("option").each(function(){
                        if($(this).text() == selected)	{
                            $(this).attr("selected",true);
                        }
                    });
                    cdiscount.value = da[2];
                    introduce.value = da[3];
                    img.src="${pageContext.request.contextPath}/"+da[4];
                    pricel.value = da[5];
                    pricem.value = da[6];
                }else {
                    alert("没有权限，未登录")
                }
            },
            error:function () {
                alert("失败");
            },
            dataType:"text"
        });
    }

    function DisCategoryItem(id,head,i){
        var cname = document.getElementById("ciname");
        var ia = document.getElementById("ia");
        var img = document.getElementById("picture");
        var cid = document.getElementById("cid");
        var csize = document.getElementById("size");
        var ccolor = document.getElementById("color");
        var cprice = document.getElementById("pricez");
        var ccount = document.getElementById("count");
        var imghead = document.getElementById("imghead");
        var which = document.getElementById("which");
        imghead.src="${pageContext.request.contextPath}/"+head;
        cid.innerHTML = id;
        ia.innerHTML = i-1;
        which.innerHTML = "2";
        $.ajax({
            url:"${pageContext.request.contextPath}/category/returnCategoryItem.do",
            async:true,
            type:"POST",
            data: {"cid":id},
            success:function (data) {
                var da = data.split(",");
                if (da[0]!=0){
                    cname.innerHTML = da[0];
                    csize.value = da[1];
                    ccolor.value = da[2];
                    ccount.value = da[3];
                    img.src="${pageContext.request.contextPath}/"+da[4];
                    cprice.value = da[5];
                }else {
                    alert("没有权限，未登录")
                }
            },
            error:function () {
                alert("失败");
            },
            dataType:"text"
        });
    }

    function UpdateCategorySale(){
        var xiajia = document.getElementById("xiajia");
        var sale = document.getElementById("sale").innerHTML;
        var cid = document.getElementById("cid").innerHTML;
            $.ajax({
                url:"${pageContext.request.contextPath}/category/updateCategorySale.do",
                async:true,
                type:"POST",
                data: {"cid":cid,"issale":sale},
                success:function (data) {
                    if (data==1){
                        if (xiajia.innerHTML=="下架"){
                            xiajia.innerHTML == "上架";

                        }else{
                            xiajia.innerHTML == "下架";
                        }alert("状态修改成功");
                    }else {
                        alert("没有权限，未登录")
                    }
                },
                error:function () {
                    alert("保存失败");
                },
                dataType:"text"
            });
    }

    function UpdateCategory(){
        var cname = document.getElementById("categoryname").innerHTML;
        var pricel = document.getElementById("cpricel").value;
        var pricem = document.getElementById("cpricem").value;
        var cdiscount = document.getElementById("discount").value;
        var introduce = document.getElementById("intro").value;
        var ctype = document.getElementById("type").value;
        var cid = document.getElementById("cid").innerHTML;
        if (cname!=""&&cdiscount!=""&&ctype!=""&&pricem!=""&&pricel!=""&&introduce!=""){
            $.ajax({
                url:"${pageContext.request.contextPath}/category/updateCategory.do",
                async:true,
                type:"POST",
                data: {"cid":cid,"cname":cname,"ctype":ctype,"cdiscount":cdiscount,"introduce":introduce,"cpricel":pricel,"cpricem":pricem},
                success:function (data) {
                    if (data==1){
                        alert("保存成功");
                    }else {
                        alert("没有权限，未登录")
                    }
                },
                error:function () {
                    alert("保存失败");
                },
                dataType:"text"
            });
        } else{
            alert("保存内容不能为空");
        }
    }

    function UpdateCategoryItem(){
        var cname = document.getElementById("ciname").innerHTML;
        var ia = document.getElementById("ia").innerHTML;
        var cid = document.getElementById("cid").innerHTML;
        var csize = document.getElementById("size").value;
        var ccolor = document.getElementById("color").value;
        var cprice = document.getElementById("pricez").value;
        var ccount = document.getElementById("count").value;
        var cs = document.getElementsByClassName("cs");
        var cp = document.getElementsByClassName("cp");
        var cc = document.getElementsByClassName("cc");
        var cco = document.getElementsByClassName("cco");
        if (cname!=""&&csize!=""&&ccolor!=""&&cprice!=""&&ccount!=""){
            $.ajax({
                url:"${pageContext.request.contextPath}/category/updateCategoryItem.do",
                async:true,
                type:"POST",
                data: {"cid":cid,"cname":cname,"csize":csize,"ccolor":ccolor,"cprice":cprice,"ccount":ccount},
                success:function (data) {
                    if (data==1){
                        cs[ia] = csize;
                        cc[ia] = ccolor;
                        cp[ia] = cprice;
                        cco[ia] = ccount;
                        alert("保存成功");
                    }else {
                        alert("没有权限，未登录")
                    }
                },
                error:function () {
                    alert("保存失败");
                },
                dataType:"text"
            });
        } else{
            alert("保存内容不能为空");
        }
    }

    function returnHead() {
        var formData = new FormData();
        var file = $('#uploadhead')[0].files[0];
        formData.append("upload",file);
        var head = document.getElementById("imghead");
        var hi = document.getElementById("hi");
        $.ajax({
            url:"${pageContext.request.contextPath}/category/returnHead.do",
            async:true,
            processData: false,   // jQuery不要去处理发送的数据
            contentType: false,   // jQuery不要去设置Content-Type请求头
            type:"POST",
            data: formData,
            success:function (data) {
                head.src="${pageContext.request.contextPath}/"+data;
                hi.innerHTML = data;
            },
            error:function () {
                alert("更新失败");
            },
            dataType:"text"
        });
    }

    function saveHead() {
        var categoryhead = document.getElementById("fengmian");
        var categoryitemhead = document.getElementById("picture");
        var hi = document.getElementById("hi").innerHTML;
        var cid = document.getElementById("cid").innerHTML;
        var which = document.getElementById("which").innerHTML;
        $.ajax({
            url:"${pageContext.request.contextPath}/category/updateHead.do",
            async:true,
            type:"POST",
            data: {"cid":cid,"head":hi,"which":which},
            success:function (data) {
                if (which==1){
                    categoryhead.src = "${pageContext.request.contextPath}/"+hi;
                }else{
                    categoryitemhead.src = "${pageContext.request.contextPath}/"+hi;
                }
                alert(data);
            },
            error:function () {
                alert("更新失败");
            },
            dataType:"text"
        });
    }

</script>
</body>
</html>
