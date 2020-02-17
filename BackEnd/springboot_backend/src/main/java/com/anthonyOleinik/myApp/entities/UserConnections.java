package com.anthonyOleinik.myApp.entities;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "AccountConnections")
public class UserConnections implements Serializable {

    @Id
    private String userId;

    @OneToOne
    @MapsId
    private UserEntity user;

    @Column
    private String googleToken;

    @Column
    private String facebookToken;

    @Column
    private String refreshJWT;

    public UserConnections(){} //necessary default constructor for JPA (SQL lib)

    public UserConnections(UserEntity user, String googleToken, String facebookToken){
        String t1 = googleToken.equals(null) ? "" : googleToken;
        String t2 = facebookToken.equals(null) ? "" : facebookToken;

        this.user = user;
        this.googleToken = t1;
        this.facebookToken = t2;
    }

    //Getters
    public String getGoogleToken(){ return googleToken; }
    public String getFacebookToken(){ return facebookToken; }
    public String getRefreshJWT(){ return refreshJWT; }
    public String getUserId(){ return userId; }

    //Setters
    public void setGoogleToken(String token){ this.googleToken = token; }
    public void setFacebookToken(String token){ this.facebookToken = token; }
    public void setRefreshJWT(String token){ this.refreshJWT = token; }

}
