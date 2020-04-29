package com.anthonyOleinik.myApp.entities.GameState;

public class Active {
    private int cost;
    public int duration;
    public boolean active;

    public int passiveValue;
    ActiveModifiers modifiedValue;

}

enum ActiveModifiers{
    defense,
    attack,
    troopGeneration,
    moneyGeneration
}