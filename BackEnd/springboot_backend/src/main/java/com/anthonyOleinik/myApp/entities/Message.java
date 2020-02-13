package com.anthonyOleinik.myApp.entities;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Message {
    private String from;
    private String message;

    //takes json with keys username, password
    public Message(String message){
        JsonObject jsonMessage = new JsonParser().parse(message).getAsJsonObject();
        this.from = jsonMessage.get("username").toString();
        this.from = jsonMessage.get("message").toString();
    }

    public Message(String from, String message){
        this.from = from;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public String getFrom() {
        return from;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setFrom(String from) {
        this.from = from;
    }
}
