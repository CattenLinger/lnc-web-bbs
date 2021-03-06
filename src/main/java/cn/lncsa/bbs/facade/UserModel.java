package cn.lncsa.bbs.facade;

import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.model.UserProfileItem;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.*;

/**
 * Created by catten on 3/29/17.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserModel {
    private Long id;
    private String username;
    private String password;
    private String groupName;
    private Date registerDate;
    private Map<String,String> information;
    private User user;

    public UserModel(){

    }

    public UserModel(User user){
        this.id = (user.getId() == null ? null : user.getId());
        this.username = user.getUsername();
        this.groupName = (user.getUserGroup() != null ? user.getUserGroup().getName() : null);
        Set<UserProfileItem> userProfile = user.getProfile();
        if(userProfile != null && userProfile.size() > 0){
            information = new HashMap<>();
            boolean secret = false;
            for (UserProfileItem userProfileItem : userProfile){
                if(userProfileItem.getKey().equals(UserProfileItem.KEY_SECRET)){
                    if(userProfileItem.getValue().equals(Boolean.TRUE.toString())){
                        secret = true;
                    }else {
                        information.put(userProfileItem.getKey(), userProfileItem.getValue());
                    }
                }
            }
        }
        registerDate = user.getRegisterDate();
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @JsonIgnore
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public Map<String, String> getInformation() {
        return information;
    }

    public void setInformation(Map<String, String> information) {
        this.information = information;
    }

    @JsonIgnore
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }
}
