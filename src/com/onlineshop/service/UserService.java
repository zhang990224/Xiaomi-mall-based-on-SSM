package com.onlineshop.service;

import com.onlineshop.po.Admin;
import com.onlineshop.po.Pageresult;
import com.onlineshop.po.User;

import java.util.List;

public interface UserService {
    //查看是否用户名存在
    int findUserName(String username);
    //查看是否手机号存在
    int findUserPhone(String phone);
    //用户注册
    void insertUser(User user);
    //找回密码（查看是否存在用户）
    int findUserBack(User user);
    //用户登录
    int findUser(User user);
    //用户信息
    User findUserByName(String username);
    //修改用户信息（除密码）
    void UpdateUserMsg(User user);
    //修改密码
    void UpdateUserPsw(User user);
    //管理员登陆
    int FindAdmin(Admin admin);
    //管理端显示所有用户
    Pageresult<User> DisAllUser(int page,int pageSize);
    int CountAllUser();
    //模糊查询用户
    Pageresult<User> DisSearchUser(String username,int page,int pageSize);
    int CountSearchUser(String username);
}
