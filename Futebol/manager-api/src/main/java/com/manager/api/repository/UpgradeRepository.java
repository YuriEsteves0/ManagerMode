package com.manager.api.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.manager.api.model.Upgrade;
import com.manager.api.responses.UpgradeResponse;

public interface UpgradeRepository extends JpaRepository<Upgrade, Integer>{
}