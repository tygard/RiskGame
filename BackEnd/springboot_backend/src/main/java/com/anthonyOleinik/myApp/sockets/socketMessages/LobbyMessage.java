package com.anthonyOleinik.myApp.sockets.socketMessages;

public class LobbyMessage {
    public int playersInLobby;
    public int yourPlayerNum;
    public String type = "lobby";

    public LobbyMessage(int playersInLobby, int yourPlayerNum){
        this.playersInLobby = playersInLobby;
        this.yourPlayerNum = yourPlayerNum;
    }
}

