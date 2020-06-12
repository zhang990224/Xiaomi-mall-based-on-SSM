package com.onlineshop.service.impl;

import com.onlineshop.dao.UserMapper;
import com.onlineshop.po.Admin;
import com.onlineshop.po.Pageresult;
import com.onlineshop.po.User;
import com.onlineshop.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public int findUserName(String username) {
        int c = userMapper.findUserName(username);
        return c;
    }

    @Override
    public int findUserPhone(String phone) {
        int c = userMapper.findUserPhone(phone);
        return c;
    }

    @Override
    public void insertUser(User user) {
        userMapper.insertUser(user);
    }

    @Override
    public int findUserBack(User user) {
        int c = userMapper.findUserBack(user);
        return c;
    }

    @Override
    public int findUser(User user) {
        int c = userMapper.findUser(user);
        return c;
    }

    @Override
    public User findUserByName(String username) {
        User user = userMapper.findUserByName(username);
        return user;
    }

    @Override
    public void UpdateUserMsg(User user) {
        userMapper.UpdateUserMsg(user);
    }

    @Override
    public void UpdateUserPsw(User user) {
        userMapper.UpdateUserPsw(user);
    }

    @Override
    public int FindAdmin(Admin admin) {
        int c = userMapper.FindAdmin(admin);
        return c;
    }

    @Override
    public Pageresult<User> DisAllUser(int page,int pageSize) {
        Pageresult<User> pr = new Pageresult<>();
        int totalCount = userMapper.CountAllUser();
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setStart(start);
        p.setPageCount(pageSize);
        List<User> userList = userMapper.DisAllUser(p);
        pr.setList(userList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountAllUser() {
        int c = userMapper.CountAllUser();
        return c;
    }

    @Override
    public Pageresult<User> DisSearchUser(String username,int page,int pageSize) {
        Pageresult<User> pr = new Pageresult<>();
        int totalCount = userMapper.CountSearchUser(username);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setUsername(username);
        p.setStart(start);
        p.setPageCount(pageSize);
        List<User> userList = userMapper.DisSearchUser(p);
        pr.setList(userList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountSearchUser(String username) {
        int c = userMapper.CountSearchUser(username);
        return c;
    }
}
