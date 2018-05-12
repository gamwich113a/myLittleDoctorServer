package com.arlebois.formation.mylittledoctor.controller;

import java.time.Instant;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Rapport;
import com.arlebois.formation.mylittledoctor.entite.Utilisateur;
import com.arlebois.formation.mylittledoctor.repository.AtelierRepository;
import com.arlebois.formation.mylittledoctor.repository.RapportRepository;
import com.arlebois.formation.mylittledoctor.repository.UtilisateurRepository;

@RestController
@RequestMapping("/rapport")
public class RapportController {

    @Autowired
    private UtilisateurRepository utilisateurRepo;

    @Autowired
    private AtelierRepository atelierRepository;

    @Autowired
    private RapportRepository rapportRepository;

    @PostMapping("/create")
    public ResponseEntity<Rapport> createRapport(@RequestParam(value = "titre", required = true) String titre,
	    @RequestParam(value = "rapport", required = true) String rapportTxt,
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id,
	    @RequestParam(value = "atelier_id", required = true) Long atelier_id) {

	Optional<Utilisateur> personneOptional = utilisateurRepo.findById(utilisateur_id);
	Optional<Atelier> atelierOptional = atelierRepository.findById(atelier_id);

	if (personneOptional.isPresent() && atelierOptional.isPresent()) {

	    Rapport rapport = new Rapport(titre, Instant.now(), rapportTxt, personneOptional.get(),
		    atelierOptional.get());

	    rapportRepository.save(rapport);

	    return ResponseEntity.ok(rapport);
	}

	return ResponseEntity.notFound().build();
    }

}
