package com.anthonyOleinik.myApp.sockets;

import com.anthonyOleinik.myApp.controller.GameController;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.sockets.socketMessages.LobbyMessage;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.w3c.dom.Text;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

public class LobbySocketHandler extends TextWebSocketHandler {
    private final Gson GSON = new Gson();
    final int PLAYERS_IN_GAME = 4;


    //holds web socket connections
    ArrayList<WebSocketSession> sessions = new ArrayList<>();
    //parrellel to sessions; holds the player nums.
    ArrayList<Integer> sessionToLobbyNum = new ArrayList<>();

    @Autowired
    GameController game;

    @Override
    public void handleTextMessage(WebSocketSession ___, TextMessage __){
        //Lobby delegator does not take input messages, only output!
        System.out.println("did recieve message. shouldnt have doe");
        return;
    }


    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        int numPlayersInLobby = sessionToLobbyNum.size();
        sessionToLobbyNum.add(numPlayersInLobby);
        sessions.add(session);
        playerCountUpdated();
        //+ 1  cause we just added one
        System.out.println("Player joined. new num of players in lobby: " + (numPlayersInLobby + 1));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionToLobbyNum.remove(sessions.indexOf(session));
        sessions.remove(session);
        playerCountUpdated();
        System.out.println("Player left. new num of players in lobby: " + sessions.size());
    }

    /// called when a new player joins the lobby.
    // delegates out the proper lobby message to each user.
    private void playerCountUpdated() throws IOException {
        for (WebSocketSession session : sessions){
            int playerNum = sessionToLobbyNum.get(sessions.indexOf(session));
            LobbyMessage message = new LobbyMessage(sessionToLobbyNum.size(), playerNum);
            //send the proper message to each player in the lobby
            session.sendMessage(new TextMessage(GSON.toJson(message)));
        }

        //if we have atleast the required numbe of players,
        //we can begin sending gamestates to the first n players
        if (sessionToLobbyNum.size() >= PLAYERS_IN_GAME){
            sendGameState();
        }
    }

    private void sendGameState() throws IOException {
        for (int i = 0; i < PLAYERS_IN_GAME; i++){
            //TODO: FIGURE OUT HOW we generate the gamestate, and send the 4 players the gamestate.
            //GET THE GAMESTATE HERE!!!
            GameState gameState = new GameState();
            sessions.get(i).sendMessage(new TextMessage(GSON.toJson(gameState)));
            //the client should break the connection, so no need to remove them
            //from arrays manually.
        }
    }
}
