package com.anthonyOleinik.myApp.sockets;

import com.anthonyOleinik.myApp.controller.GameController;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ModelAttribute;
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
                passGameState(gameStateWrapper.state);
            } catch (JsonParseException e){
                //resends the message. this makes it
                //so that any message other than a gamestate
                //just gets sent back as a message.
                WSSession.sendMessage(message);
            }
        }
    }

    //not sure if this will work, it should send a packet to the GameController where it can
    //be handled
    @SendTo("/games/")
    public GameState passGameState(GameState gamestate){
            return gamestate;
    }

    @MessageMapping("/gameser/{id}")
    @SendTo("/gamecli/{id}")
    public String sendGameState(@DestinationVariable String id, @DestinationVariable GameState gameState) {
        Gson gson = new Gson();
        JsonElement jsonElement = gson.toJsonTree(gameState);
        jsonElement.getAsJsonObject().addProperty("type", "gamestate");
        return gson.toJson(jsonElement);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
    }
}