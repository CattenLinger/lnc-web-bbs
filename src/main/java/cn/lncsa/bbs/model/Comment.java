package cn.lncsa.bbs.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by catten on 3/29/17.
 */
@Entity
@Table(name = "comments")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Comment {
    private Long id;
    private String content;
    private Date createDate;
    private User author;
    private PostContent target;
    private Comment relateTo;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Lob
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

    @ManyToOne
    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    @ManyToOne
    public PostContent getTarget() {
        return target;
    }

    public void setTarget(PostContent target) {
        this.target = target;
    }

    @OneToOne
    public Comment getRelateTo() {
        return relateTo;
    }

    public void setRelateTo(Comment relateTo) {
        this.relateTo = relateTo;
    }
}
