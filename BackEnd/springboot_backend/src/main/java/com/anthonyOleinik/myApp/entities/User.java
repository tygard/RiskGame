package com.anthonyOleinik.myApp.entities;

public class User {
    private int id;
    private String firstName;
    private String lastInital;
    private String email;

    public User(){} //necessary default constructor for JPA (SQL lib)

    public User(int id, String firstName, String lastInital, String email){
        this.id = id;
        this.firstName = firstName;
        this.lastInital = lastInital;
        this.email = email;
    }

    public String getLastInital() {
        return lastInital;
    }

    public void setLastInital(String lastInital) {
        this.lastInital = lastInital;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String toString(){ //toString isnt optional in this. make it pretty!
        return String.format("id = %s, firstName = %s, lastInital = %s, email = %s, ", this.id, this.firstName, this.lastInital, this.email);
    }
}

