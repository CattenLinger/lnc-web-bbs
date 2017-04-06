package cn.lncsa.bbs.controller;

import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.exception.ForbiddenException;
import cn.lncsa.bbs.facade.CommentModel;
import cn.lncsa.bbs.facade.PostContentModel;
import cn.lncsa.bbs.facade.RexModel;
import cn.lncsa.bbs.facade.UserModel;
import cn.lncsa.bbs.model.*;
import cn.lncsa.bbs.service.PermissionSrv;
import cn.lncsa.bbs.service.PostContentSrv;
import cn.lncsa.bbs.service.UserSrv;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
@Controller
public class IndexController {

    private UserSrv userSrv;
    private PostContentSrv postContentSrv;
    private PermissionSrv permissionSrv;

    @Autowired
    public void setUserSrv(UserSrv userSrv) {
        this.userSrv = userSrv;
    }

    @Autowired
    public void setPostContentSrv(PostContentSrv postContentSrv) {
        this.postContentSrv = postContentSrv;
    }

    @Autowired
    public void setPermissionSrv(PermissionSrv permissionSrv) {
        this.permissionSrv = permissionSrv;
    }

    /*
    *
    * Index page
    *
    * */
    @GetMapping("/")
    public String index(){
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String index(@RequestParam(value = "refer", required = false)String refer, Model model){
        if(refer != null){
            model.addAttribute("message",refer);
        }
        return "index";
    }


    /*
    *
    * Register
    *
    * */
    @GetMapping("/index/register")
    public String register() {
        return "register";
    }

    @PostMapping("/index/register")
    public String register(@ModelAttribute UserModel userModel, Model model){
        User user = userSrv.findByUsername(userModel.getUsername());
        if(user != null) {
            model.addAttribute("error", "user_exist");
            return "register";
        }else user = new User();
        user.setPassword(userModel.getPassword());
        user.setUsername(userModel.getUsername());
        user.setRegisterDate(new Date());
        user.setUserGroup(permissionSrv.getDefaultUserGroup());
        userSrv.save(user);
        return "redirect:/?refer=register";
    }

    /*
    *
    * Login
    *
    * */
    @GetMapping("/index/login")
    public String login(){
        return "login";
    }

    @PostMapping("/index/login")
    public String login(@ModelAttribute UserModel userModel, HttpSession session, Model model){
        User user = userSrv.findByUsername(userModel.getUsername());
        if(user == null) {
            model.addAttribute("error", "user_not_exist");
            return "login";
        }else {
            if(user.getPassword().equals(userModel.getPassword())){
                session.setAttribute(UserSrv.SESSION_USER,user);
                return "redirect:/?refer=login";
            }else {
                model.addAttribute("error","password_wrong");
                return "login";
            }
        }
    }

    /*
    *
    * Logout
    *
    * */
    @GetMapping("/index/logout")
    public String logout(HttpSession session){
        session.removeAttribute(UserSrv.SESSION_USER);
        return "redirect:/?refer=logout";
    }

    /*
    *
    * User Info
    *
    * */
    @GetMapping("/index/self")
    public String selfInfo(@RequestParam(value = "refer",required = false) String message,HttpSession session, Model model) throws EntityNotFoundException {
        User user = (User) session.getAttribute(UserSrv.SESSION_USER);
        if(user == null) return "redirect:/index/login";
        model.addAttribute("user", userSrv.getByUsername(user.getUsername()));
        if(message != null) model.addAttribute("message",message);
        return "self";
    }

    @PostMapping("/index/self/profile")
    public String patchInfo(@ModelAttribute UserProfileItem userProfileItem, HttpSession session){
        User user = (User)session.getAttribute(UserSrv.SESSION_USER);
        if(user == null) return "redirect:/user/login";
        UserProfileItem origin = null;
        if(user.getProfile() != null){
            for (UserProfileItem item : user.getProfile()){
                if(item.getKey().equals(userProfileItem.getKey())){
                    origin = item;
                    break;
                }
            }
        }
        if(origin == null) origin = userProfileItem;
        origin.setTarget(user);
        userSrv.saveProfileItem(origin);
        return "redirect:/index/self?refer=pSaved";
    }

    @GetMapping("/index/self/profile/delete")
    public String deleteInfo(@RequestParam("key") String key, HttpSession session){
        User user = (User)session.getAttribute(UserSrv.SESSION_USER);
        if(user == null) return "redirect:/user/login";
        if(user.getProfile() != null){
            for (UserProfileItem profileItem : user.getProfile()){
                if(profileItem.getKey().equals(key)) {
                    userSrv.deleteProfileItem(profileItem);
                    break;
                }
            }
        }
        return "redirect:/index/self?refer=pDeleted";
    }

    /*
    *
    * Post
    *
    * */
    @GetMapping("/index/article")
    public String recentArticles(@RequestParam(value = "page",defaultValue = "0") int page,@RequestParam(value = "refer",required = false) String message, Model model){
        model.addAttribute("pageObj",postContentSrv.findAll(new PageRequest(page,6, Sort.Direction.DESC,"createDate")));
        if(message != null) model.addAttribute("message",message);
        model.addAttribute("rend_type","recent");
        return "articles";
    }

    @GetMapping("/index/articles.html")
    public String articleList(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "pageSize", defaultValue = "5") int pageSize,
            Model model){
        model.addAttribute("pageObj",postContentSrv.findAll(new PageRequest(page,6, Sort.Direction.DESC,"createDate")));
        return "article_list";
    }

