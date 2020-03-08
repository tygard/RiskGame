package com.anthonyOleinik.myApp.entities.GameState;

import java.util.List;

public class GameState {
    private List<InGameUser> users;
    private GameBoard board;
    private String gameID;

    private int turn = 0;
    private int currPlayer = 0;

    private final int initTroop = 20;
    private final int initTroopGen = 5;
    private final int initMoneyGen = 10;

    private final int initAITroop = 5;
    private final int initAITroopGen = 1;
    private final int initAIMoneyGen = 0;

    public GameState(List<InGameUser> _users, GameBoard _board, String id){
        users = _users;
        board = _board;
        gameID = id;
    }

    public GameBoard getBoard() {
        return board;
    }

    public int getCurrPlayer() {
        return currPlayer;
    }

    public int getTurn() {
        return turn;
    }

    public List<InGameUser> getUsers() {
        return users;
    }

    public String getGameID() {
        return gameID;
    }

    public void setBoard(GameBoard board) {
        this.board = board;
    }

    public void setUsers(List<InGameUser> users) {
        this.users = users;
    }

    public void setGameID(String gameID) {
        this.gameID = gameID;
    }

    public void setTurn(int turn) {
        this.turn = turn;
    }

    public void setCurrPlayer(int currPlayer) {
        this.currPlayer = currPlayer;
    }
}

