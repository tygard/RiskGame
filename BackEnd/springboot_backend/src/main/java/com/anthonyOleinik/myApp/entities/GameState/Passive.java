package com.anthonyOleinik.myApp.entities.GameState;

public class Passive {
    private int cost;
    private int duration;
    private boolean active;

    private int passiveValue;
    PassiveModifiers modifiedValue;

}

enum PassiveModifiers{
    defense,
    attack,
    troopGeneration,
    moneyGeneration
}