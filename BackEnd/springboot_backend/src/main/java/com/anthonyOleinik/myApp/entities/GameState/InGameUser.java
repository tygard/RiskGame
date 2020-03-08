package com.anthonyOleinik.myApp.entities.GameState;

import com.anthonyOleinik.myApp.entities.FactionEntity;
import com.anthonyOleinik.myApp.entities.RolesEntity;
import com.anthonyOleinik.myApp.entities.UserEntity;

import java.util.ArrayList;
import java.util.Random;

public class InGameUser {
    private UserEntity user;

    private ArrayList<Passive> passives = new ArrayList<Passive>();
    private ArrayList<Tile> ownedTiles = new ArrayList<Tile>();

    private int money = 0;
    private int generatedTroops = 0;
    private int generatedMoney = 0;

    private Float multiplierTroops = 1.0f;
    private Float multiplierMoney = 1.0f;

    public InGameUser(){
        user = new UserEntity("Anonymous",
                new RolesEntity(0),
                new FactionEntity(0));
    }

    public InGameUser(UserEntity _user){
        user = _user == null ? new UserEntity("Anonymous"+ String.format("%04d", new Random().nextInt(10000)),
                new RolesEntity(new Random().nextInt(3)),
                new FactionEntity(0))
                : _user;
    }

    public InGameUser(UserEntity _user, ArrayList<Passive> _passives, ArrayList<Tile> _ownedTiles,
               int _money, Float multTroops, Float multMoney){
        user = _user == null ? new UserEntity("Anonymous",
                                            new RolesEntity(0),
                                            new FactionEntity(0))
        : _user;

        passives = _passives == null ? passives : _passives;
        ownedTiles = _ownedTiles == null ? ownedTiles : _ownedTiles;
        multiplierTroops = multTroops.isNaN() ? multiplierTroops : multTroops;
        multiplierMoney = multMoney.isNaN() ? multiplierMoney : multTroops;
    }


    public ArrayList<Passive> getPassives(){ return passives; }
    public ArrayList<Tile> getOwnedTiles(){ return ownedTiles; }
    public int getMoney(){ return money; }
    public int getGeneratedTroops(){ return generatedTroops; }
    public int getGeneratedMoney(){ return generatedMoney; }
    public float getMultiplierTroops() { return multiplierTroops; }
    public float getMultiplierMoney() { return multiplierMoney; }

    public void setPassives(ArrayList<Passive> _passives){ passives = _passives; }
    public void setOwnedTiles(ArrayList<Tile> _tiles){ ownedTiles = _tiles; }
    public void setMoney(int _money){ money = _money; }
    public void setGeneratedTroops(int _genTroops){ generatedTroops = _genTroops; }
    public void setGeneratedMoney(int _genMoney){ generatedMoney = _genMoney; }
    public void setMultiplierTroops(float _multTroops){ multiplierTroops = _multTroops; }
    public void setMultiplierMoney(float _multMoney){ multiplierTroops = _multMoney; }


}
