package com.arlebois.formation.mylittledoctor.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arlebois.formation.mylittledoctor.entite.Hopital;
import com.arlebois.formation.mylittledoctor.repository.HopitalRepository;

@RestController
@RequestMapping("/hopital")
public class HopitalController {

    @Autowired
    private HopitalRepository hopitalRepo;

    @PostMapping("/findById")
    public ResponseEntity<Hopital> findHopitalById(
	    @RequestParam(value = "hopital_id", required = true) Long hopital_id) {

	Optional<Hopital> hopitalOptional = hopitalRepo.findById(hopital_id);

	if (hopitalOptional.isPresent()) {

	    return ResponseEntity.ok(hopitalOptional.get());
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/findByDepartement")
    public ResponseEntity<List<Hopital>> findHopitalByDepartement(
	    @RequestParam(value = "departement", required = true) int departement) {

	return ResponseEntity.ok(hopitalRepo.findByDepartement(departement));
    }

    @PostMapping("/findByVille")
    public ResponseEntity<List<Hopital>> findHopitalByVille(
	    @RequestParam(value = "ville", required = true) String ville) {

	return ResponseEntity.ok(hopitalRepo.findByVilleContainingIgnoreCase(ville));
    }

    @PostMapping("/findByNom")
    public ResponseEntity<List<Hopital>> findHopitalByNom(@RequestParam(value = "nom", required = true) String nom) {

	return ResponseEntity.ok(hopitalRepo.findByNomContainingIgnoreCase(nom));
    }

}
