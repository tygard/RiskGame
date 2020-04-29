package com.anthonyOleinik.myApp.entities.GameState;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GameState {
    private List<InGameUser> users = new ArrayList<>();
    private GameBoard board;
    private String gameID;

    private int mapSeed = new Random().nextInt(9999);
    private int turn = 0;
    private int currPlayer;

    private final int initTroop = 20;
    private final int initTroopGen = 5;
    private final int initMoneyGen = 10;

    private final int initAITroop = 5;
    private final int initAITroopGen = 1;
    private final int initAIMoneyGen = 0;

    public GameState(ArrayList<Integer> playerIds){
        this.currPlayer = playerIds.get(0);
        for (int playerId : playerIds){
            this.users.add(new InGameUser(playerId));
        }

        this.board = new GameBoard(playerIds, initTroop, initAITroop, mapSeed);
    }

    public void increment(){
        //grow all troops
        for (Tile tile : this.board.getTiles()){
            if (tile.getOwner() > -1){
            /*TODO: fix this    users.get(currPlayer).getPassives().forEach((e)->{
                    if(e.active) {
                        if (e.modifiedValue == PassiveModifiers.attack) {
                            tile.setPower(tile.getPower() * e.passiveValue);
                        } else if (e.modifiedValue == PassiveModifiers.defense) {
                            tile.setDefense(tile.getDefense() * e.passiveValue);
                        } else if (e.modifiedValue == PassiveModifiers.moneyGeneration) {
                            tile.setMoneyGeneration(tile.getMoneyGeneration() * e.passiveValue);
                        } else if (e.modifiedValue == PassiveModifiers.troopGeneration) {
                            tile.setTroopGeneration(tile.getTroopGeneration() * e.passiveValue);
                        }
                        e.duration--;
                        if(e.duration <= 0){
                            users.get(currPlayer).removePassive(e);
                        }
                    }
                });*/
                tile.addTroops(initTroopGen + tile.getTroopGeneration());
            } else if(tile.getOwner() == -1) {
                tile.addTroops(initAITroopGen + tile.getTroopGeneration());
            }else{
                //do nothing for now, this is impassable terrain
            }
        }

        //increment current turn
        boolean foundSelf = false;
        boolean updatedSelf = false;
        for (InGameUser user : this.getUsers()){
            if (user.getTurnID() == this.currPlayer){
                foundSelf = true;
                continue;
            }
            if (foundSelf && !updatedSelf){
                this.currPlayer = user.getTurnID();
                updatedSelf = true;
            }
        }

        if (!updatedSelf){
            currPlayer = this.users.get(0).getTurnID();
        }

        System.out.println("new current player: " + currPlayer);

        //increase money of current player,
        for (InGameUser user : this.getUsers()){
            if (user.getTurnID() == this.currPlayer){
                user.addMoney(initMoneyGen);
            }
        }

        //increiment the rest
        turn++;
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
    public int getInitTroop() {
        return initTroop;
    }
    public int getInitTroopGen() {
        return initTroopGen;
    }

    public int getInitMoneyGen() {
        return initMoneyGen;
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

    public int getMapSeed() {
        return mapSeed;
    }
}

