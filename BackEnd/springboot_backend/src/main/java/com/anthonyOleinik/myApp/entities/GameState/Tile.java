package com.anthonyOleinik.myApp.entities.GameState;

public class Tile {
    public int x;
    public int y;

    private InGameUser owner = null;

    //an int from -2 to 3 inclusive, with -2 being an immovable tile and -1 being a uncaptured tile.
    private int terrain = 0;
    private int troops = 0;
    private int power = 0;
    private int defense = 0;

    //per turn generation of money or troop
    int moneyGeneration = 0;
    int troopGeneration = 0;

    public Tile(){}

    public Tile(int _x, int _y){
        x= _x;
        y= _y;
    }

    public Tile(InGameUser _owner, int _troops, int moneyGen, int troopGen){
        owner = _owner;
        troops = _troops;
        moneyGeneration = moneyGen;
        troopGeneration = troopGen;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public InGameUser getOwner() {
        return owner;
    }

    public int getDefense() {
        return defense;
    }

    public int getMoneyGeneration() {
        return moneyGeneration;
    }

    public int getPower() {
        return power;
    }

    public int getTerrain() {
        return terrain;
    }

    public int getTroopGeneration() {
        return troopGeneration;
    }

    public int getTroops() {
        return troops;
    }

    public void setDefense(int defense) {
        this.defense = defense;
    }

    public void setMoneyGeneration(int moneyGeneration) {
        this.moneyGeneration = moneyGeneration;
    }

    public void setPower(int power) {
        this.power = power;
    }

    public void setOwner(InGameUser owner) {
        this.owner = owner;
    }

    public void setTerrain(int terrain) {
        this.terrain = terrain;
    }

    public void setTroopGeneration(int troopGeneration) {
        this.troopGeneration = troopGeneration;
    }

    public void setTroops(int troops) {
        this.troops = troops;
    }

    public void setX(int x) {
        this.x = x;
    }

    public void setY(int y) {
        this.y = y;
    }
}
