package com.onlineshop.service;

import com.onlineshop.po.Cart;
import com.onlineshop.po.Category;
import com.onlineshop.po.Category_item;
import com.onlineshop.po.Pageresult;

import java.util.List;

public interface CategoryService {
    //商品列表分页
    Pageresult<Category> DisCategoryByCtype(String ctype,int page,int pageSize,int paixu);
    //商品个数
    int CountCategoryByCtype(String ctype);
    //商品详情
    int IsSaleCategory(int id);
    Category DisCategoryById(int id);
    Category DisCategoryByIdO(int id);
    void UpdateCategoryImg(Category category);
    void UpdateCategory_ItemImg(Category_item category_item);
    void UpdateCategory(Category category);
    void UpdateCategorySale(Category category);
    void UpdateCategory_Item(Category_item category_item);
    void DeleteCategory(int id);
    void DeleteCategory_Item(int id);
    int CountCategory_Item(int cid);
    List<Category_item> DisCategoryItemById(int cid);
    List<Category_item> DisCategoryColorById(int cid);
    Category_item FindCategoryItemById(int id);
    //查找商品
    Category_item findCategoryBySC(Category_item category_item);
    int CountCategoryBySC(Category_item category_item);
    //判断与添加商品
    int IsExistCategory(Category category);
    int IsExistCategory_Item(Category_item category_item);
    void insertCategory(Category category);
    void insertCategory_Item(Category_item category_item);
    //购物车
    void addCart(Cart cart);
    List<Cart> disCartByUserId(int user_id);
    int CountCartById(Cart cart);
    Cart findCartById(Cart cart);
    void UpdateCartById(Cart cart);
    void DeleteCartById(Cart cart);
    void UpdateCcount(Category_item category_item);
    //全部商品及模糊查询
    Pageresult<Category_item> DisAllCategory(int page,int pageSize);
    int CountAllCategory();
    Pageresult<Category_item> DisSearchCategory(String cname,int page,int pageSize);
    int CountSearchCategory(String cname);
}
