package com.anthonyOleinik.myApp.entities;

import java.net.IDN;
import java.util.UUID;

public class User {
    private UUID id;
    private String username;
    private String email;
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

