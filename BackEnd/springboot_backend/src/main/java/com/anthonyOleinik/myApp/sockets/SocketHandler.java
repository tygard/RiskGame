package com.anthonyOleinik.myApp.sockets;

import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
public class SocketHandler extends TextWebSocketHandler {
    List sessions = new CopyOnWriteArrayList<>();

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
            throws InterruptedException, IOException {
        for(Object webSocketObject : sessions) {
            WebSocketSession WSSession = (WebSocketSession)webSocketObject;
            try{
                Gson g = new Gson();
                GameStateWrapper gameStateWrapper = g.fromJson(message.getPayload(), GameStateWrapper.class);
                //GET GAMESTATE USING gameStateWrapper.gameState;
                //then pass it to wherever you need it to go.
                //for example, you probably want to put it into a
                //function, like handleGameState(gameStateWrapper.gameState);
            } catch (JsonParseException e){
                //resends the message. this makes it
                //so that any message other than a gamestate
                //just gets sent back as a message.
                WSSession.sendMessage(message);
            }
        }
    }

    public String sendGameState(GameState gameState) {
        Gson gson = new Gson();
        JsonElement jsonElement = gson.toJsonTree(gameState);
        jsonElement.getAsJsonObject().addProperty("type", "gamestate");
        return gson.toJson(jsonElement);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //SEND NEW GAMESTATE
        sessions.add(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
    }
}