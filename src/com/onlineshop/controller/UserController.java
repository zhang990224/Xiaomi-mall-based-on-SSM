package com.onlineshop.controller;

import com.onlineshop.po.Admin;
import com.onlineshop.po.Pageresult;
import com.onlineshop.po.User;
import com.onlineshop.service.UserService;
import com.onlineshop.utils.RandomValidateCode;
import org.omg.PortableInterceptor.USER_EXCEPTION;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/user")
public class UserController{
    @Resource
    private UserService userService;

    //注册时验证username是否可用
    @RequestMapping("findUsername")
    public void findUserName(String username, HttpServletResponse response) throws IOException {
        int count = userService.findUserName(username.trim());
        if (count>0){
            response.getWriter().write("true");
        }else{
            response.getWriter().write("false");
        }
    }

    //注册时验证phone是否可用
    @RequestMapping("findUserPhone")
    public void findUserPhone(String phone, HttpServletResponse response) throws IOException {
        //定义手机号的规则
        String regex = "1[35789]\\d{9}"; //1表示 以 1开头；[57]表示第二位是 5或者 7  \\d[9]表示 还剩9位  总共11位
        //调用功能 判断
        boolean flag = phone.matches(regex);
        int count = userService.findUserPhone(phone.trim());
        if (flag){
            if (count>0){
                response.getWriter().write("0");
            }else{
                response.getWriter().write("1");
            }
        }else{
            response.getWriter().write("2");
        }
    }


