package com.onlineshop.controller;

import com.onlineshop.po.*;
import com.onlineshop.service.CategoryService;
import com.onlineshop.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/category")
public class CategoryController {
    @Resource
    private CategoryService categoryService;
    @Resource
    private OrderService orderService;

    @RequestMapping("disCategoryByCtype")
    public String DisCategoryByCtype(Model model,String ctype,int paixu,int page){
        Pageresult<Category> categoryPageresult = categoryService.DisCategoryByCtype(ctype.trim(),page,8,paixu);
        int c = categoryService.CountCategoryByCtype(ctype.trim());
        model.addAttribute("category",categoryPageresult);
        model.addAttribute("num",c);
        model.addAttribute("ctype",ctype);
        model.addAttribute("paixu",paixu);
        return "category";
    }

    @RequestMapping("disCategoryItemById")
    public String DisCategoryItemById(Model model,int id){
        int c = categoryService.IsSaleCategory(id);
        if (c>0){
            Category category = categoryService.DisCategoryById(id);
            List<Category_item> category_items = categoryService.DisCategoryItemById(id);
            List<Category_item> categoryColor = categoryService.DisCategoryColorById(id);
            model.addAttribute("categories",category);
            model.addAttribute("cid",id);
            model.addAttribute("categorycolor",categoryColor);
            model.addAttribute("categoryitems",category_items);
            return "categoryitem";
        }else{
            model.addAttribute("result","404,找不到");
            return "tishi";
        }
    }

    @RequestMapping("findCategotyBySC")
    public void FindCategotyBySC( HttpServletResponse response,String csize,String ccolor) throws IOException {
        Category_item categoryItem = new Category_item();
        categoryItem.setCsize(csize.trim());
        categoryItem.setCcolor(ccolor.trim());
        Category_item categoryItem1 = categoryService.findCategoryBySC(categoryItem);
        int count = categoryService.CountCategoryBySC(categoryItem);
        if (count==0){
            response.getWriter().write("商品已下架,xxx,xxx");
        }else{
            System.out.println(categoryItem1.getCcount());
            response.getWriter().write(categoryItem1.getCcount()+","+categoryItem1.getCprice()+","+categoryItem1.getCimg());
        }
    }

