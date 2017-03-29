package cn.lncsa.bbs.service;

import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.model.Permission;
import cn.lncsa.bbs.model.UserGroup;
import cn.lncsa.bbs.repository.PermissionRepo;
import cn.lncsa.bbs.repository.UserGroupRepo;
import cn.lncsa.bbs.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by catten on 3/29/17.
 */
@Service
public class PermissionSrv {

    private PermissionRepo permissionRepo;
    private UserGroupRepo userGroupRepo;

    @Autowired
    public void setPermissionRepo(PermissionRepo permissionRepo) {
        this.permissionRepo = permissionRepo;
    }

    @Autowired
    public void setUserGroupRepo(UserGroupRepo userGroupRepo) {
        this.userGroupRepo = userGroupRepo;
    }

    public void saveUserGroup(UserGroup userGroup){
        UserGroup userGroup1 = userGroupRepo.findByName(userGroup.getName());
        if(userGroup1 != null){
            userGroup.replace(userGroup1);
        }
        userGroupRepo.save(userGroup);
    }

    public UserGroup getUserGroupByName(String userGroupName) throws EntityNotFoundException {
        UserGroup userGroup = userGroupRepo.findByName(userGroupName);
        if(userGroup == null) throw new EntityNotFoundException("No such user group");
        return userGroup;
    }

    public void changePermission(UserGroup userGroup, Set<Permission> permissions){
        if(userGroup.getId() == null) saveUserGroup(userGroup);
        if(userGroup.getPermissions() == null) userGroup.setPermissions(new HashSet<>());
        Map<String,Permission> originList = new HashMap<>();
        for (Permission permission : userGroup.getPermissions()) originList.put(permission.getUrl(),permission);
        for (Permission permission : permissions){
            Permission origin = originList.get(permission.getUrl());
            if(origin == null) {
                permission.setTarget(userGroup);
                originList.put(permission.getUrl(), permission);
            } else origin.replace(permission);
        }
        permissionRepo.save(originList.values());
    }

    public Set<Permission> getPermissions(String userGroupName) throws EntityNotFoundException {
        UserGroup userGroup = getUserGroupByName(userGroupName);
        return permissionRepo.findByUserGroup(userGroup);
    }

    @Transactional
    public void removePermission(UserGroup userGroup, List<String> permissionUrls){
        if(userGroup.getPermissions() == null ) return;
        permissionRepo.deletePermissionByUrl(userGroup,permissionUrls);
    }

    public UserGroup findUserGroup(String name) {
        return userGroupRepo.findByName(name);
    }
}
