package com.example.demo2.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo2.model.Sector;

public interface SectorRepository extends JpaRepository<Sector, Integer> {}
