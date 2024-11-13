package com.example.demo2.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo2.Repository.SectorRepository;
import com.example.demo2.model.Sector;

@RestController
@RequestMapping("/api/sectores")
public class SectorController {

    @Autowired
    private SectorRepository sectorRepository;

    @GetMapping
    @CrossOrigin(origins = "*")  // Solo este método permite CORS
    public List<Sector> getAllSectores() {
        return sectorRepository.findAll();
    }

    @GetMapping("/{id}")
    public Sector getSectorById(@PathVariable Integer id) {
        return sectorRepository.findById(id).orElse(null);
    }

    @PostMapping
    public Sector createSector(@RequestBody Sector sector) {
        return sectorRepository.save(sector);
    }

    @PutMapping("/{id}")
    public Sector updateSector(@PathVariable Integer id, @RequestBody Sector sectorDetails) {
        Sector sector = sectorRepository.findById(id).orElse(null);
        if (sector != null) {
            sector.setNombre(sectorDetails.getNombre());
            return sectorRepository.save(sector);
        }
        return null;
    }

    @DeleteMapping("/{id}")
    public void deleteSector(@PathVariable Integer id) {
        sectorRepository.deleteById(id);
    }
}
