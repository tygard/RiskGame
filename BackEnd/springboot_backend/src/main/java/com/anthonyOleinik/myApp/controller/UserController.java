package com.anthonyOleinik.myApp.controller;


import com.anthonyOleinik.myApp.Repositories.FactionRepository;
import com.anthonyOleinik.myApp.Repositories.RolesRepository;
import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.entities.UserEntity;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
public class UserController {
    //get, post, put, delete & patch lol
    //objects auto convert to JSONs.. useful!
    //like flask's jsonify(obj)
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    UserRepository userRepo;

    @Autowired
    RolesRepository roleRepo;

    @Autowired
    FactionRepository factionRepo;

    @GetMapping("/users/{id}/")
    public UserEntity user(@PathVariable String id) {
        try{
            UUID tester = UUID.fromString(id);
            return userRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }catch(Exception e){
            return userRepo.FindByUsername(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }
    }

    @GetMapping("/users/{id}/details")
    public String userDetails(@PathVariable("id") String id) {
        UserEntity user;
        try{
            UUID tester = UUID.fromString(id);
            user = userRepo.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }catch(Exception e){
            user = userRepo.FindByUsername(id)
                    .orElseThrow(() -> new IllegalArgumentException());
        }
        return user.toString();
    }

    @GetMapping("/TestUser/{username}")
    public boolean TestUser(@PathVariable String username) {
        UserEntity user = new UserEntity();
        if(username != null) {
            try {
                user.setFaction(factionRepo.getOne(2));
                user.setRole(roleRepo.getOne(1));
                user.setUsername(username);
            } catch (Throwable e) {
                logger.error("Data passed to controller is invalid", e);
                return false;
            }
        }else{
            logger.error("Data passed to controller is null");
            return false;
        }

        try{
            userRepo.save(user);
            logger.info("Created user "+ user.getId() + " with role "+ user.getRole().toString());
            return true;
        }catch (Throwable e){
            logger.error("Failed to create user", e);
            return false;
        }
    }

    @PostMapping(path = "/CreateUser", produces = MediaType.APPLICATION_JSON_VALUE)
    public boolean CreateUser(@RequestBody JsonObject Data) {
        Gson gson = new Gson();
        UserEntity user;
        if(Data != null) {
            try {
                user = gson.fromJson(Data, UserEntity.class);
            } catch (Throwable e) {
                logger.error("Data passed to controller is invalid", e);
                return false;
            }
        }else{
            logger.error("Data passed to controller is null");
            return false;
        }

        try{
            userRepo.save(user);
            return true;
        }catch (Throwable e){
            logger.error("Failed to create user", e);
            return false;
        }
    }
    
}
