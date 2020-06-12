package com.onlineshop.dao;

import com.onlineshop.po.Admin;
import com.onlineshop.po.Pageresult;
import com.onlineshop.po.User;

import java.util.List;

public interface UserMapper {
    int findUserName(String username);

    int findUserPhone(String phone);

    void insertUser(User user);

    int findUser(User user);

    int findUserBack(User user);

    User findUserByName(String username);

    void UpdateUserMsg(User user);

    void UpdateUserPsw(User user);

    int FindAdmin(Admin admin);

    List<User> DisAllUser(Pageresult pageresult);
    List<User> DisSearchUser(Pageresult pageresult);
    int CountSearchUser(String username);
    int CountAllUser();
}
