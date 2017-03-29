package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.UserGroup;

/**
 * Created by catten on 3/29/17.
 */
public interface UserGroupRepo extends BaseRepository<UserGroup,Long> {
    UserGroup findByName(String name);
}
