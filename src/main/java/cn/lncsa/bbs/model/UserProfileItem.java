package cn.lncsa.bbs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

/**
 * Created by catten on 3/29/17.
 */
@Entity
@Table(name = "user_profile_items")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class UserProfileItem {

    public final static String KEY_SECRET = "secret";
    public final static String KEY_NAME = "nickname";

    private Long id;
    private String key;
    private String value;
    private User target;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "profile_key", nullable = false)
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Column(name = "profile_value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @ManyToOne
    @JoinColumn(nullable = false)
    @JsonIgnore
    public User getTarget() {
        return target;
    }

    public void setTarget(User target) {
        this.target = target;
    }
}
