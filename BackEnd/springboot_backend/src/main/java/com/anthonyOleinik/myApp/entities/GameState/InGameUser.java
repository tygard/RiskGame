package com.anthonyOleinik.myApp.entities.GameState;

import com.anthonyOleinik.myApp.entities.UserEntity;

import java.util.ArrayList;
import java.util.Random;

public class InGameUser {
    private String userName = "Anonymous" + String.format("%04d", new Random().nextInt(10000));
    private String role = "Anonymous";
    private String faction = "Red";
    private int turnID;

    private ArrayList<Passive> ownedPassives = new ArrayList<Passive>();

    private int money = 0;
    private int genTroops = 0;
    private int genMoney = 25;

    private Float troopMultiplier = 1.0f;
    private Float moneyMultiplier = 1.0f;

    public InGameUser(int turnID) {
        this.turnID = turnID;
    }

    public InGameUser(String username) {
        this.userName = username;
    }

    public InGameUser(UserEntity _user) {
        this.userName = _user.getUsername();
        this.role = _user.getRole().getRoleName();
        //this.faction = _user.getFaction().getFactionName();
    }

    @Override
    public String toString() {
        return "\n" + userName;
    }

    public String getUserName(){return this.userName;}

    public int getTurnID() {
        return this.turnID;
    }

    public ArrayList<Passive> getPassives(){ return this.ownedPassives; }

    public void removePassive(Passive passive){
        ownedPassives.remove(passive);
    }

    public int getMoney(){
        return this.money;
    }

    public void setUserName(String userName){this.userName = userName;}

    public void setMoney(int m){
        this.money = m;
    }

    public void addMoney(int m){
        this.money += m;
    }

    public void setTurnID(int id){this.turnID = id;}
}
