package com.anthonyOleinik.myApp.controller;


import com.anthonyOleinik.myApp.HibernateUtil;
import com.anthonyOleinik.myApp.entities.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.Console;
import java.util.UUID;

@RestController
public class UserController {
    //get, post, put, delete & patch lol
    //objects auto convert to JSONs.. useful!
    //like flask's jsonify(obj)
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @GetMapping("/user")
    public User user() {
        User user = new User(UUID.randomUUID(), "Test", "O", 4);
        return user;
    }

    @GetMapping("/CreateUser")
    public boolean CreateUser(JsonObject Data) {
        Gson gson = new Gson();
        User user;
        try{
            user = gson.fromJson(Data, User.class);
        }catch (Throwable e){
            logger.error("Data passed to controller is invalid", e);
            return false;
        }

        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        try{
            session.save(user);
            return true;
        }catch (Throwable e){
            logger.error("Failed to create user", e);
            return false;
        }
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
