package com.onlineshop.service.impl;

import com.onlineshop.dao.CategoryMapper;
import com.onlineshop.po.Cart;
import com.onlineshop.po.Category;
import com.onlineshop.po.Category_item;
import com.onlineshop.po.Pageresult;
import com.onlineshop.service.CategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Resource
    private CategoryMapper categoryMapper;

    @Override
    public Pageresult<Category> DisCategoryByCtype(String ctype, int page, int pageSize,int paixu) {
        Pageresult<Category> pr = new Pageresult<>();
        int totalCount = categoryMapper.CountCategoryByCtype(ctype);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        List<Category> categoryList = null;
        Pageresult p = new Pageresult();
        p.setCtype(ctype);
        p.setStart(start);
        p.setPageCount(pageSize);
        if (paixu==0){
            categoryList = categoryMapper.DisCategoryByCtype(p);
        }else if (paixu==1){
            categoryList = categoryMapper.DisCategoryByCtypeA(p);
        }else{
            categoryList = categoryMapper.DisCategoryByCtypeD(p);
        }
        pr.setList(categoryList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountCategoryByCtype(String ctype) {
        int c = categoryMapper.CountCategoryByCtype(ctype);
        return c;
    }

    @Override
    public int IsSaleCategory(int id) {
        int c = categoryMapper.IsSaleCategory(id);
        return c;
    }

    @Override
    public Category DisCategoryById(int id) {
        Category category = categoryMapper.DisCategoryById(id);
        return category;
    }

    @Override
    public Category DisCategoryByIdO(int id) {
        Category ca = categoryMapper.DisCategoryByIdO(id);
        return ca;
    }

    @Override
    public void UpdateCategoryImg(Category category) {
        categoryMapper.UpdateCategoryImg(category);
    }

    @Override
    public void UpdateCategory_ItemImg(Category_item category_item) {
        categoryMapper.UpdateCategory_ItemImg(category_item);
    }

    @Override
    public void UpdateCategory(Category category) {
        categoryMapper.UpdateCategory(category);
    }

    @Override
    public void UpdateCategorySale(Category category) {
        categoryMapper.UpdateCategorySale(category);
    }

    @Override
    public void UpdateCategory_Item(Category_item category_item) {
        categoryMapper.UpdateCategory_Item(category_item);
    }

    @Override
    public void DeleteCategory(int id) {
        categoryMapper.DeleteCategory(id);
    }

    @Override
    public void DeleteCategory_Item(int id) {
        categoryMapper.DeleteCategory_Item(id);
    }

    @Override
    public int CountCategory_Item(int cid) {
        int c = categoryMapper.CountCategory_Item(cid);
        return c;
    }

    @Override
    public List<Category_item> DisCategoryItemById(int cid) {
        List<Category_item> category_items = categoryMapper.DisCategoryItemById(cid);
        return category_items;
    }

    @Override
    public List<Category_item> DisCategoryColorById(int cid) {
        List<Category_item> category_items = categoryMapper.DisCategoryColorById(cid);
        return category_items;
    }

    @Override
    public Category_item FindCategoryItemById(int id) {
        Category_item categoryItem = categoryMapper.FindCategoryItemById(id);
        return categoryItem;
    }

    @Override
    public Category_item findCategoryBySC(Category_item category_item) {
        Category_item categoryItem = categoryMapper.findCategoryBySC(category_item);
        return categoryItem;
    }

    @Override
    public int CountCategoryBySC(Category_item category_item) {
        int c = categoryMapper.CountCategoryBySC(category_item);
        return c;
    }

    @Override
    public int IsExistCategory(Category category) {
        int c = categoryMapper.IsExistCategory(category);
        return c;
    }

    @Override
    public int IsExistCategory_Item(Category_item category_item) {
        int c = categoryMapper.IsExistCategory_Item(category_item);
        return c;
    }

    @Override
    public void insertCategory(Category category) {
        categoryMapper.insertCategory(category);
    }

    @Override
    public void insertCategory_Item(Category_item category_item) {
        categoryMapper.insertCategory_Item(category_item);
    }

    @Override
    public void addCart(Cart cart) {
        categoryMapper.addCart(cart);
    }

    @Override
    public List<Cart> disCartByUserId(int user_id) {
        List<Cart> carts = categoryMapper.disCartByUserId(user_id);
        return carts;
    }

    @Override
    public int CountCartById(Cart cart) {
        int c = categoryMapper.CountCartById(cart);
        return c;
    }

    @Override
    public Cart findCartById(Cart cart) {
        Cart c = categoryMapper.findCartById(cart);
        return c;
    }

    @Override
    public void UpdateCartById(Cart cart) {
        categoryMapper.UpdateCartById(cart);
    }

    @Override
    public void DeleteCartById(Cart cart) {
        categoryMapper.DeleteCartById(cart);
    }

    @Override
    public void UpdateCcount(Category_item category_item) {
        categoryMapper.UpdateCcount(category_item);
    }

    @Override
    public Pageresult<Category_item> DisAllCategory(int page, int pageSize) {
        Pageresult<Category_item> pr = new Pageresult<>();
        int totalCount = categoryMapper.CountAllCategory();
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setStart(start);
        p.setPageCount(pageSize);
        List<Category_item> categoryList = categoryMapper.DisAllCategory(p);
        pr.setList(categoryList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountAllCategory() {
        int c = categoryMapper.CountAllCategory();
        return c;
    }

    @Override
    public Pageresult<Category_item> DisSearchCategory(String cname, int page, int pageSize) {
        Pageresult<Category_item> pr = new Pageresult<>();
        int totalCount = categoryMapper.CountSearchCategory(cname);
        int totalPage = (int)Math.ceil(totalCount * 1.0 / pageSize);
        int start = (page-1)*pageSize;
        Pageresult p = new Pageresult();
        p.setCname(cname);
        p.setStart(start);
        p.setPageCount(pageSize);
        List<Category_item> categoryList = categoryMapper.DisSearchCategory(p);
        pr.setList(categoryList);
        pr.setPageCount(pageSize);
        pr.setTotalPage(totalPage);
        pr.setCurrentPage(page);
        pr.setStart(start);
        pr.setTotalCount(totalCount);
        return pr;
    }

    @Override
    public int CountSearchCategory(String cname) {
        int c = categoryMapper.CountSearchCategory(cname);
        return c;
    }


}
