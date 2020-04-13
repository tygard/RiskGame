package com.anthonyOleinik.myApp.sockets;

import com.google.gson.JsonObject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;

import static org.mockito.Mockito.*;

public class gameSocketHandlerTests {
    @Test
    public void verifyChatMessagesGetIdentifiedAndSent() throws IOException, InterruptedException {
        WebSocketSession session = mock(WebSocketSession.class);

        //creates mock json
        JsonObject json = new JsonObject();
        json.addProperty("username", "Anthony");
        json.addProperty("type", "chat");
        json.addProperty("message", "My message!");

        TextMessage textMsg = new TextMessage(json.toString());

        when(session.isOpen()).thenReturn(true);

        GameSocketHandler gameSocketHandler = new GameSocketHandler();
        //connect the socket to the handler
        gameSocketHandler.sessions.add(session);
        gameSocketHandler.handleTextMessage(session, textMsg);

        //verify the message WAS sent back.
        verify(session, times(1)).sendMessage(textMsg);
    }

    @Test()
    public void shouldThrowErrorOnUntypedMessage() throws IOException, InterruptedException {
        //this test sends a text message that does not have the proper "type" paramater
        //in the json. Therefore, there should be an error thrown.
        WebSocketSession session = mock(WebSocketSession.class);

        //creates mock json
        JsonObject json = new JsonObject();
        json.addProperty("THIS MESSAGE SHOULD THROW ERROR", "YAY");
        json.addProperty("message", "My message!");

        TextMessage textMsg = new TextMessage(json.toString());

        when(session.isOpen()).thenReturn(true);

        GameSocketHandler gameSocketHandler = new GameSocketHandler();
        //connect the socket to the handler
        gameSocketHandler.sessions.add(session);

        Assertions.assertThrows(NoSuchFieldError.class, () -> {
            gameSocketHandler.handleTextMessage(session, textMsg);
        });

    }
}