    @PostMapping("/index/article")
    public String postArticle(@ModelAttribute PostContent postContent, HttpSession session) throws EntityNotFoundException, ForbiddenException {
        User user = (User)session.getAttribute(UserSrv.SESSION_USER);
        if(user == null) return "redirect:/user/login";

        PostContent origin;
        Date current = new Date();
        if(postContent.getId() != null){
            origin = postContentSrv.get(postContent.getId());
            if(!origin.getAuthor().getId().equals(user.getId())) throw new ForbiddenException("Not your post!");
            origin.replace(postContent);
        }else {
            origin = postContent;
            origin.setCreateDate(current);
            origin.setAuthor(user);
        }
        origin.setModifiedDate(current);
        postContentSrv.save(origin);
        return "redirect:/index/article?refer=edit";
    }

    @GetMapping("/index/article/post")
    public String postArticle(){
        return "post_article";
    }

    @GetMapping("/index/article/{id}")
    public String showArticle(@PathVariable("id") Long articleId, Model model) throws EntityNotFoundException {
        PostContent postContent = postContentSrv.get(articleId);
        model.addAttribute("post",new PostContentModel(postContent));
        return "post";
    }

    /*
    *
    * Comments
    *
    * */
    @PostMapping("/index/article/{article}/comments")
    public String postComment(@PathVariable("article") Long articleId, @ModelAttribute CommentModel comment, HttpSession session) throws EntityNotFoundException {
        User user = (User) session.getAttribute(UserSrv.SESSION_USER);
        if(user == null) return "redirect:/user/login";
        PostContent postContent = postContentSrv.get(articleId);
        Comment forSave = new Comment();
        if(comment.getRelateTo() != null){
            Comment targetComment = postContentSrv.getComment(comment.getRelateTo());
            forSave.setRelateTo(targetComment);
        }
        forSave.setContent(comment.getContent());
        forSave.setAuthor(user);
        forSave.setTarget(postContent);
        forSave.setCreateDate(new Date());
        postContentSrv.saveComment(forSave);
        return "redirect:/index/article/"+articleId+"?refer=comment#comment_area";
    }

    @GetMapping("/index/article/{article}/comments.html")
    public String postComment(
            @PathVariable("article") Long articleId,
            @RequestParam(value = "page",defaultValue = "0") int page,
            Model model) throws EntityNotFoundException {
        model.addAttribute("page",postContentSrv.getArticleComments(
                articleId,new PageRequest(page,10, Sort.Direction.DESC,"createDate")));
        return "comment_list";
    }

    /*
    *
    * User & permission management
    *
    * */

    @GetMapping("/index/manage/user_list.html")
    public String listUsers(@RequestParam(value = "page", defaultValue = "0",required = false) int page, Model model){
        model.addAttribute("page",userSrv.findAll(new PageRequest(page,10)));
        return "user_list";
    }

    @GetMapping("/index/manage/users")
    public String listUsers(){
        return "users";
    }

    @GetMapping("/index/manage/user/{username}")
    public String userDetails(@PathVariable("username") String username, Model model) throws EntityNotFoundException {
        model.addAttribute("user",userSrv.getByUsername(username));
        return "user_details";
    }

    @GetMapping("/index/manage/groups")
    public String listGroups(@RequestParam(value = "page", defaultValue = "0", required = false) int page, Model model){
        model.addAttribute("page",permissionSrv.findAllUserGroup(new PageRequest(page,20)));
        return "user_group_list";
    }

    @PostMapping("/index/manage/groups/{id}")
    public String alterGroup(@PathVariable("id") Long groupId,@ModelAttribute UserGroup submitObj, Model model) throws EntityNotFoundException {
        UserGroup userGroup = permissionSrv.getUserGroup(groupId);
        userGroup.replace(submitObj);
        permissionSrv.saveUserGroup(userGroup);
        return "redirect:/index/manage/groups/" + groupId;
    }

    @GetMapping("/index/manage/groups/{id}")
    public String groupDetails(@PathVariable("id") Long groupId, Model model) throws EntityNotFoundException {
        model.addAttribute("group",permissionSrv.getUserGroup(groupId));
        return "user_group_details";
    }

    @PostMapping("/index/manage/groups/{id}/permissions")
    public String addPermissionItem(@PathVariable("id") Long groupId,@ModelAttribute Permission submitObj) throws EntityNotFoundException {
        UserGroup userGroup = permissionSrv.getUserGroup(groupId);
        Set<Permission> permissionSet = new HashSet<>();
        permissionSet.add(submitObj);
        permissionSrv.changePermission(userGroup,permissionSet);
        permissionSrv.saveUserGroup(userGroup);
        return "redirect:/index/manage/groups/" + groupId;
    }

    @GetMapping("/index/manage/permission/{id}")
    public ResponseEntity getPermissionItem(@PathVariable("id") Long id) throws EntityNotFoundException {
        Permission permission = permissionSrv.getOne(id);
        return ResponseEntity.ok(new RexModel<>(permission));
    }

    @GetMapping("/index/manage/group/{gid}/permission/delete/{id}")
    public String deletePermissionItem(@PathVariable("id") Long id, @PathVariable("gid") Long gid){
        permissionSrv.deletePermission(id);
        return "redirect:/index/manage/groups/" + gid;
    }
}
