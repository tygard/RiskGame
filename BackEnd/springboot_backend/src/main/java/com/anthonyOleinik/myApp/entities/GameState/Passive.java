package com.anthonyOleinik.myApp.entities.GameState;

public class Passive {
    private int cost;
    public int duration;
    public boolean active;

    public int passiveValue;
    PassiveModifiers modifiedValue;

}

enum PassiveModifiers{
    defense,
    attack,
    troopGeneration,
    moneyGeneration
}