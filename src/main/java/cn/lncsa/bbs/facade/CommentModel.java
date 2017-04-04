package cn.lncsa.bbs.facade;

import cn.lncsa.bbs.model.Comment;
import cn.lncsa.bbs.model.PostContent;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.model.UserProfileItem;

import java.util.Date;

/**
 * Created by catten on 3/30/17.
 */
public class CommentModel {
    private Long id;
    private String content;
    private Date createDate;
    private String authorName;
    private Long target;
    private Long relateTo;

    private Comment comment;

    public CommentModel(){

    }

    public CommentModel(Long id) {
        this.id = id;
    }

    public CommentModel(Comment comment) {
        this.comment = comment;
        this.id = comment.getId();
        this.content = comment.getContent();
        this.createDate = comment.getCreateDate();
        if(comment.getAuthor() != null){
            User author = comment.getAuthor();
            if(author.getProfile() != null){
                for (UserProfileItem profileItem : author.getProfile()){
                    if(profileItem.getKey().equals(UserProfileItem.KEY_NAME)){
                        this.authorName = profileItem.getValue();
                    }
                }
            }
            if(this.authorName == null) this.authorName = author.getUsername();
        }
        this.relateTo = comment.getRelateTo() == null ? null : comment.getRelateTo().getId();
        this.target = comment.getTarget() == null ? null : comment.getTarget().getId();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public Long getTarget() {
        return target;
    }

    public void setTarget(Long target) {
        this.target = target;
    }

    public Long getRelateTo() {
        return relateTo;
    }

    public void setRelateTo(Long relateTo) {
        this.relateTo = relateTo;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }
}
