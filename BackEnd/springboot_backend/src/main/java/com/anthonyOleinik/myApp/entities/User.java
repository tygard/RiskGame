package com.anthonyOleinik.myApp.entities;

import java.util.UUID;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.OptimisticLockType;
import org.hibernate.annotations.OptimisticLocking;

@Entity
@OptimisticLocking(type = OptimisticLockType.ALL)
@Table(name = "User", uniqueConstraints = { @UniqueConstraint(columnNames = "ID"),
                                            @UniqueConstraint(columnNames = "Username")})
@DynamicUpdate
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID", unique = true, nullable = false)
    private UUID id;

    @Column(name = "Username", unique = true, nullable = false)
    private String username;

    @Column(name = "Email", unique = false, nullable = false)
    private String email;

    @Column(name = "RoleId", unique = false, nullable = false)
    private int roleId;

    public User(){} //necessary default constructor for JPA (SQL lib)

    public User(UUID id, String email, String username, int roleId){
        this.id = id;
        this.username = username;
        this.email = email;
        this.roleId = roleId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String toString(){ //toString isnt optional in this. make it pretty!
        return String.format("id = %s, userName = %s, email = %s, role = %s, ", this.id, this.username, this.roleId, this.email);
    }
}

