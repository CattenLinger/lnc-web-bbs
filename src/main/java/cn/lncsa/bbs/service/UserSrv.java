package cn.lncsa.bbs.service;

import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.model.UserGroup;
import cn.lncsa.bbs.repository.UserGroupRepo;
import cn.lncsa.bbs.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by catten on 3/29/17.
 */
@Service
public class UserSrv {

    private UserRepo userRepo;

    private PermissionSrv permissionSrv;

    @Autowired
    public void setUserRepo(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @Autowired
    public void setPermissionSrv(PermissionSrv permissionSrv) {
        this.permissionSrv = permissionSrv;
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
}
