package com.onlineshop.dao;

import com.onlineshop.po.Cart;
import com.onlineshop.po.Category;
import com.onlineshop.po.Category_item;
import com.onlineshop.po.Pageresult;

import java.util.List;

public interface CategoryMapper {
    List<Category> DisCategoryByCtype(Pageresult pageresult);
    List<Category> DisCategoryByCtypeD(Pageresult pageresult);
    List<Category> DisCategoryByCtypeA(Pageresult pageresult);
    int CountCategoryByCtype(String ctype);
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
    Category_item findCategoryBySC(Category_item category_item);
    Category DisCategoryByNT(Category category);
    int IsExistCategory(Category category);
    int IsExistCategory_Item(Category_item category_item);
    void insertCategory(Category category);
    void insertCategory_Item(Category_item category_item);

    int CountCategoryBySC(Category_item category_item);
    //购物车
    void addCart(Cart cart);
    List<Cart> disCartByUserId(int user_id);
    int CountCartById(Cart cart);
    Cart findCartById(Cart cart);
    void UpdateCartById(Cart cart);
    void DeleteCartById(Cart cart);
    void UpdateCcount(Category_item category_item);

    List<Category_item> DisAllCategory(Pageresult pageresult);
    int CountAllCategory();
    List<Category_item> DisSearchCategory(Pageresult pageresult);
    int CountSearchCategory(String cname);
}
