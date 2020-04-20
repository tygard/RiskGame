package com.anthonyOleinik.myApp.entities.GameState;

import com.anthonyOleinik.myApp.entities.FactionEntity;
import com.anthonyOleinik.myApp.entities.RolesEntity;
import com.anthonyOleinik.myApp.entities.UserEntity;

import java.util.ArrayList;
import java.util.Random;

public class InGameUser {
    private String username = "Anonymous" + String.format("%04d", new Random().nextInt(10000));
    private String role = "Anonymous";
    private String faction = "Red";
    private int turnID;

    private ArrayList<Passive> ownedPassives = new ArrayList<Passive>();
    private ArrayList<Tile> ownedTiles = new ArrayList<Tile>();

    private int money = 0;
    private int genTroops = 0;
    private int genMoney = 0;

    private Float troopMultiplier = 1.0f;
    private Float moneyMultiplier = 1.0f;

    public InGameUser(int turnID) {
        this.turnID = turnID;
    }

    public InGameUser(String username) {
        this.username = username;
    }

    public InGameUser(UserEntity _user) {
        this.username = _user.getUsername();
        this.role = _user.getRole().getRoleName();
        this.faction = _user.getFaction().getFactionName();
    }

    @Override
    public String toString() {
        return "\n" + username;
    }

    public int getTurnID() {
        return this.turnID;
    }

    public int getMoney(){
        return this.money;
    }

    public void setMoney(int m){
        this.money = m;
    }

    public void addMoney(int m){
        this.money += m;
    }
}
