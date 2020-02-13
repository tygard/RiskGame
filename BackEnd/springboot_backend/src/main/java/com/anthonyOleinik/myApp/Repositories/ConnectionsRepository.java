package com.anthonyOleinik.myApp.Repositories;

import com.anthonyOleinik.myApp.entities.UserConnections;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ConnectionsRepository extends JpaRepository<UserConnections, String> {

}
