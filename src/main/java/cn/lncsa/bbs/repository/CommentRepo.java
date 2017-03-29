package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.Comment;
import cn.lncsa.bbs.model.PostContent;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

/**
 * Created by catten on 3/29/17.
 */
public interface CommentRepo extends BaseRepository<Comment, Long> {

    @Query("select c from Comment c where c.target = ?1")
    Page<Comment> findByPostContent(PostContent postContent, Pageable pageable);

}
