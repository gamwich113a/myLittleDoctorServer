package com.arlebois.formation.mylittledoctor.controller;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Utilisateur;
import com.arlebois.formation.mylittledoctor.repository.AtelierRepository;
import com.arlebois.formation.mylittledoctor.repository.UtilisateurRepository;

@RestController
@RequestMapping("/atelier")
public class AtelierController {

    @Autowired
    private UtilisateurRepository utilisateurRepo;

    @Autowired
    private AtelierRepository atelierRepository;

    @PostMapping("/create")
    public ResponseEntity<Atelier> createAtelier(@RequestParam(value = "titre", required = true) String titre,
	    @RequestParam(value = "description", required = true) String description,
	    @RequestParam(value = "lieu", required = true) String lieu,
	    @RequestParam(value = "dateDebut", required = true) Instant dateDebut,
	    @RequestParam(value = "dateFin", required = true) Instant dateFin,
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id) {

	Optional<Utilisateur> personneOptional = utilisateurRepo.findById(utilisateur_id);

	if (personneOptional.isPresent()) {

	    Atelier atelier = new Atelier(titre, dateDebut, dateFin, description, lieu, personneOptional.get());

	    atelierRepository.save(atelier);

	    return ResponseEntity.ok(atelier);
	}

	return ResponseEntity.notFound().build();
    }

    // @PostMapping("/linkToATopo")
    // public ResponseEntity<Atelier> linkToATopo(@RequestParam(value =
    // "atelier_id", required = true) Long atelier_id,
    // @RequestParam(value = "topo_id", required = true) Long topo_id) {
    //
    // Optional<Topo> topoOptional = topoRepository.findById(topo_id);
    // Optional<Atelier> atelierOptional = atelierRepository.findById(topo_id);
    //
    // if (topoOptional.isPresent() && atelierOptional.isPresent()) {
    //
    // Atelier atelier = atelierOptional.get();
    // atelier.setTopo(topoOptional.get());
    //
    // atelierRepository.save(atelier);
    //
    // return ResponseEntity.ok(atelier);
    // }
    //
    // return ResponseEntity.notFound().build();
    // }

    @PostMapping("/findAllActif")
    public ResponseEntity<List<Atelier>> findAllActif() {

	List<Atelier> atelierList = atelierRepository.findByDateDebutLessThanAndDateFinGreaterThanEqual(Instant.now(),
		Instant.now());

	if (!atelierList.isEmpty()) {

	    return ResponseEntity.ok(atelierList);
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/findById")
    public ResponseEntity<Atelier> findById(@RequestParam(value = "atelier_id", required = true) Long atelier_id) {

	Optional<Atelier> atelierOptional = atelierRepository.findById(atelier_id);

	if (atelierOptional.isPresent()) {

	    atelierOptional.get().setGeste(null);

	    return ResponseEntity.ok(atelierOptional.get());
	}

	return ResponseEntity.notFound().build();
    }

}
