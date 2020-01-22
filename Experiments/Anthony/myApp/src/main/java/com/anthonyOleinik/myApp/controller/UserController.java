package com.anthonyOleinik.myApp.controller;


import com.anthonyOleinik.myApp.entities.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {
    //get, post, put, delete & patch lol
    //objects auto convert to JSONs.. useful!
    //like flask's jsonify(obj)


    @GetMapping("/user")
    public User user(){
        User user = new User(1, "Anthony", "O", "aoleinik@iastate.edu");
        return user;
    }

    @GetMapping("/users")
    public User[] users(){
        User[] users = new User[4];
        for (int i = 0; i < 4; i++){
            users[i] = new User(i, "James", "O", "fakeMail.edu");
        }
        return users;
    }
}
