package com.anthonyOleinik.myApp.controller;

import com.anthonyOleinik.myApp.Repositories.ConnectionsRepository;
import com.anthonyOleinik.myApp.Repositories.FactionRepository;
import com.anthonyOleinik.myApp.Repositories.RolesRepository;
import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.entities.GameState.GameBoard;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.entities.GameState.InGameUser;
import com.anthonyOleinik.myApp.entities.GameState.Tile;
import com.anthonyOleinik.myApp.entities.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.*;

import static com.ea.async.Async.await;
import static java.util.concurrent.CompletableFuture.completedFuture;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.concurrent.CompletableFuture;


@RestController
public class GameController {

    @Autowired
    UserRepository userRepo;

    @GetMapping("/game/placeholder/")
    public GameState DefaultGame(){
        ArrayList<Integer> tmp = new ArrayList<>();
        tmp.add(0);
        tmp.add(1);
        tmp.add(2);
        tmp.add(3);
        return new GameState(tmp);
    }

}