    //注册
    @RequestMapping("register")
    public String Register(Model model,HttpServletRequest request, HttpServletResponse response, String username, String password, String phone, String yzm) throws IOException {
        String vaiidateCode = (String)request.getSession(true).getAttribute("code");
        if (vaiidateCode.trim().equalsIgnoreCase(yzm)){
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password.trim());
            user.setPhone(phone.trim());
            user.setSignature("用户很懒，没有填写");
            user.setHobby("用户很懒，没有填写");
            user.setAddress("用户很懒，没有填写");
            userService.insertUser(user);
            model.addAttribute("result","恭喜注册成功，3秒后跳转到登陆页面");
            //这里设置3秒钟之后进行跳转
            response.setHeader("refresh","3;url=returnLogin.do");
            return "tishi";
        }else{
            model.addAttribute("result","输入的验证码有误，3秒后跳转回注册页面");
            //这里设置3秒钟之后进行跳转
            response.setHeader("refresh","3;url=returnRegister.do");
            return "tishi";
        }
    }

    //注册
    @RequestMapping("login")
    public String login(Model model,HttpServletRequest request, HttpServletResponse response, String username, String password, String yzm) throws IOException {
        String vaiidateCode = (String)request.getSession(true).getAttribute("code");
        HttpSession session = request.getSession();
        if (vaiidateCode.trim().equalsIgnoreCase(yzm)){
            User user = new User();
            user.setUsername(username.trim());
            user.setPassword(password.trim());
            int c = userService.findUser(user);
            if (c>0){
                User user1 = userService.findUserByName(username);
                session.setAttribute("user",user1);
                model.addAttribute("result","登录成功，3秒后跳转到首页");
                //这里设置3秒钟之后进行跳转
                response.setHeader("refresh","3;url=returnIndex.do");
                return "tishi";
            }else{
                model.addAttribute("result","用户名或密码错误，3秒后跳转回登录页面");
                //这里设置3秒钟之后进行跳转
                response.setHeader("refresh","3;url=returnLogin.do");
                return "tishi";
            }
        }else{
            model.addAttribute("result","输入的验证码有误，3秒后跳转回登录页面");
            //这里设置3秒钟之后进行跳转
            response.setHeader("refresh","3;url=returnLogin.do");
            return "tishi";
        }
    }

    @RequestMapping("cannelUser")
    public String CannelUser(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        return "login";
    }

    @RequestMapping("cannelAdmin")
    public String CannelAmin(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("admin");
        return "admin_login";
    }

    @RequestMapping("returnRegister")
    public String ReturnRegister(){
        return "register";
    }

    @RequestMapping("returnLogin")
    public String ReturnLogin(){
        return "login";
    }

    @RequestMapping("returnIndex")
    public String ReturnIndex(){
        return "index";
    }

    /**
     * 获取生成验证码显示到 UI 界面
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping(value="/checkCode")
    public void checkCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置相应类型,告诉浏览器输出的内容为图片
        response.setContentType("image/jpeg");

        //设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        RandomValidateCode randomValidateCode = new RandomValidateCode();
        try {
            randomValidateCode.getRandcode(request, response);//输出图片方法
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //修改用户填写信息
    @RequestMapping("updateUserMsg")
    public void UpdateUserMsg(HttpServletRequest request,HttpServletResponse response,String sign,String hobby,String address) throws IOException {
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            User user1 = new User();
            user1.setId(user.getId());
            if (sign!=""){ user1.setSignature(sign.trim());
            }else{ user1.setSignature("用户很懒，没有填写"); }
            if (hobby!=""){ user1.setHobby(hobby.trim());
            }else{ user1.setHobby("用户很懒，没有填写"); }
            if (address!=""){ user1.setAddress(address.trim());
            }else{ user1.setAddress("用户很懒，没有填写"); }
            userService.UpdateUserMsg(user1);
            HttpSession session = request.getSession();
            User user2 = userService.findUserByName(user.getUsername());
            session.setAttribute("user",user2);
            response.getWriter().write("保存成功");
        }else{
            response.getWriter().write("未登录");
        }
    }

    //修改用户密码
    @RequestMapping("updateUserPsw")
    public void UpdateUserPsw(HttpServletRequest request,HttpServletResponse response,String oldp,String newp) throws IOException {
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            User user1 = new User();
            user1.setId(user.getId());
            if (oldp.trim().equals(user.getPassword())){
                if (newp.trim().length()>=6){
                    user1.setPassword(newp.trim());
                    userService.UpdateUserPsw(user1);
                    HttpSession session = request.getSession();
                    User user2 = userService.findUserByName(user.getUsername());
                    session.setAttribute("user",user2);
                    response.getWriter().write("修改成功");
                }else{
                    response.getWriter().write("密码长度不能低于六位");
                }
            }else{
                response.getWriter().write("旧密码错误");
            }
        }else{
            response.getWriter().write("未登录");
        }
    }

    //找回密码（是否存在用户）
    @RequestMapping("findUserBack")
    public void FindUserBack(HttpServletResponse response,String username,String phone) throws IOException {
        if (username.trim()!="" && phone.trim()!=""){
            User user = new User();
            user.setUsername(username.trim());
            user.setPhone(phone.trim());
            int c = userService.findUserBack(user);
            if (c>0){
                response.getWriter().write("1");
            }else{
                response.getWriter().write("0");
            }
        }else {
            response.getWriter().write("0");
        }
    }

    //修改用户密码
    @RequestMapping("resetUserPsw")
    public void ResetUserPsw(HttpServletResponse response,String psw,String username) throws IOException {
        User user1 = userService.findUserByName(username.trim());
        User user2 = new User();
        user2.setId(user1.getId());
        user2.setPassword(psw.trim());
        userService.UpdateUserPsw(user2);
        response.getWriter().write("修改成功");
    }

    @RequestMapping("adminLogin")
    public String AdminLogin(Model model,HttpServletRequest request,HttpServletResponse response,String username,String password){
        Admin admin = new Admin();
        admin.setUsername(username.trim());
        admin.setPassword(password.trim());
        HttpSession session = request.getSession();
        int c = userService.FindAdmin(admin);
        if (c>0){
            session.setAttribute("admin",admin);
            return "redirect:disUser.do?page=1&username=";
        }else {
            model.addAttribute("result","账号或密码错误，跳转回登陆页面");
            response.setHeader("refresh","1;url=returnAdmin.do");
            return "tishi";
        }
    }

    @RequestMapping("returnAdmin")
    public String ReturnAdmin(){
        return "admin_login";
    }

    @RequestMapping("disUser")
    public String DisUser(Model model,HttpServletRequest request,int page,String username){
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            if (username.trim() == ""){
                int c = userService.CountAllUser();
                Pageresult<User> userPageresult = userService.DisAllUser(page,8);
                model.addAttribute("num",c);
                model.addAttribute("all",userPageresult);
                model.addAttribute("username",username.trim());
                return "adminuser";
            }else{
                int c = userService.CountSearchUser(username);
                Pageresult<User> userPageresult = userService.DisSearchUser(username.trim(),page,8);
                model.addAttribute("num",c);
                model.addAttribute("all",userPageresult);
                model.addAttribute("username",username.trim());
                return "adminuser";
            }
        }else{
            model.addAttribute("result","未登录");
            return "tishi";
        }
    }
}

