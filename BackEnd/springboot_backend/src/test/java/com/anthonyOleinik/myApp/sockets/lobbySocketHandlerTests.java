package com.anthonyOleinik.myApp.sockets;

import com.google.gson.JsonObject;
import org.junit.jupiter.api.Test;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.ArrayList;

import static org.mockito.Mockito.*;
import static org.mockito.Mockito.times;

public class lobbySocketHandlerTests {
    /*
    @Test
    public void shouldSendMessageOfNewLobbyCountToAllPlayers() throws Exception {
        //should trigger the lobby delegation function when enough players join.

        //creates the lobby
        LobbySocketHandler lobbySocketHandler = new LobbySocketHandler();

        //creates the spy
        LobbySocketHandler spy = spy(lobbySocketHandler);

        //creates the proper amount of users and adds them to the game.
        WebSocketSession[] sessions = new WebSocketSession[lobbySocketHandler.PLAYERS_IN_GAME];

        //manually add the new sessions because of dependant headers
        WebSocketSession testableSession = mock(WebSocketSession.class);
        lobbySocketHandler.sessionToLobbyNum.add(0);
        lobbySocketHandler.sessions.add(testableSession);
        lobbySocketHandler.playerCountUpdated();

        WebSocketSession newSession = mock(WebSocketSession.class);
        lobbySocketHandler.sessionToLobbyNum.add(1);
        lobbySocketHandler.sessions.add(newSession);
        lobbySocketHandler.playerCountUpdated();

        TextMessage textMsg = new TextMessage("sasd");

        verify(testableSession, times(2)).sendMessage(any());


        //tests leave also updates
        lobbySocketHandler.sessionToLobbyNum.remove(lobbySocketHandler.sessions.indexOf(newSession));
        int playerIndex = lobbySocketHandler.sessions.indexOf(newSession);
        //remove player from the waitingPlayers list in game controller.
        lobbySocketHandler.sessions.remove(newSession);
        lobbySocketHandler.playerCountUpdated();
        verify(testableSession, times(3)).sendMessage(any());
    }

     */
}
