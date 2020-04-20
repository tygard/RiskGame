package com.anthonyOleinik.myApp;

import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

public class GameControllerTests {

    /*
    @InjectMocks
    GameController game = new GameController();

    //simple check to make sure controller is initializing
    @Test
    public void ValidateController() throws Exception {
        assertThat(game).isNotNull();
    }


    @Test
    public void GroupPlayers() throws Exception {
        for(int i = 0; i < 4; i++){
            game.JoinLobby("test"+i);
        }

        assertThat(game.GroupPlayers(4).size()>3);
    }

    @Test
    public void CreateGameState() throws Exception {
        for(int i = 0; i < 4; i++){
            game.JoinLobby("test"+i);
        }
        game.AddGame();
        assertThat(game.FindGame(0)).isNotNull();
    }

    @Test
    public void JoinLobby() throws Exception {
        game.JoinLobby("test");

        assertThat(game.waitingPlayers.contains("test"));
    }

     */
}
