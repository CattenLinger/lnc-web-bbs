package cn.lncsa.bbs.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Created by catten on 3/30/17.
 */
@ResponseStatus(HttpStatus.FORBIDDEN)
public class ForbiddenException extends Exception {
    public ForbiddenException() {
    }

    public ForbiddenException(String s) {
        super(s);
    }
}
