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
import com.anthonyOleinik.myApp.sockets.SocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import static com.ea.async.Async.await;
import static java.util.concurrent.CompletableFuture.completedFuture;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.concurrent.CompletableFuture;


@RestController
public class GameController {
    HashMap<Integer, GameState> activeGames = new HashMap<Integer, GameState>();
    List<InGameUser> waitingPlayers = new ArrayList<InGameUser>();

    @Autowired
    UserRepository userRepo;

    @Autowired
    SocketHandler sockets;

    @GetMapping("/games/{id}/")
    GameState FindGame(@PathVariable("id") Integer id){
        return activeGames.get(id);
    }


    //send player to this function, players get added to wait list
    String AddWaiting(UserEntity player){
        InGameUser tmp = new InGameUser(player);
        waitingPlayers.add(tmp);
        return "GroupPlayers";
    }

    public void HandlePacket(@DestinationVariable String id, @DestinationVariable GameState data){
        //this probably works, I have no idea how spring does websockets
        //
        activeGames.replace(Integer.parseInt(id), data);
        sockets.sendGameState(id, data);
    }

    @GetMapping("/game/template/")
    public GameState GameTemplate(){
        RestTemplate rtemp = new RestTemplate();
        GameState game = rtemp.getForObject("http://localhost:8080/game/placeholder/", GameState.class);
        return game;
    }

    @GetMapping("/game/placeholder/")
    public GameState DefaultGame(){
        List<InGameUser> tmp = new ArrayList<InGameUser>();
        tmp.add(new InGameUser());
        tmp.add(new InGameUser());
        tmp.add(new InGameUser());
        tmp.add(new InGameUser());
        GameBoard tmpBoard = new GameBoard();
        tmpBoard.getTile(0).setOwner(tmp.get(0));
        tmpBoard.getTile(tmpBoard.getTiles().size()*2/5).setOwner(tmp.get(1));
        tmpBoard.getTile(tmpBoard.getTiles().size()*3/5).setOwner(tmp.get(2));
        tmpBoard.getTile(tmpBoard.getTiles().size()-1).setOwner(tmp.get(3));
        return new GameState(tmp, tmpBoard, "0");
    }

    //Ignore this code for now. Working on asynchronously grouping players
    //Using EAs completableFutures plugin

    //After X amount of players are in the waitlist we create a new game
    //and add it the the activeGames list
    public CompletableFuture<String> AddGame(){
        int numPlayers = GameSize();
        List<InGameUser> gamePlayers = await(GroupPlayers(numPlayers));
        if(await(GroupPlayers(numPlayers)) == null){
            return completedFuture("GroupPlayers");
        }
        GameState tmp = new GameState(gamePlayers, new GameBoard(), Integer.toString(activeGames.size()));
        //
        tmp.setUsers(await(GroupPlayers(numPlayers)));

        //always ensure board is an odd num of tiles
        tmp.getBoard().setDimensions((numPlayers + (new Random().nextInt(3)*2+1)));
        int tmpArea = tmp.getBoard().getDimensions() * tmp.getBoard().getDimensions();
        for(int i = 0; i < tmpArea; i++){
            int mod = tmp.getBoard().getDimensions() * i;
            //not quite finished. need to check edges to set player ownership.
            if(tmpArea % mod != 0){

            }
            tmp.getBoard().AddTile(new Tile());
        }

        //store game ID in gamestate class, might be redundant due to hashmapping
        activeGames.put(activeGames.size(), tmp);
        return completedFuture("GameScreen");
    }

    public CompletableFuture<List<InGameUser>> GroupPlayers(int gameSize){

        if(await(CheckWaiting(gameSize))) {
            List<InGameUser> tmp = null;
            tmp.addAll(waitingPlayers.subList(0, gameSize));
            waitingPlayers.removeAll(tmp);
            return completedFuture(tmp);
        }
        return completedFuture(null);
    }


    public CompletableFuture<Boolean> CheckWaiting(int gameSize){
        if(waitingPlayers.size() < gameSize){
            return completedFuture(false);
        }
        return completedFuture(true);
    }


    //quick function to determine game size from 4-8
    Integer GameSize(){
        int i = 4;
        while(waitingPlayers.size() % i <= 3 && i < 8){
            i += 2;
        }
        return i;
    }
}
