package cn.lncsa.bbs.facade;

import cn.lncsa.bbs.model.PostContent;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.Date;
import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PostContentModel {
    private Long id;
    private PostContent postContent;
    private String title;
    private String subtitle;
    private String authorName;
    private Date createDate;
    private Date modifiedDate;
    private String status;
    private Set<String> topics;

    public PostContentModel() {
    }

    public PostContentModel(PostContent postContent){
        this.postContent = postContent;
        this.id = postContent.getId();
        this.title = postContent.getTitle();
        this.subtitle = postContent.getSubtitle();
        this.authorName = (postContent.getAuthor() == null ? null : postContent.getAuthor().getUsername());
        this.createDate = postContent.getCreateDate();
        this.modifiedDate = postContent.getModifiedDate();
        this.status = postContent.getStatus();
        this.topics = postContent.getTopics();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @JsonIgnore
    public PostContent getPostContent() {
        return postContent;
    }

    public void setPostContent(PostContent postContent) {
        this.postContent = postContent;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Set<String> getTopics() {
        return topics;
    }

    public void setTopics(Set<String> topics) {
        this.topics = topics;
    }
}
