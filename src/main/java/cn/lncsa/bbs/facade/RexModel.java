package cn.lncsa.bbs.facade;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

/**
 * Created by catten on 3/29/17.
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RexModel<T> {

    private static ObjectMapper objectMapper;

    static {
        objectMapper = new ObjectMapper();
    }

    private String error;
    private String message;
    private T data;

    public RexModel() {
    }

    public RexModel(T data) {
        this.data = data;
    }

    public RexModel(String message, T data) {
        this.message = message;
        this.data = data;
    }

    public RexModel(String error, String message, T data) {
        this.error = error;
        this.message = message;
        this.data = data;
    }

    @SuppressWarnings("unchecked")
    public static <T> RexModel<T> parse(String model) throws IOException {
        return (RexModel<T>) objectMapper.readValue(model, RexModel.class);
    }

    public String getError() {
        return error;
    }

    public RexModel<T> setError(String error) {
        this.error = error;
        return this;
    }

    public String getMessage() {
        return message;
    }

    public RexModel<T> setMessage(String message) {
        this.message = message;
        return this;
    }

    public T getData() {
        return data;
    }

    public RexModel<T> setData(T data) {
        this.data = data;
        return this;
    }

    public String toJson() throws JsonProcessingException {
        return objectMapper.writeValueAsString(this);
    }

    @Override
    public String toString() {
        return "RexModel{" +
                "error='" + error + '\'' +
                ", message='" + message + '\'' +
                ", data=" + data +
                '}';
    }
}
