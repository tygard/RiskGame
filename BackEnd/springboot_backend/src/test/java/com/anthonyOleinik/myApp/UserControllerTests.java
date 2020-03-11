package com.anthonyOleinik.myApp;

import com.anthonyOleinik.myApp.Repositories.ConnectionsRepository;
import com.anthonyOleinik.myApp.Repositories.FactionRepository;
import com.anthonyOleinik.myApp.Repositories.RolesRepository;
import com.anthonyOleinik.myApp.Repositories.UserRepository;
import com.anthonyOleinik.myApp.controller.UserController;
import com.anthonyOleinik.myApp.entities.FactionEntity;
import com.anthonyOleinik.myApp.entities.RolesEntity;
import com.anthonyOleinik.myApp.entities.UserEntity;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Optional;

import com.fasterxml.jackson.databind.ObjectMapper;
import net.minidev.json.JSONValue;
import org.h2.tools.Console;
import org.junit.Before;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@WebMvcTest(UserController.class)
public class UserControllerTests {

    @Autowired
    MockMvc mvc;

    @MockBean
    UserRepository userRepo;

    @MockBean
    RolesRepository roleRepo;

    @MockBean
    FactionRepository factionRepo;

    @MockBean
    ConnectionsRepository connRepo;

    //simple check to make sure controller is initializing
    @Test
    public void ValidateController() throws Exception {
        assertThat(mvc).isNotNull();
    }


    @Test
    public void AddUser() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));


        UserEntity testUser = new UserEntity("Testing",
                new RolesEntity(0),
                new FactionEntity(0));
        when(userRepo.findAll()).thenReturn(Collections.singletonList(testUser));

        MvcResult result = mvc.perform(MockMvcRequestBuilders
                .post("/users")
                .content(buildUrlEncodedFormEntity(
                        "Username", "Testing",
                        "Faction", "1",
                        "googToken", "TestingGoogToken",
                        "fbToken", "TestingFbToken"
                ))
                .contentType(MediaType.APPLICATION_FORM_URLENCODED_VALUE)
        ).andReturn();
        assertThat(result.getResponse().getContentAsString()).isEqualTo("users/Testing/details");
    }

    @Test
    public void FindUser() throws Exception {
        UserEntity testUser = new UserEntity("Testing",
                new RolesEntity(0),
                new FactionEntity(0));
        ObjectMapper mapper = new ObjectMapper();
        when(userRepo.FindByUsername("Testing")).thenReturn(Optional.of(testUser));
        userRepo.save(testUser);
        MvcResult result = mvc.perform(MockMvcRequestBuilders
        .get("/users/Testing/").accept(MediaType.APPLICATION_JSON_VALUE))
                .andReturn();
        assertThat(result.getResponse().getContentAsString()).isEqualTo(mapper.writeValueAsString(testUser));
    }

    //this is to build some mock form data to send to controller.
    private String buildUrlEncodedFormEntity(String... params) {
        if( (params.length % 2) > 0 ) {
            throw new IllegalArgumentException("Need to give an even number of parameters");
        }
        StringBuilder result = new StringBuilder();
        for (int i=0; i<params.length; i+=2) {
            if( i > 0 ) {
                result.append('&');
            }
            try {
                result.
                        append(URLEncoder.encode(params[i], StandardCharsets.UTF_8.name())).
                        append('=').
                        append(URLEncoder.encode(params[i+1], StandardCharsets.UTF_8.name()));
            }
            catch (UnsupportedEncodingException e) {
                throw new RuntimeException(e);
            }
        }
        return result.toString();
    }
}
