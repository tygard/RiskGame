package com.anthonyOleinik.myApp.entities;

public class Message {
    private String name;
    private String message;

    public Message(String name, String message){
        this.name = name;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public String getName() {
        return name;
    }
}
