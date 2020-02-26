package com.anthonyOleinik.myApp.entities.GameState;

import java.util.Random;

public class GameBoard {
    public final int dimensions = (new Random().nextInt(9) + 7);
    Tile[] tiles = new Tile[(int) Math.pow(this.dimensions, 2)];
}
