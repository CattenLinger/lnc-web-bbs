package cn.lncsa.bbs.service;

import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.model.UserGroup;
import cn.lncsa.bbs.model.UserProfileItem;
import cn.lncsa.bbs.repository.UserGroupRepo;
import cn.lncsa.bbs.repository.UserProfileItemRepo;
import cn.lncsa.bbs.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

/**
 * Created by catten on 3/29/17.
 */
@Service
public class UserSrv {

    public final static String SESSION_USER = "session_user";

    private UserRepo userRepo;
    private PermissionSrv permissionSrv;
    private UserProfileItemRepo userProfileItemRepo;

    @Autowired
    public void setUserRepo(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @Autowired
    public void setPermissionSrv(PermissionSrv permissionSrv) {
        this.permissionSrv = permissionSrv;
    }

    @Autowired
    public void setUserProfileItemRepo(UserProfileItemRepo userProfileItemRepo) {
        this.userProfileItemRepo = userProfileItemRepo;
    }

    public User save(User user){
        return userRepo.save(user);
    }

    public User get(Long id) throws EntityNotFoundException {
        User user = userRepo.findOne(id);
        if(user == null) throw new EntityNotFoundException("No such user");
        return user;
    }

    public User getByUsername(String username) throws EntityNotFoundException {
        User user = userRepo.findByUsername(username);
        if(user == null) throw new EntityNotFoundException("No such user called " + username);
        return user;
    }

    public User findByUsername(String username){
        return userRepo.findByUsername(username);
    }

    public void setUserGroup(User user, String userGroupName) throws EntityNotFoundException {
        user.setUserGroup(permissionSrv.getUserGroupByName(userGroupName));
        userRepo.save(user);
    }

    public void saveProfileItem(UserProfileItem userProfileItem) {
        userProfileItemRepo.save(userProfileItem);
    }

    public void deleteProfileItem(UserProfileItem userProfileItem) {
        userProfileItemRepo.delete(userProfileItem);
    }

    public Page<User> findAll(Pageable pageable) {
        return userRepo.findAll(pageable);
    }
}
