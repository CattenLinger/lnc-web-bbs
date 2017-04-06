package cn.lncsa.bbs.interceptor;

import cn.lncsa.bbs.model.Permission;
import cn.lncsa.bbs.model.User;
import cn.lncsa.bbs.service.PermissionSrv;
import cn.lncsa.bbs.service.UserSrv;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Collections;
import java.util.Set;

/**
 * Created by catten on 4/7/17.
 */
public class PermissionInterceptor extends HandlerInterceptorAdapter {

    private PermissionSrv permissionSrv;

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    public void setPermissionSrv(PermissionSrv permissionSrv) {
        this.permissionSrv = permissionSrv;
    }

    private Set<Permission> defAllowPermissions = null;

    public void setDefAllowPermissions(Set<Permission> defAllowPermissions) {
        this.defAllowPermissions = defAllowPermissions;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User userSession = (User) session.getAttribute(UserSrv.SESSION_USER);
        if(userSession == null) logger.info("Guest access, using default permission list");
        Set<Permission> permissions = defAllowPermissions;
        if(userSession != null) defAllowPermissions.addAll(permissionSrv.getUserPermissions(userSession.getId()));
        String path = request.getRequestURI();
        logger.info("Access url : " + path);
        String reqMethod = request.getMethod().toUpperCase();
        logger.info("Access method :" + reqMethod);
        boolean pass = false;
        if(permissions != null){
            for (Permission permission : permissions){
                if(path.matches(permission.getUrl())){
                    logger.info(String.format("Access to %s is allowed. checking if method %s is allowed",path, reqMethod));
                    String[] allowMethods = permission.getMethodPatterns().split(Permission.METHOD_SPLIT);
                    logger.info("url %s has those method allowed : " + Arrays.toString(allowMethods));
                    for (String method : allowMethods){
                        if(reqMethod.matches(method.toUpperCase())) {
                            pass = true;
                            logger.info(String.format("Access to %s with method %s is allowed.",path,reqMethod));
                            break;
                        }
                    }
                }
            }
        }else logger.info("No default permission list or user has no permissions.");

        if (pass) return true; else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return false;
        }
    }
}
