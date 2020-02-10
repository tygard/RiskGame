package com.anthonyOleinik.myApp.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.*;

import java.io.Serializable;

@Entity
@Table(name = "Account")
public class UserEntity implements Serializable {


    private String id;

    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(columnDefinition = "VARCHAR(255)")
    public String getId() {
        return id;
    }

    public UserEntity setId(String val) {
        this.id = val;
        return this;
    }

    @Column(nullable = false)
    private String email = "none";

    @Column(unique = true, nullable = false)
    private String username;

    @Column(nullable = false)
    private int roleId = 0;

    public UserEntity(){} //necessary default constructor for JPA (SQL lib)

    public UserEntity(String email, String username, int roleId){
        this.username = username;
        this.email = email;
        this.roleId = roleId;
    }


    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getRoleId() {
        return roleId;
    }

    public String getEmail() {
        return email;
    }


    public String getUsername() {
        return username;
    }

}

