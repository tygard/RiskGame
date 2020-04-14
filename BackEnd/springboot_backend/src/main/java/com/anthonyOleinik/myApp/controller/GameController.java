package com.anthonyOleinik.myApp.controller;

import com.anthonyOleinik.myApp.Repositories.ConnectionsRepository;
import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.entities.GameState.GameBoard;
import com.anthonyOleinik.myApp.entities.GameState.GameState;
import com.anthonyOleinik.myApp.entities.GameState.InGameUser;
import com.anthonyOleinik.myApp.entities.GameState.Tile;
import com.anthonyOleinik.myApp.entities.UserEntity;
import com.anthonyOleinik.myApp.sockets.GameSocketHandler;
import com.anthonyOleinik.myApp.sockets.LobbySocketHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.socket.WebSocketSession;
import com.anthonyOleinik.myApp.Services.MapGenerator;
import static java.util.concurrent.CompletableFuture.completedFuture;

import java.io.IOException;
import java.util.*;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Component
@RestController
public class GameController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    HashMap<Integer, GameState> activeGames = new HashMap<>();

    public HashMap<Integer, ArrayList<WebSocketSession>> gameSessions = new HashMap<>();

    public List<String> waitingPlayers = new ArrayList<>();

    @Autowired
    UserRepository userRepo;

    @Autowired
    ConnectionsRepository connRepo;

    @Autowired
    GameSocketHandler gameSockets;

    @Autowired
    LobbySocketHandler lobbySockets;

    @GetMapping("/games/{id}/")
    public GameState FindGame(@PathVariable("id") Integer id) {
        return activeGames.get(id);
    }


    public void HandlePacket(String id, GameState data) throws IOException {
        //This if statement checks if the modulo resets to 1, indicating all players have taken turn
        if(data.getUsers().size() % data.getCurrPlayer()+1 ==1){
            data.setTurn(data.getTurn()+1);
            data.setCurrPlayer(0);
        }
        data.setCurrPlayer(data.getCurrPlayer()+1);
        activeGames.replace(Integer.parseInt(id), data);
        gameSockets.sendGameState(id, data);
    }

    @GetMapping("/game/template/")
    public GameState GameTemplate() {
        RestTemplate rtemp = new RestTemplate();
        GameState game = rtemp.getForObject("http://localhost:8080/lobbyt/", GameState.class);
        return game;
    }

    @GetMapping("/game/placeholder/")
    public GameState DefaultGame() {
        List<InGameUser> tmp = new ArrayList<InGameUser>();
        tmp.add(new InGameUser());
        tmp.add(new InGameUser());
        tmp.add(new InGameUser());
        tmp.add(new InGameUser());
        GameBoard tmpBoard = new GameBoard();
        tmpBoard.getTile(0).setOwner(tmp.get(0));
        tmpBoard.getTile(tmpBoard.getTiles().size() * 2 / 5).setOwner(tmp.get(1));
        tmpBoard.getTile(tmpBoard.getTiles().size() * 3 / 5).setOwner(tmp.get(2));
        tmpBoard.getTile(tmpBoard.getTiles().size() - 1).setOwner(tmp.get(3));
        return new GameState(tmp, tmpBoard, "0");
    }

    //Ignore this code for now. Working on asynchronously grouping players
    //Using EAs completableFutures plugin
    public void JoinLobby(String user){
        waitingPlayers.add(user);
    }
    public void LeaveLobby(String user){
        waitingPlayers.remove(user);
    }

    @RequestMapping(path = "/lobbyt/")
    public ResponseEntity<GameState> JoinLobbyTest() throws InterruptedException {
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));
        waitingPlayers.add("Anonymous" + String.format("%04d", new Random().nextInt(10000)));

        Thread.sleep(500);
        GameState ret = AddGame();
        if (ret == null) {
            return ResponseEntity.status(408).body(null);
        }
        return ResponseEntity.ok().body(ret);
    }

    //After X amount of players are in the waitlist we create a new game
    //and add it the the activeGames list
    public GameState AddGame(){

        int numPlayers = GameSize();

        List<InGameUser> gamePlayers = GroupPlayers(numPlayers);
            GameState tmp = new GameState(gamePlayers, new GameBoard(), Integer.toString(activeGames.size()));
            //
            //always ensure board is an odd num of tiles

            tmp.setBoard(InitializeBoard(tmp));

            //store game ID in gamestate class, might be redundant due to hashmapping
            activeGames.put(activeGames.size(), tmp);
            logger.info(String.format("\nSuccessfully added game ID: %1s \n[%2s ] players: %3s", tmp.getGameID(),tmp.getUsers().size(),tmp.getUsers()));
        return tmp;
    }

    public List<InGameUser> GroupPlayers(int gameSize){
        //ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();

        List<String> group = new ArrayList<String>(waitingPlayers.subList(0, gameSize));
        List<InGameUser> tmp = new ArrayList<>();
        for(int i = 0; i < group.size() ;i++){
            InGameUser tmpUser = new InGameUser(group.get(i));
            tmpUser.setTurnID(i);
            tmp.add(tmpUser);
            waitingPlayers.remove(tmpUser.getUsername());
        }
        return tmp;
    }


    public CompletableFuture<Boolean> CheckWaiting(int gameSize) {
        if (waitingPlayers.size() < gameSize) {
            return completedFuture(false);
        }
        return completedFuture(true);
    }


    //quick function to determine game size from 4-8
    public Integer GameSize() {
        if(waitingPlayers.size()%8 < 4)
            return 8;
        if(waitingPlayers.size()%6 < 4)
            return 6;

        return 4;
    }

    //
    GameBoard InitializeBoard(GameState tmp) {
        int numPlayers = tmp.getUsers().size();
        GameBoard board = new GameBoard();
        board.setDimensions((numPlayers + (new Random().nextInt(3) * 2 + 1)));
        final int mod = board.getDimensions();
        final int tmpArea = board.getDimensions() * board.getDimensions();
        final int mid = board.getDimensions() / 2;
        int tmpPlayer = 0;

        final List<Tile> corners = new ArrayList<>();
        corners.add(new Tile(0,0));
        corners.add(new Tile(0, mod-1));
        corners.add(new Tile(mod-1, 0));
        corners.add(new Tile(mod-1,mod-1));

        final List<Tile> midSidePoints = new ArrayList<>();
        midSidePoints.add(new Tile(0, mid));
        midSidePoints.add(new Tile(mod-1, mid));

        final List<Tile> midTopPoints = new ArrayList<>();
        midTopPoints.add(new Tile(mid,0));
        midTopPoints.add(new Tile(mid, mod-1));

        for (int i = 0; i < tmpArea; ++i) {
            int x = Math.abs(i % mod);
            int y = Math.abs(i / mod);
            Tile tmpTile = new Tile(x,y);
            //not quite finished. need to check edges to set player ownership.
            tmpTile.setTroops(5);
            if(tmpTile.x == mid && tmpTile.y == mid){
                tmpTile.setTroops(100);
            }
            if(numPlayers == 8) {
                if (corners.contains(tmpTile) || midTopPoints.contains(tmpTile) || midSidePoints.contains(tmpTile)) {
                    tmpTile.setOwner(tmp.getUsers().get(tmpPlayer));
                    tmpTile.setTroops(tmp.getInitTroop());
                    tmpTile.setTroopGeneration(tmp.getInitTroopGen());
                    tmpTile.setMoneyGeneration(tmp.getInitMoneyGen());
                    ++tmpPlayer;
                }
            }else if(numPlayers == 6){
                if(corners.contains(tmpTile) || midTopPoints.contains(tmpTile)){
                    tmpTile.setOwner(tmp.getUsers().get(tmpPlayer));
                    tmpTile.setTroops(tmp.getInitTroop());
                    tmpTile.setTroopGeneration(tmp.getInitTroopGen());
                    tmpTile.setMoneyGeneration(tmp.getInitMoneyGen());
                    ++tmpPlayer;
                }
            }else {
                if (corners.contains(tmpTile)) {
                    tmpTile.setOwner(tmp.getUsers().get(tmpPlayer));
                    tmpTile.setTroops(tmp.getInitTroop());
                    tmpTile.setTroopGeneration(tmp.getInitTroopGen());
                    tmpTile.setMoneyGeneration(tmp.getInitMoneyGen());
                    ++tmpPlayer;
                }
            }
            board.AddTile(tmpTile);
        }
        return board;
    }
}
