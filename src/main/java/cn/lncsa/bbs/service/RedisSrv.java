package cn.lncsa.bbs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created by catten on 3/29/17.
 */
@SuppressWarnings("ALL")
@Service
public class RedisSrv {

    private RedisTemplate<String, String> redisTemplate;
    private ListOperations<String, String> listOperations;
    private ValueOperations<String, String> valueOperations;
    private HashOperations<String, String, String> hashOperations;
    private SetOperations<String,String> setOperations;

    @Autowired
    public void setRedisTemplate(RedisTemplate<String, String> redisTemplate) {
        this.redisTemplate = redisTemplate;
        listOperations = redisTemplate.opsForList();
        valueOperations = redisTemplate.opsForValue();
        hashOperations = redisTemplate.opsForHash();
    }

    public void setString(String key, String value) {
        valueOperations.set(key, value);
    }

    public void setString(String key, String value, Integer seconds) {
        valueOperations.set(key, value, seconds, TimeUnit.SECONDS);
    }

    public String getString(String key) {
        return valueOperations.get(key);
    }

    public void delete(String key) {
        redisTemplate.delete(key);
    }

    public Integer getInt(String key) {
        String result = valueOperations.get(key);
        return result == null ? null : Integer.parseInt(result);
    }

    public void setInt(String key, Integer value) {
        valueOperations.set(key, value.toString());
    }

    public void setInt(String key, Integer value, Integer seconds) {
        valueOperations.set(key, value.toString(), seconds, TimeUnit.SECONDS);
    }

    public boolean exist(String key) {
        return redisTemplate.execute((RedisCallback<Boolean>) connection -> connection.exists(key.getBytes()));
    }

    public void putToList(String key, List<String> list) {
        listOperations.leftPushAll(key, list);
    }

    public List<String> getList(String key) {
        return listOperations.range(key, 0, listOperations.size(key));
    }

    public void putToSet(String key, String value){
        setOperations.add(key,value);
    }

    public void removeFromSet(String key, String value){
        setOperations.remove(key, value);
    }

    public void clearAll() {
        redisTemplate.execute((RedisCallback<Object>) connection -> {
            connection.flushAll();
            return null;
        });
    }

    public String getHashMapKey(String mainKey, String subKey) {
        return hashOperations.get(mainKey, subKey);
    }

    public HashMap<String, String> getHashMap(String key) {
        return (HashMap<String, String>) hashOperations.multiGet(key, hashOperations.keys(key));
    }

    public void putToMap(String key, HashMap<String, String> value) {
        hashOperations.putAll(key, value);
    }

    public void setHashMapKey(String key, String subkey, String exprie) {
        hashOperations.put(key, subkey, exprie);
    }

    public void setKeyPeriod(String key, long time, TimeUnit timeUnit){
        redisTemplate.expire(key, time, timeUnit);
    }

    public void setKeyPeriod(String key, long ms){
        redisTemplate.expire(key, ms, TimeUnit.MILLISECONDS);
    }
}
