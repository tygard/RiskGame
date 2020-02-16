package com.anthonyOleinik.myApp.entities;

import javax.persistence.*;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.*;

import java.io.Serializable;

@Entity
@Table(name = "Account", uniqueConstraints={@UniqueConstraint(columnNames={"username", "id"})})
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
    private FactionEntity faction;

    @Column(unique = true, nullable = false)
    private String username;

    private UserConnections connections;

    private RolesEntity role;

    public UserEntity(){} //necessary default constructor for JPA (SQL lib)

    public UserEntity(String username, RolesEntity role, FactionEntity faction){
        this.username = username;
        this.role = role;
        this.faction = faction;
    }


    public void setUsername(String username) {
        this.username = username;
    }

    public void setRole(RolesEntity role) {
        this.role = role;
    }

    @ManyToOne
    @JoinColumn(name = "role_id")
    public RolesEntity getRole() {
        return role;
    }

    public void setFaction(FactionEntity faction) {
        this.faction = faction;
    }

    @ManyToOne
    @JoinColumn(name = "faction_id")
    public FactionEntity getFaction() {
        return faction;
    }

    public void setConnections(UserConnections connections){
        this.connections = connections;
    }

    @OneToOne(cascade = CascadeType.ALL, mappedBy = "user")
    public UserConnections getConnections(){
        return this.connections;
    }

    public String getUsername() {
        return username;
    }

    public String toString(){
        return ("User ID: "+ id +
                "\n | Username: " + username +
                "\n | Faction: " + faction.toString() +
                "\n | Role: " + role.toString());
    }

}

