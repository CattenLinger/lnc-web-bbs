package cn.lncsa.bbs.controller;

import cn.lncsa.bbs.commons.MessageStrings;
import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.facade.RexModel;
import cn.lncsa.bbs.model.Permission;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.model.UserGroup;
import cn.lncsa.bbs.service.PermissionSrv;
import cn.lncsa.bbs.service.UserSrv;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

/**
 * Created by catten on 3/30/17.
 */
@Controller
@RequestMapping("/manage")
public class ManagerController {

    private UserSrv userSrv;
    private PermissionSrv permissionSrv;

    @Autowired
    public void setUserSrv(UserSrv userSrv) {
        this.userSrv = userSrv;
    }

    @Autowired
    public void setPermissionSrv(PermissionSrv permissionSrv) {
        this.permissionSrv = permissionSrv;
    }

    @RequestMapping(value = "/user/{username}/group",method = RequestMethod.PATCH)
    public @ResponseBody ResponseEntity grantUserGroup(
            @PathVariable("username") String username, @RequestBody RexModel<String> rexModel) throws EntityNotFoundException {
        User user = userSrv.getByUsername(username);
        UserGroup userGroup = permissionSrv.getUserGroupByName(rexModel.getData());

        user.setUserGroup(userGroup);
        userSrv.save(user);

        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }

    @RequestMapping(value = "/group/{groupName}", method = RequestMethod.GET)
    public ResponseEntity getUserGroup(@PathVariable("groupName") String userGroupName) throws EntityNotFoundException {
        return ResponseEntity.ok(new RexModel<>(permissionSrv.getUserGroupByName(userGroupName)));
    }

    @RequestMapping(value = "/group", method = RequestMethod.PATCH)
    public @ResponseBody ResponseEntity saveUserGroup(@RequestBody RexModel<UserGroup> rexModel){
        UserGroup userGroup = rexModel.getData();
        UserGroup origin = permissionSrv.findUserGroup(userGroup.getName());
        if(origin != null) origin.replace(userGroup); else origin = userGroup;
        permissionSrv.saveUserGroup(origin);
        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }

    @RequestMapping(value = "/group/{groupName}/permissions", method = RequestMethod.PATCH)
    public ResponseEntity changeGroupPermission(
            @PathVariable("groupName") String userGroupName,@RequestBody RexModel<Set<Permission>> rexModel) throws EntityNotFoundException {
        permissionSrv.changePermission(permissionSrv.getUserGroupByName(userGroupName),rexModel.getData());
        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }

    @RequestMapping(value = "/group/{groupName}/permissions", method = RequestMethod.DELETE)
    public ResponseEntity deletePermissionFromGroup(
            @PathVariable("groupName") String userGroupName,@RequestBody RexModel<List<String>> permissionUrl) throws EntityNotFoundException {
        UserGroup userGroup = permissionSrv.getUserGroupByName(userGroupName);
        permissionSrv.removePermission(userGroup,permissionUrl.getData());
        return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.SUCCESS));
    }

    @RequestMapping(value = "/user/{username}",method = RequestMethod.GET)
    public ResponseEntity getUserInformation(@PathVariable("username") String username) throws EntityNotFoundException {
        return ResponseEntity.ok(userSrv.getByUsername(username));
    }
}
