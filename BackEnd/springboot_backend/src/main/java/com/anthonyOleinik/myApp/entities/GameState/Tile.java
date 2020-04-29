package com.anthonyOleinik.myApp.entities.GameState;

import java.util.ArrayList;

public class Tile {
    public int x;
    public int y;

    private int ownership = -1;

    //an int from -2 to 3 inclusive, with -2 being an immovable tile and -1 being a uncaptured tile.
    private int terrain = 0;
    private int troops;
    private int power = 0;
    private int defense = 0;

    // actives that are applied to this tile
    private ArrayList<Active> activesList = new ArrayList<>();

    //per turn generation of money or troop
    int moneyGeneration = 0;
    int troopGeneration = 0;

    public Tile(int _x, int _y, int troops){
        x= _x;
        y= _y;
        this.troops = troops;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int getOwner() {
        return ownership;
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

    public ArrayList<Active> getActivesList(){return activesList;}

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

    public void setOwner(int owner) {
        this.ownership = owner;
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

    @Override
    public boolean equals(Object o) {

        // If the object is compared with itself then return true
        if (o == this) {
            return true;
        }

        /* Check if o is an instance of Complex or not
          "null instanceof [type]" also returns false */
        if (!(o instanceof Tile)) {
            return false;
        }

        // typecast o to Complex so that we can compare data members
        Tile c = (Tile) o;

        // Compare the data members and return accordingly
        return this.x == c.x
                && this.y == c.y;
    }

    public void setActivesList(ArrayList<Active> actives){this.activesList = actives;}

    public void addTroops(int initTroopGen) {
        this.troops += initTroopGen;
    }
}
