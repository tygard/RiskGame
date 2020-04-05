package com.anthonyOleinik.myApp.sockets.socketMessages;

import com.anthonyOleinik.myApp.entities.GameState.GameState;

public class GameStateWrapper {
    private GameState state;
    private String type;

    GameStateWrapper(GameState state, String type){
        this.state = state;
        this.type = type;
    }

    public GameState getState(){
        return this.state;
    }
}
