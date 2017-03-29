package cn.lncsa.bbs.controller;

import cn.lncsa.bbs.commons.MessageStrings;
import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.facade.RexModel;
import cn.lncsa.bbs.model.Comment;
import cn.lncsa.bbs.model.PostContent;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.service.PostContentSrv;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Created by catten on 3/29/17.
 */
@Controller
@RequestMapping("/article")
public class ArticleController {

    private PostContentSrv postContentSrv;

    @Autowired
    public void setPostContentSrv(PostContentSrv postContentSrv) {
        this.postContentSrv = postContentSrv;
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public ResponseEntity postArticle(RexModel<PostContent> rexModel, HttpSession session){
        Object sessionUser = session.getAttribute("current_user");
        if(sessionUser == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        PostContent postContent = rexModel.getData();
        if(postContent.getTitle() == null || postContent.getContent() == null)
            return ResponseEntity.badRequest().build();

        postContent.setAuthor((User)sessionUser);
        Date date = new Date();
        postContent.setCreateDate(date);
        postContent.setModifiedDate(date);
        postContent.setStatus(PostContent.STATUS_PUBLISHED);

        postContentSrv.save(postContent);

        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }

    @RequestMapping(value = "/{id}",method = RequestMethod.PATCH)
    public @ResponseBody ResponseEntity modifyPost(@PathVariable("id") Long postId, @RequestBody RexModel<PostContent> rexModel, HttpSession session) throws EntityNotFoundException {
        Object sessionUser = session.getAttribute("current_user");
        if(sessionUser == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        PostContent postContent = rexModel.getData();
        PostContent origin = postContentSrv.get(postId);
        if(origin.getAuthor().getId().equals(((User)sessionUser).getId())) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        postContent.setModifiedDate(new Date());
        origin.replace(postContent);
        postContentSrv.save(origin);
        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }

    @RequestMapping(value = "/topics",method = RequestMethod.GET)
    public @ResponseBody ResponseEntity getAllTopics(){
        return ResponseEntity.ok(new RexModel<>(postContentSrv.getAllTopics()));
    }

    public @ResponseBody ResponseEntity commitArticle(Long articleId, RexModel<Comment> rexModel, HttpSession session) throws EntityNotFoundException {
        PostContent postContent = postContentSrv.get(articleId);
        Object sessionUser = session.getAttribute("current_user");
        if(sessionUser == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        postContent.setAuthor((User)sessionUser);
        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }
}
