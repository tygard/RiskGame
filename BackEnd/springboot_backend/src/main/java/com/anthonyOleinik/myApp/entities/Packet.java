package com.anthonyOleinik.myApp.entities;

import com.anthonyOleinik.myApp.entities.GameState.GameState;

import java.io.Serializable;

public class Packet implements Serializable {
    public enum type{
        message,
        gamestate
    }

    public type pckt = type.message;
    public GameState game = null;
    public Message message = null;

    Packet(Message _msg, GameState _game){
        type _pckt = _msg == null ? type.gamestate : type.message;
        game = _game;
        message = _msg;
    }

}
