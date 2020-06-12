<%--
  Created by IntelliJ IDEA.
  User: fdg
  Date: 2020/2/12
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小米商城-订单中心</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style1.css">
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/framework.css">--%>
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
                    <li><a style="color:#ff6700;font-weight:bold;" href="${pageContext.request.contextPath}/order/disOrderById.do?page=1">我的订单</a></li>
                    <li><a href="${pageContext.request.contextPath}/${pageContext.request.contextPath}/category/disCommentByUname.do?page=1">评价晒单</a></li>
                </ul>
            </div>
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/user_msg.jsp">我的个人中心</a></li>
                </ul>
            </div>
        </div>
        <div >
            <table style="text-align: center;">
                <tr style="font-weight: bold;font-size: 20px;">
                    <th style="width: 80px;">序号</th>
                    <th style="width: 80px;"></th>
                    <th style="width: 300px;">商品信息</th>
                    <th style="width: 80px;">数量</th>
                    <th style="width: 100px;">操作</th>
                </tr>
                <c:forEach items="${orderitem.list}" var="orderitem" varStatus="o">
                    <tr>
                        <td style="height: 80px;border: 1px dashed;">${o.count}</td>
                        <td style="height: 80px;border: 1px dashed;"><img style="width:70px;height: 80px;" src="${pageContext.request.contextPath}/${orderitem.category_item.cimg}"></td>
                        <td style="height: 80px;border: 1px dashed;">${orderitem.category_item.cname}&nbsp;&nbsp;${orderitem.category_item.csize}&nbsp;&nbsp;${orderitem.category_item.ccolor}</td>
                        <td style="height: 80px;border: 1px dashed;">${orderitem.buynum}件</td>
                        <td style="height: 80px;border: 1px dashed;" class="commentstate">
                            <c:if test="${orders.arrivestate == 1}">
                                <c:if test="${orderitem.commentstate == 0}">
                                    <a href="#headmodal" class="modaltrigger" onclick="disoiid(${orderitem.orderitem_id},${o.count})">评论</a>
                                </c:if>
                                <c:if test="${orderitem.commentstate == 1}">已评论</c:if>
                            </c:if>
                            <c:if test="${orders.arrivestate == 0}">
                                收货后可评论
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
                <p style="margin-top: 30px;font-size: 20px;">
                    收货地址：<span style="width:350px;font-size: 16px;padding: 3px;">${orders.receiverAddress}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                    <br /> 收货人：&nbsp;&nbsp;&nbsp;
                    <span style="width:150px;font-size: 16px;padding: 3px;">${orders.receiverName}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                    <br /> 联系方式：<span style="width:150px;font-size: 16px;padding: 3px;">${orders.receiverPhone}</span>&nbsp;&nbsp;&nbsp;&nbsp;
                </p>
                <div style="font-size: 20px;">
                    <div>
                        <div>合计（不含运费）：<span style="font-weight: bold">${orders.price}元</span></div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                </div>
        </div>
</div>
    <div class="pagination">
        <!--  disablepage nextpage-->
        <ul>
            <li>
                <c:if test="${orderitem.currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=${orderitem.currentPage-1}&order_id=${orders.order_id}&isuser=0">上一页</a>
                </c:if>
            </li>
            当前第${orderitem.currentPage}页/总${orderitem.totalPage}页
            <li>
                <c:if test="${orderitem.currentPage < orderitem.totalPage}">
                    <a href="${pageContext.request.contextPath}/order/disOrderItemById.do?page=${orderitem.currentPage+1}&order_id=${orders.order_id}&isuser=0">下一页</a>
                </c:if>
            </li>
        </ul>
    </div>
<%--<footer class="mt20 center">--%>
    <%--<div class="mt20">小米商城|MIUI|米聊|多看书城|小米路由器|视频电话|小米天猫店|小米淘宝直营店|小米网盟|小米移动|隐私政策|Select Region</div>--%>
    <%--<div>©mi.com 京ICP证110507号 京ICP备10046444号 京公网安备11010802020134号 京网文[2014]0059-0009号</div>--%>
    <%--<div>违法和不良信息举报电话：185-0130-1238，本网站所列数据，除特殊说明，所有数据均出自我司实验室测试</div>--%>
<%--</footer>--%>
    <div id="headmodal" style="display:none;">
        <h3>添加评论:</h3><div style="display: none;"><span id="oiid"></span><span id="i"></span></div>
        <div>
            商品评价：<select name="cstar" id="cstar" style="width: 100px; height: 30px;margin-right: 70px;">
            <option value="好">好</option>
            <option value="中">中</option>
            <option value="差">差</option>
            </select>
        </div>
        <textarea class="uk-textarea" placeholder="评论不少于5个字" style=" height:100px;width:180px;padding: 5px;margin-top: 5px;margin-right: 10px" id="commenttext"></textarea>
        <a href="#" id="comment" onclick="subcomment()">添加评论</a>
    </div>
    <script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.leanModal.min.js"></script>
    <script type="text/javascript">
        $(function(){
            //弹出层调用语句
            $('.modaltrigger').leanModal({
                top:110,
                overlay:0.45,
                closeButton:"#comment",
                backdrop:'static',
                keyboard:false
            });
        });

        function disoiid(oid,i) {
            var oiid = document.getElementById("oiid");
            var ia = document.getElementById("i");
            oiid.innerHTML = oid;
            ia.innerHTML = i-1;
        }

        function subcomment() {
            var text = document.getElementById("commenttext").value;
            var oiid = document.getElementById("oiid").innerHTML;
            var ia = document.getElementById("i").innerHTML;
            var level = document.getElementById("cstar").value;
            var commentstate = document.getElementsByClassName("commentstate")[ia];
            if (text!="" && text.length>=5){
                if (level!=""){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/order/addComment.do",
                        async:"true",
                        type:"POST",
                        data:{"oiid":oiid,"content":text,"level":level},
                        success:function (data) {
                            if (data==1) {
                                commentstate.innerHTML="已评论";
                                text = "";
                                alert("评论成功!");
                            }else{
                                alert("未登录，操作失败");
                            }
                        },dataType:"text"
                    });
                }else {
                    alert("请选择评级");
                }
            } else{
                alert("评论不少于5个字");
            }
        }
    </script>
</body>
</html>
