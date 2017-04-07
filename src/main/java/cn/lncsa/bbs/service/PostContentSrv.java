package cn.lncsa.bbs.service;

import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.model.Comment;
import cn.lncsa.bbs.model.PostContent;
import cn.lncsa.bbs.repository.CommentRepo;
import cn.lncsa.bbs.repository.PostContentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
@Service
public class PostContentSrv {

    private PostContentRepo postContentRepo;
    private CommentRepo commentRepo;

    @Autowired
    public void setPostContentRepo(PostContentRepo postContentRepo) {
        this.postContentRepo = postContentRepo;
    }

    @Autowired
    public void setCommentRepo(CommentRepo commentRepo) {
        this.commentRepo = commentRepo;
    }

    public void save(PostContent postContent){
        postContentRepo.save(postContent);
    }

    public PostContent get(Long postId) throws EntityNotFoundException {
        PostContent postContent = postContentRepo.findOne(postId);
        if(postContent == null) throw new EntityNotFoundException("No such post");
        return postContent;
    }

    public Set<String> getAllTopics() {
//        return new ArrayList<>();
        return postContentRepo.getAllTopics();
    }

    public void saveComment(Comment comment){
        commentRepo.save(comment);
    }

    public Comment getComment(Long id) throws EntityNotFoundException {
        Comment comment = commentRepo.findOne(id);
        if(comment == null) throw new EntityNotFoundException("No such comment");
        return comment;
    }

    public void deleteComment(Long id) {
        commentRepo.delete(id);
    }

    public void deleteComment(Comment comment) {
        commentRepo.delete(comment);
    }

    public Page<Comment> getArticleComments(Long articleId, Pageable pageable) throws EntityNotFoundException {
        PostContent postContent = get(articleId);
        return commentRepo.findByPostContent(postContent,pageable);
    }

    public Page<PostContent> findAll(Pageable pageable) {
        return postContentRepo.findAll(pageable);
    }

    public Page<PostContent> findPostsByTopic(String topic, Pageable pageable) {
        return postContentRepo.findAll((root, criteriaQuery, criteriaBuilder) -> criteriaBuilder.isMember(topic,root.get("topics")), pageable);
    }

    public void deletePost(PostContent postContent) {
        postContentRepo.delete(postContent);
    }
}
