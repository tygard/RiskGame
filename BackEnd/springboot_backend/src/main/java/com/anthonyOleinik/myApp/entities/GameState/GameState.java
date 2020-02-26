package com.anthonyOleinik.myApp.entities.GameState;

public class GameState {
    public InGameUser[] users = new InGameUser[4];
    public GameBoard board;
    public String gameID;

    public int turn;
    public int currPlayer;

    public final int tileGrowthPercent = 5; //percent out of 100
    public final int secondsPerTurn = 60;
    final int initArmyNum = 20;

    public final int AITileGrowth = 5; //percent out of 100
    public final int initAINum = 5;
}

