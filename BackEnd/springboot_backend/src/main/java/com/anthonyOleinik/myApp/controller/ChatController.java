package com.anthonyOleinik.myApp.controller;

import com.anthonyOleinik.myApp.entities.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;

public class ChatController {
    @MessageMapping("/chat/")
    @SendTo("/chat/global")
    public Message greeting(Message message) throws Exception {
        Thread.sleep(1000); // simulated delay
        return message;
    }
}
