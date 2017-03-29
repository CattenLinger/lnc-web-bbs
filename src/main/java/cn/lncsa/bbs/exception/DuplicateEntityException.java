package cn.lncsa.bbs.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Created by catten on 3/29/17.
 */
@ResponseStatus(code = HttpStatus.CONFLICT)
public class DuplicateEntityException extends Exception {
    public DuplicateEntityException() {
    }

    public DuplicateEntityException(String s) {
        super(s);
    }
}
