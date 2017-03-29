package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.User;

/**
 * Created by catten on 3/29/17.
 */
public interface UserRepo extends BaseRepository<User,Long> {
    User findByUsername(String username);
}
