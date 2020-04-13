package com.anthonyOleinik.myApp.sockets;

import com.anthonyOleinik.myApp.controller.GameController;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.sockets.socketMessages.GameStateWrapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.function.BiConsumer;

@Component
public class GameSocketHandler extends TextWebSocketHandler {
    List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

    @Autowired
    GameController game;

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
            throws InterruptedException, IOException {
        Gson g = new Gson();
        for(WebSocketSession webSocketObject : sessions) {
            Map<String, String> map = g.fromJson(message.getPayload(), Map.class);
            if (map.containsKey("type")){
                System.out.println("has type...");
                if (map.get("type").equals("chat")) {
                    webSocketObject.sendMessage(message);
                } else if (map.get("type").equals("gamestate")) {
                    GameStateWrapper gameStateWrapper = g.fromJson(message.getPayload(), GameStateWrapper.class);
                    game.HandlePacket(gameStateWrapper.getState().getGameID(), gameStateWrapper.getState());

                }
            } else {
                System.out.println("We DONT have a type");
                throw new NoSuchFieldError("No type field in message. each message must have type field.");
            }
        }
    }

    public void sendGameState(String id, GameState gameState) throws IOException {
        Gson gson = new Gson();
        JsonElement jsonElement = gson.toJsonTree(gameState);
        jsonElement.getAsJsonObject().addProperty("type", "gamestate");
        for(WebSocketSession session : game.gameSessions.get(Integer.parseInt(id))){
            session.sendMessage(new TextMessage(gson.toJson(jsonElement)));
        }
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