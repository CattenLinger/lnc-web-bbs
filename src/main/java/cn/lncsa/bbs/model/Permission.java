package cn.lncsa.bbs.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

/**
 * Created by catten on 3/29/17.
 */
@Entity
@Table(name = "permissions")
public class Permission {

    public final static String METHOD_SPLIT = "\\|";
    public final static String METHOD_PUT = "PUT";
    public final static String METHOD_GET = "GET";
    public final static String METHOD_POST = "POST";
    public final static String METHOD_PATCH = "PATCH";
    public final static String METHOD_DELETE = "DELETE";

    public final static String POLICY_OWNER = "owner";
    public final static String POLICY_ADMIN = "admin";

    private Long id;
    private String description;
    private String url;
    private String methodPatterns;
    private String policyPatterns;
    private UserGroup target;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(nullable = false)
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMethodPatterns() {
        return methodPatterns;
    }

    public void setMethodPatterns(String methodPatterns) {
        this.methodPatterns = methodPatterns;
    }

    public String getPolicyPatterns() {
        return policyPatterns;
    }

    public void setPolicyPatterns(String policyPatterns) {
        this.policyPatterns = policyPatterns;
    }

    @ManyToOne
    @JoinColumn(nullable = false)
    @JsonIgnore
    public UserGroup getTarget() {
        return target;
    }

    public void setTarget(UserGroup target) {
        this.target = target;
    }

    public void replace(Permission permission) {
        this.setDescription(permission.getDescription() != null ? permission.getDescription() : this.description);
        this.setMethodPatterns(permission.getMethodPatterns() != null ? permission.getMethodPatterns() : this.methodPatterns);
        this.setPolicyPatterns(permission.getPolicyPatterns() != null ? permission.getPolicyPatterns() : this.policyPatterns);
        this.setUrl(permission.getUrl() != null ? permission.getUrl() : this.url);
    }
}
