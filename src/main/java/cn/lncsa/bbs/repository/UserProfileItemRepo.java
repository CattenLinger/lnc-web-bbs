package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.UserProfileItem;
import org.springframework.data.jpa.repository.Query;

/**
 * Created by catten on 3/29/17.
 */
public interface UserProfileItemRepo extends BaseRepository<UserProfileItem,Long> {

    @Query("select pi.value from UserProfileItem pi where pi.key = ?2 and pi.target.id = ?1")
    String findUserProfileValue(Long userId, String key);
}
