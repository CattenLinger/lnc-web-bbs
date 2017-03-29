package cn.lncsa.bbs.repository;

import cn.lncsa.bbs.model.Permission;
import cn.lncsa.bbs.model.UserGroup;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
public interface PermissionRepo extends BaseRepository<Permission,Long> {
    @Modifying
    @Query("delete from Permission p where p.target = ?1 and p.url in ?2")
    void deletePermissionByUrl(UserGroup userGroup, Iterable<String> permissionUrls);

    @Query("select p from Permission p where p.target = ?1")
    Set<Permission> findByUserGroup(UserGroup userGroup);
}
