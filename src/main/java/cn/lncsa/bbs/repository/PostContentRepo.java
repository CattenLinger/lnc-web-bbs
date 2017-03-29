package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.PostContent;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
public interface PostContentRepo extends BaseRepository<PostContent,Long> {
    @Query(value = "select DISTINCT topics from PostContent_topics",nativeQuery = true)
    Set<String> getAllTopics();
}
