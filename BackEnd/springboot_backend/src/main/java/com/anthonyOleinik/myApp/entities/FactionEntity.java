package com.anthonyOleinik.myApp.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "factions")
public class FactionEntity implements Serializable {

    @Id
    @Column(name = "faction_id", unique = false)
    private int Id;

    @Column(nullable = false, name = "team")
    private String factionName = "White";

    @OneToMany(mappedBy = "faction")
    private Set<UserEntity> users;

    public FactionEntity(){}

    public FactionEntity(int factionId){
        this.Id = factionId;
    }

    public int getId() {
        return Id;
    }

    public String getFactionName() {
        return factionName;
    }
    public void setFactionName(String val) {
        this.factionName = val;
    }

    public String toString(){
        return this.factionName;
    }
}
