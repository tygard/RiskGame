package com.anthonyOleinik.myApp.entities.GameState;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GameBoard {
    private int dimensions = (new Random().nextInt(4)*2 + 7);
    private List<Tile> tiles = new ArrayList<Tile>();

    public GameBoard(ArrayList<Integer> playerIds, int initPlayerTroops, int initAiTroops){
        for (int i = 0; i < dimensions; i++){
            for (int j = 0; j < dimensions; j++){
                tiles.add(new Tile(i, j, initAiTroops));
            }
        }

        //TODO make this take more than 4 players.
        //currently hardcoded for 4.
        this.getTile(0, 0).setOwner(playerIds.get(0));
        this.getTile(0, 0).setTroops(initPlayerTroops);

        this.getTile(dimensions - 1, dimensions - 1).setOwner(playerIds.get(1));
        this.getTile(dimensions - 1, dimensions - 1).setTroops(initPlayerTroops);

        this.getTile(dimensions - 1, 0).setOwner(playerIds.get(2));
        this.getTile(dimensions - 1, 0).setTroops(initPlayerTroops);

        this.getTile(0, dimensions - 1).setOwner(playerIds.get(3));
        this.getTile(0, dimensions - 1).setTroops(initPlayerTroops);

    }


    public int getDimensions() {
        return dimensions;
    }

    public List<Tile> getTiles() {
        return tiles;
    }

    public Tile getTile(int x, int y) throws IndexOutOfBoundsException {
        for (Tile tile : tiles){
            if (tile.x == x && tile.y == y){
                return tile;
            }
        }
        throw new IndexOutOfBoundsException("Tile index out of bounds");
    }

    public void setTiles(List<Tile> tiles) {
        this.tiles = tiles;
    }

    public void setDimensions(int dimensions) {
        this.dimensions = dimensions;
    }
}
