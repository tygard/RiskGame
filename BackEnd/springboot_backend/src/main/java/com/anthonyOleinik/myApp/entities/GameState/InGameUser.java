package com.anthonyOleinik.myApp.entities.GameState;

import com.anthonyOleinik.myApp.entities.FactionEntity;
import com.anthonyOleinik.myApp.entities.RolesEntity;
import com.anthonyOleinik.myApp.entities.UserEntity;

import java.util.ArrayList;
import java.util.Random;

public class InGameUser {
    private String username = "Anonymous"+ String.format("%04d", new Random().nextInt(10000));
    private String role = "Anonymous";
    private String faction = "Red";

    private ArrayList<Passive> passives = new ArrayList<Passive>();
    private ArrayList<Tile> ownedTiles = new ArrayList<Tile>();

    private int money = 0;
    private int generatedTroops = 0;
    private int generatedMoney = 0;

    private Float multiplierTroops = 1.0f;
    private Float multiplierMoney = 1.0f;

    public InGameUser(){ }

    public InGameUser(UserEntity _user){
        this.username = _user.getUsername();
        this.role = _user.getRole().getRoleName();
        this.faction = _user.getFaction().getFactionName();
    }

    public InGameUser(UserEntity _user, ArrayList<Passive> _passives, ArrayList<Tile> _ownedTiles,
               int _money, Float multTroops, Float multMoney){
        this.username = _user.getUsername();
        this.role = _user.getRole().getRoleName();
        this.faction = _user.getFaction().getFactionName();

        passives = _passives == null ? passives : _passives;
        ownedTiles = _ownedTiles == null ? ownedTiles : _ownedTiles;
        multiplierTroops = multTroops.isNaN() ? multiplierTroops : multTroops;
        multiplierMoney = multMoney.isNaN() ? multiplierMoney : multTroops;
    }


    public String getFaction() { return faction; }
    public String getRole() { return role; }
    public String getUsername() { return username;}
    public ArrayList<Passive> getPassives(){ return passives; }
    public ArrayList<Tile> getOwnedTiles(){ return ownedTiles; }
    public int getMoney(){ return money; }
    public int getGeneratedTroops(){ return generatedTroops; }
    public int getGeneratedMoney(){ return generatedMoney; }
    public float getMultiplierTroops() { return multiplierTroops; }
    public float getMultiplierMoney() { return multiplierMoney; }

    public void setFaction(String faction) { this.faction = faction; }
    public void setRole(String role) { this.role = role; }
    public void setUsername(String username) { this.username = username; }
    public void setPassives(ArrayList<Passive> _passives){ passives = _passives; }
    public void setOwnedTiles(ArrayList<Tile> _tiles){ ownedTiles = _tiles; }
    public void setMoney(int _money){ money = _money; }
    public void setGeneratedTroops(int _genTroops){ generatedTroops = _genTroops; }
    public void setGeneratedMoney(int _genMoney){ generatedMoney = _genMoney; }
    public void setMultiplierTroops(float _multTroops){ multiplierTroops = _multTroops; }
    public void setMultiplierMoney(float _multMoney){ multiplierTroops = _multMoney; }


}