    @RequestMapping("addCart")
    public void AddCart(HttpServletRequest request, HttpServletResponse response,String csize,String ccolor,int ci_num) throws IOException {
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            Category_item categoryItem = new Category_item();
            categoryItem.setCsize(csize.trim());
            categoryItem.setCcolor(ccolor.trim());
            Category_item categoryItem1 = categoryService.findCategoryBySC(categoryItem);
            Cart cart = new Cart();
            cart.setUser_id(user.getId());
            cart.setCi_id(categoryItem1.getId());
            cart.setCi_price(categoryItem1.getCprice());
            int c = categoryService.CountCartById(cart);
            if (c>0){
                Cart cart1 = categoryService.findCartById(cart);
                cart.setCi_num(cart1.getCi_num()+ci_num);
                categoryService.UpdateCartById(cart);
            }else{
                cart.setCi_num(ci_num);
                categoryService.addCart(cart);
            }
            response.getWriter().write("添加购物车成功!");
        }else{
            response.getWriter().write("未登录，添加购物车失败!");
        }
    }
    //购物车
    @RequestMapping("disCartById")
    public String DisCartById(Model model,HttpServletRequest request){
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            List<Cart> carts = categoryService.disCartByUserId(user.getId());
            model.addAttribute("carts",carts);
        }else{
            List<Cart> carts = null;
            model.addAttribute("carts",carts);
        }
        return "cart";
    }

    @RequestMapping("updateCart")
    public void UpdateCart(HttpServletRequest request, HttpServletResponse response,int ci_id,int ci_num) throws IOException {
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            Category_item categoryItem = categoryService.FindCategoryItemById(ci_id);
            Cart cart = new Cart();
            cart.setCi_num(ci_num);
            cart.setUser_id(user.getId());
            cart.setCi_id(ci_id);
            if (ci_num>0){
                if (categoryItem.getCcount()>=ci_num){
                    categoryService.UpdateCartById(cart);
                    response.getWriter().write("1");
                }else{
                    response.getWriter().write("2");
                }
            }else{
                categoryService.DeleteCartById(cart);
                response.getWriter().write("0");
            }
        }else{
            response.getWriter().write("未登录，操作购物车失败!");
        }
    }

    @RequestMapping("deleteCart")
    public void DeleteCart(HttpServletRequest request, HttpServletResponse response,int ci_id) throws IOException {
        User user = (User) request.getSession(true).getAttribute("user");
        if (user != null) {
            Cart cart = new Cart();
            cart.setUser_id(user.getId());
            cart.setCi_id(ci_id);
            categoryService.DeleteCartById(cart);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    //提交购物车准备生成订单
    @RequestMapping("addOrder")
    public String AddOrder(Model model,HttpServletRequest request,int id[],int isall){
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            if (isall == 1){
                List<Cart> carts = categoryService.disCartByUserId(user.getId());
                model.addAttribute("carts",carts);
            }else{
                List<Cart> carts = new ArrayList<>();
                Cart c = new Cart();
                c.setUser_id(user.getId());
                for (int i = 0;i<id.length;i++){
                    c.setCi_id(id[i]);
                    Cart cart = categoryService.findCartById(c);
                    System.out.println(cart);
                    carts.add(cart);
                }
                model.addAttribute("carts",carts);
            }
        }else{
            List<Cart> carts = null;
            model.addAttribute("carts",carts);
        }
        return "order";
    }

    @RequestMapping("disCategory")
    public String DisCategory(Model model,HttpServletRequest request,int page,String cname){
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            if (cname.trim() == ""){
                int c = categoryService.CountAllCategory();
                Pageresult<Category_item> categoryPageresult = categoryService.DisAllCategory(page,5);
                model.addAttribute("num",c);
                model.addAttribute("all",categoryPageresult);
                model.addAttribute("username",cname.trim());
                return "admincategory";
            }else{
                int c = categoryService.CountSearchCategory(cname);
                Pageresult<Category_item> categoryPageresult = categoryService.DisSearchCategory(cname,page,5);
                model.addAttribute("num",c);
                model.addAttribute("all",categoryPageresult);
                model.addAttribute("cname",cname.trim());
                return "admincategory";
            }
        }else{
            model.addAttribute("result","未登录");
            return "tishi";
        }
    }

    @RequestMapping("disComment")
    public String DisComment(Model model,int page,int cid){
        Pageresult<Comment> commentPageresult = orderService.DisCommentByCid(cid,page,5);
        Category category = categoryService.DisCategoryById(cid);
        int c = orderService.CountCommentByCid(cid);
        Comment comment = new Comment();
        comment.setCid(cid);
        comment.setCo_level("好");
        int h = orderService.CountCommentByCidLevel(comment);
        comment.setCo_level("中");
        int z = orderService.CountCommentByCidLevel(comment);
        comment.setCo_level("差");
        int b = orderService.CountCommentByCidLevel(comment);
        model.addAttribute("all",commentPageresult);
        model.addAttribute("allnum",c);
        model.addAttribute("hnum",h);
        model.addAttribute("znum",z);
        model.addAttribute("bnum",b);
        model.addAttribute("cid",cid);
        model.addAttribute("categories",category);
        return "categorycomment";
    }

    @RequestMapping("disCommentByUname")
    public String DisCommentByUname(Model model,int page,HttpServletRequest request){
        User user = (User)request.getSession(true).getAttribute("user");
        if (user!=null){
            Pageresult<Comment> commentPageresult = orderService.DisCommentByUname(user.getUsername(),page,5);
            int num = orderService.CountCommentByUname(user.getUsername());
            model.addAttribute("all",commentPageresult);
            model.addAttribute("num",num);
            return "user_comment";
        }else{
            model.addAttribute("result","未登录");
            return "tishi";
        }
    }

    @RequestMapping("deleteCategory")
    public String DeleteCategory(Model model,HttpServletRequest request,int cid,int ciid){
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            categoryService.DeleteCategory_Item(ciid);
            int c = categoryService.CountCategory_Item(cid);
            if (c==0){
                categoryService.DeleteCategory(cid);
            }
            return "redirect:disCategory.do?page=1&cname=";
        }else{
            model.addAttribute("result","未登录");
            return "tishi";
        }
    }

    @RequestMapping("IsExistCategory")
    public void IsExistCategory(HttpServletRequest request, HttpServletResponse response,String cname,String ctype,String csize,String ccolor) throws IOException {
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            Category category = new Category();
            category.setCname(cname.trim());
            category.setCtype(ctype.trim());
            Category_item categoryItem = new Category_item();
            categoryItem.setCname(cname.trim());
            categoryItem.setCsize(csize.trim());
            categoryItem.setCcolor(ccolor.trim());
            int c1 = categoryService.IsExistCategory(category);
            int c2 = categoryService.IsExistCategory_Item(categoryItem);
            if (c1>0){
                if (c2>0){
                    response.getWriter().write("3");
                }else{
                    response.getWriter().write("2");
                }
            }else{
                response.getWriter().write("1");
            }
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("returnCategory")
    public void ReturnCategory(HttpServletRequest request, HttpServletResponse response,int cid) throws IOException {
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            Category category = categoryService.DisCategoryByIdO(cid);
            response.getWriter().write(category.getCname()+","+category.getCtype()+","+category.getCdiscount()+","+category.getIntroduce()+","+category.getImg()+","+category.getCpricel()+","+category.getCpricem());
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("returnCategoryItem")
    public void ReturnCategoryItem(HttpServletRequest request, HttpServletResponse response,int cid) throws IOException {
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            Category_item categoryItem = categoryService.FindCategoryItemById(cid);
            response.getWriter().write(categoryItem.getCname()+","+categoryItem.getCsize()+","+categoryItem.getCcolor()+","+categoryItem.getCcount()+","+categoryItem.getCimg()+","+categoryItem.getCprice());
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("insertCategory")
    public String InsertCategory(HttpServletRequest request,
                               MultipartFile upload,String cname,String csize,int cprice,String ccolor,String cdiscount,String introduce,String ctype,int ccount) throws IOException {
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            final String[] IMAGE_TYPE = new String[] { ".bmp", ".jpg", ".jpeg", ".png" };
            String path = request.getSession().getServletContext().getRealPath("/upload/");
            //判断该路径是否存在
            File file = new File(path);
            if (!file.exists()) {
                //如果这个文件夹不存在的话,就创建这个文件
                file.mkdirs();
            }
            //获取上传文件名称
            String filename = upload.getOriginalFilename();
            System.out.println(filename);
            //把文件名称设置成唯一值 uuid 以防止文件名相同覆盖
            String uuid = UUID.randomUUID().toString().replace("-", "");
            //新文件名
            filename = uuid + "_" + filename;
            System.out.println(filename);
            //完成文件上传
            upload.transferTo(new File(path, filename));
            String NewFilePath = "upload/" + filename;
            Category category = new Category();
            category.setCname(cname.trim());
            category.setCtype(ctype.trim());
            Category_item categoryItem = new Category_item();
            categoryItem.setCname(cname.trim());
            categoryItem.setCsize(csize.trim());
            categoryItem.setCcolor(ccolor.trim());
            int c1 = categoryService.IsExistCategory(category);
            int c2 = categoryService.IsExistCategory_Item(categoryItem);
            if (c1>0){
                if (c2==0){
                    categoryItem.setCcount(ccount);
                    categoryItem.setCprice(cprice);
                    for (String type : IMAGE_TYPE) {
                        if (StringUtils.endsWithIgnoreCase(upload.getOriginalFilename(), type)) {
                            categoryItem.setCimg(NewFilePath);
                            categoryService.insertCategory_Item(categoryItem);
                        }
                    }
                }
            }else{
                category.setCdiscount(cdiscount.trim());
                category.setCpricel(cprice);
                category.setCpricem(cprice);
                category.setIntroduce(introduce.trim());
                category.setIssale(1);
                categoryItem.setCcount(ccount);
                categoryItem.setCprice(cprice);
                for (String type : IMAGE_TYPE) {
                    if (StringUtils.endsWithIgnoreCase(upload.getOriginalFilename(), type)) {
                        category.setImg(NewFilePath);
                        categoryItem.setCimg(NewFilePath);
                        categoryService.insertCategory(category);
                        categoryService.insertCategory_Item(categoryItem);
                    }
                }
            }

        }return "redirect:disCategory.do?page=1&cname=";
    }

    @RequestMapping("returnHead")
    public void ReturnHead(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws IOException {
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            final String[] IMAGE_TYPE = new String[] { ".bmp", ".jpg", ".jpeg", ".png" };
            String path = request.getSession().getServletContext().getRealPath("/upload/");
            //判断该路径是否存在
            File file = new File(path);
            if (!file.exists()) {
                //如果这个文件夹不存在的话,就创建这个文件
                file.mkdirs();
            }
            //获取上传文件名称
            String filename = upload.getOriginalFilename();
            System.out.println(filename);
            //把文件名称设置成唯一值 uuid 以防止文件名相同覆盖
            String uuid = UUID.randomUUID().toString().replace("-", "");
            //新文件名
            filename = uuid + "_" + filename;
            System.out.println(filename);
            //完成文件上传
            upload.transferTo(new File(path, filename));
            String NewFilePath = "upload/" + filename;
            for (String type : IMAGE_TYPE) {
                if (StringUtils.endsWithIgnoreCase(upload.getOriginalFilename(), type)) {
                    response.getWriter().write(NewFilePath);
                }
            }
        }
    }

    @RequestMapping("updateHead")
    public void UpdateHead(HttpServletRequest request,HttpServletResponse response,int cid,String head,String which) throws IOException{
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            if (!head.equals("")) {
                if (which=="1"){
                    Category category = new Category();
                    category.setId(cid);
                    category.setImg(head);
                    categoryService.UpdateCategoryImg(category);
                }else{
                    Category_item categoryItem = new Category_item();
                    categoryItem.setId(cid);
                    categoryItem.setCimg(head);
                    categoryService.UpdateCategory_ItemImg(categoryItem);
                }
                response.getWriter().write("保存成功");
            }else{
                response.getWriter().write("保存失败");
            }
        }
    }

    @RequestMapping("updateCategory")
    public void UpdateCategory(HttpServletRequest request,HttpServletResponse response,
                               int cid,String cname,String ctype,String cdiscount,String introduce,int cpricel,int cpricem) throws IOException{
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            Category category = new Category();
            category.setId(cid);
            category.setCname(cname.trim());
            category.setCtype(ctype.trim());
            category.setIntroduce(introduce.trim());
            category.setCdiscount(cdiscount.trim());
            category.setCpricel(cpricel);
            category.setCpricem(cpricem);
            categoryService.UpdateCategory(category);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("updateCategoryItem")
    public void UpdateCategoryItem(HttpServletRequest request,HttpServletResponse response,
                               int cid,String cname,String csize,String ccolor,int ccount,int cprice) throws IOException{
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            Category_item categoryItem = new Category_item();
            categoryItem.setId(cid);
            categoryItem.setCname(cname.trim());
            categoryItem.setCsize(csize.trim());
            categoryItem.setCcolor(ccolor.trim());
            categoryItem.setCprice(cprice);
            categoryItem.setCcount(ccount);
            categoryService.UpdateCategory_Item(categoryItem);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }

    @RequestMapping("updateCategorySale")
    public void UpdateCategorySale(HttpServletRequest request,HttpServletResponse response, int cid,int issale) throws IOException{
        Admin admin = (Admin)request.getSession().getAttribute("admin");
        if (admin!=null){
            Category category = new Category();
            category.setId(cid);
            if (issale==1){
                category.setIssale(0);
            }else{
                category.setIssale(1);
            }
            categoryService.UpdateCategorySale(category);
            response.getWriter().write("1");
        }else{
            response.getWriter().write("0");
        }
    }
}
