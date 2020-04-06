package com.anthonyOleinik.myApp.Services;

import com.anthonyOleinik.myApp.entities.GameState.GameBoard;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.entities.GameState.Tile;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MapGenerator {

    public float dimensions;

    List<Float> makeSphere(){
        List<Float> tmp = new ArrayList<>();
        int center = 63;

        //Since we are using a square board, we can get O(n) by using modulo here.
        for (int i = 0; i < dimensions * dimensions; i++) {
                //Simple squaring
                float distanceX = (center - (i % dimensions)) * (center - (i % dimensions));
                float distanceY = (center - (i / dimensions)) * (center - (i / dimensions));

                float distanceToCenter = (float)Math.sqrt(distanceX + distanceY);

                //Divide by dimensions again to keep it in bounds ie. 0 < distance < 1
                distanceToCenter = distanceToCenter / dimensions;

                tmp.add(distanceToCenter);
            }
        return tmp;
    }

    GameBoard InitializeBoard(GameState tmp) {
        int numPlayers = tmp.getUsers().size();
        GameBoard board = new GameBoard();
        board.setDimensions((numPlayers + (new Random().nextInt(3) * 2 + 1)));
        final int mod = board.getDimensions();
        final int tmpArea = board.getDimensions() * board.getDimensions();
        final int mid = board.getDimensions() / 2;
        int tmpPlayer = 0;

        final List<Tile> corners = new ArrayList<>();
        corners.add(new Tile(0,0));
        corners.add(new Tile(0, mod-1));
        corners.add(new Tile(mod-1, 0));
        corners.add(new Tile(mod-1,mod-1));

        final List<Tile> midSidePoints = new ArrayList<>();
        midSidePoints.add(new Tile(0, mid));
        midSidePoints.add(new Tile(mod-1, mid));

        final List<Tile> midTopPoints = new ArrayList<>();
        midTopPoints.add(new Tile(mid,0));
        midTopPoints.add(new Tile(mid, mod-1));

        for (int i = 0; i < tmpArea; ++i) {
            int x = Math.abs(i % mod);
            int y = Math.abs(i / mod);
            Tile tmpTile = new Tile(x,y);
            //not quite finished. need to check edges to set player ownership.
            tmpTile.setTroops(5);
            if(tmpTile.x == mid && tmpTile.y == mid){
                tmpTile.setTroops(100);
            }
            if(numPlayers == 8) {
                if (corners.contains(tmpTile) || midTopPoints.contains(tmpTile) || midSidePoints.contains(tmpTile)) {
                    tmpTile.setOwner(tmp.getUsers().get(tmpPlayer));
                    tmpTile.setTroops(tmp.getInitTroop());
                    tmpTile.setTroopGeneration(tmp.getInitTroopGen());
                    tmpTile.setMoneyGeneration(tmp.getInitMoneyGen());
                    ++tmpPlayer;
                }
            }else if(numPlayers == 6){
                if(corners.contains(tmpTile) || midTopPoints.contains(tmpTile)){
                    tmpTile.setOwner(tmp.getUsers().get(tmpPlayer));
                    tmpTile.setTroops(tmp.getInitTroop());
                    tmpTile.setTroopGeneration(tmp.getInitTroopGen());
                    tmpTile.setMoneyGeneration(tmp.getInitMoneyGen());
                    ++tmpPlayer;
                }
            }else {
                if (corners.contains(tmpTile)) {
                    tmpTile.setOwner(tmp.getUsers().get(tmpPlayer));
                    tmpTile.setTroops(tmp.getInitTroop());
                    tmpTile.setTroopGeneration(tmp.getInitTroopGen());
                    tmpTile.setMoneyGeneration(tmp.getInitMoneyGen());
                    ++tmpPlayer;
                }
            }
            board.AddTile(tmpTile);
        }
        return board;
    }
}
