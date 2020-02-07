package com.anthonyOleinik.myApp.controller;


import com.anthonyOleinik.myApp.entities.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
public class UserController {
    //get, post, put, delete & patch lol
    //objects auto convert to JSONs.. useful!
    //like flask's jsonify(obj)


    @GetMapping("/user")
    public User user() {
        User user = new User(UUID.randomUUID(), "Test", "O", 4);
        return user;
    }

    @GetMapping("/users")
    public User[] users(){
        User[] usersArr = new User[4];
        for (int i = 0; i < 4; i++){
            usersArr[i] = new User(UUID.randomUUID(), "James", "O", 2);
        }
        return usersArr;
    }


}
