package com.anthonyOleinik.myApp.entities.GameState;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GameBoard {
    private int dimensions = (new Random().nextInt(4)*2 + 7);
    private List<Tile> tiles = new ArrayList<Tile>();

    public GameBoard(){ CreateTiles(dimensions); }

    public GameBoard(int dims){
        dimensions = dims;
    }

    public void AddTile(Tile _tile){
        tiles.add(_tile);
    }

    public void CreateTiles(int tileNum){
        for(int i = 1; i <= dimensions; i++){
            //trust me, im a scientist on this one.
            tiles.add(new Tile(i % dimensions, i / dimensions));
        }
    }

    public int getDimensions() {
        return dimensions;
    }

    public List<Tile> getTiles() {
        return tiles;
    }

    public Tile getTile(int num){
        return tiles.get(num);
    }

    public void setTiles(List<Tile> tiles) {
        this.tiles = tiles;
    }

    public void setDimensions(int dimensions) {
        this.dimensions = dimensions;
    }
}
