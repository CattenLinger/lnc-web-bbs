package cn.lncsa.bbs.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
@Entity
@Table(name = "post_contents")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class PostContent {

    public final static String STATUS_PUBLISHED = "published";

    private Long id;
    private String title;
    private String subtitle;
    private String content;
    private User author;
    private Date createDate;
    private Date modifiedDate;
    private String status;
    private Set<String> topics;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(nullable = false)
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

    @Lob
    @Column(nullable = false)
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @ManyToOne
    @JoinColumn(nullable = false)
    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ElementCollection
    public Set<String> getTopics() {
        return topics;
    }

    public void setTopics(Set<String> topics) {
        this.topics = topics;
    }

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public void replace(PostContent postContent) {
        this.setTitle(postContent.getTitle() == null ? this.title : postContent.getTitle());
        this.setModifiedDate(postContent.getModifiedDate() == null ? this.modifiedDate : postContent.getModifiedDate());
        this.setSubtitle(postContent.getSubtitle() == null ? this.subtitle : postContent.getSubtitle());
        this.setTopics(postContent.getTopics());
    }
}
