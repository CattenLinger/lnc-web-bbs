package cn.lncsa.bbs.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by catten on 3/29/17.
 */
@Entity
@Table(name = "user_groups")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class UserGroup {
    private Long id;
    private String name;
    private String description;
    private Set<Permission> permissions;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(mappedBy = "target")
    public Set<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<Permission> permissions) {
        this.permissions = permissions;
    }

    public void replace(UserGroup userGroup) {
        this.setName(userGroup.getName() == null ? this.getName() : userGroup.getName());
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
