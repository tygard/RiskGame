package com.anthonyOleinik.myApp;

import com.anthonyOleinik.myApp.Repositories.ConnectionsRepository;
import com.anthonyOleinik.myApp.Repositories.FactionRepository;
import com.anthonyOleinik.myApp.Repositories.RolesRepository;
import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.controller.GameController;
import com.anthonyOleinik.myApp.controller.UserController;
import com.anthonyOleinik.myApp.entities.FactionEntity;
import com.anthonyOleinik.myApp.entities.RolesEntity;
import com.anthonyOleinik.myApp.entities.UserEntity;
import com.anthonyOleinik.myApp.sockets.GameSocketHandler;
import com.anthonyOleinik.myApp.sockets.LobbySocketHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Spy;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.server.MockWebSession;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class GameControllerTests {

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
}
