package cn.lncsa.bbs.controller;

import cn.lncsa.bbs.commons.MessageStrings;
import cn.lncsa.bbs.exception.DuplicateEntityException;
import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.facade.RexModel;
import cn.lncsa.bbs.facade.UserModel;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.service.PermissionSrv;
import cn.lncsa.bbs.service.UserSrv;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Created by catten on 3/29/17.
 */
@Controller
@RequestMapping("/user")
public class UserController {

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

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public
    @ResponseBody
    ResponseEntity register(@RequestBody RexModel<UserModel> rexModel) throws DuplicateEntityException {
        User submitUser = new User();
        submitUser.setUsername(rexModel.getData().getUsername());
        submitUser.setPassword(rexModel.getData().getPassword());

        if (submitUser.getUsername().matches("^[A-Za-z0-9_\\-@.,]{4,}$")
                && submitUser.getPassword() != null
                && submitUser.getPassword().length() >= 6) {
            User user = userSrv.findByUsername(submitUser.getUsername());
            if (user != null) throw new DuplicateEntityException("User already exist.");
            submitUser.setUserGroup(permissionSrv.getDefaultUserGroup());
            submitUser.setRegisterDate(new Date());
            userSrv.save(submitUser);
            return ResponseEntity.ok(new RexModel().setMessage(MessageStrings.SUCCESS));
        }
        return ResponseEntity.badRequest().build();
    }

    @RequestMapping(value = "/id/{id}", method = RequestMethod.GET)
    public
    @ResponseBody
    RexModel getUserInfo(@PathVariable("id") Long userId) throws EntityNotFoundException {
        return new RexModel<>(new UserModel(userSrv.get(userId)));
    }

    @RequestMapping(value = "/{username}", method = RequestMethod.GET)
    public
    @ResponseBody
    RexModel getUserInfo(@PathVariable("username") String username) throws EntityNotFoundException {
        return new RexModel<>(new UserModel(userSrv.getByUsername(username)));
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public
    @ResponseBody
    ResponseEntity login(@RequestBody RexModel<UserModel> rexModel, HttpSession session) throws EntityNotFoundException {
        UserModel hardToken = rexModel.getData();
        if (hardToken.getUsername() == null || hardToken.getPassword() == null)
            return ResponseEntity.badRequest().build();
        else {
            User user = userSrv.getByUsername(hardToken.getUsername());
            if (user.getPassword().equals(hardToken.getPassword())) {
                session.setAttribute(UserSrv.SESSION_USER, user);
                return ResponseEntity.ok(new RexModel().setMessage(MessageStrings.SUCCESS));
            } else {
                return ResponseEntity.ok(new RexModel().setError(MessageStrings.PERMIT_TOKEN_NOT_MATCH));
            }
        }
    }

    @RequestMapping(value = "/exist", method = RequestMethod.GET)
    public
    @ResponseBody
    ResponseEntity isUsernameLegalAndNotExist(@RequestParam("username") String username) throws JsonProcessingException {
        if (username.matches("^[A-Za-z0-9_\\-@.,]{4,}$")) {
            User user = userSrv.findByUsername(username);
            if (user == null)
                return ResponseEntity.ok(new RexModel<>().setMessage(MessageStrings.VALIDATE_USER_NOT_EXIST));
            else return ResponseEntity.badRequest().build();
        } else {
            return ResponseEntity.badRequest().body(
                    new RexModel<>("^[A-Za-z0-9_\\-@.,]{4,}$")
                            .setError(MessageStrings.VALIDATE_USERNAME_INVALID)
                            .setMessage(MessageStrings.NOT_MATCH_PATTERN));
        }
    }
}
