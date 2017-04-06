package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.UserGroup;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by catten on 3/29/17.
 */
public interface UserGroupRepo extends BaseRepository<UserGroup,Long> {
    UserGroup findByName(String name);

    @Query("select distinct ug.name from UserGroup ug")
    List<String> findAllUserGroupNames();
}
