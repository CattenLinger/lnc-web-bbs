package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.PostContent;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by catten on 3/29/17.
 */
public interface PostContentRepo extends BaseRepository<PostContent,Long> {
    @Query("select distinct a.topics from PostContent a")
    List<String> getAllTopics();
}
