package com.arlebois.formation.mylittledoctor.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Geste;
import com.arlebois.formation.mylittledoctor.repository.AtelierRepository;
import com.arlebois.formation.mylittledoctor.repository.GesteRepository;

@RestController
@RequestMapping("/geste")
public class GesteController {

    private final static Logger LOGGER = Logger.getAnonymousLogger();

    @Autowired
    private GesteRepository gesteRepo;

    @Autowired
    private AtelierRepository atelierRepo;

    @PostMapping("/findByDescription")
    public ResponseEntity<List<Geste>> findByDescription(
	    @RequestParam(value = "description", required = true) String description) {

	List<Geste> liste = gesteRepo.findByDescriptionContainingIgnoreCase(description);

	if (liste.isEmpty()) {
	    return ResponseEntity.ok(liste);
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/findAll")
    public ResponseEntity<List<Geste>> findAll() {

	List<Geste> allGeste = new ArrayList<>();

	gesteRepo.findAll().forEach(allGeste::add);

	return ResponseEntity.ok(allGeste);
    }

    @PostMapping("/findById")
    public ResponseEntity<Geste> findById(@RequestParam(value = "id", required = true) long id) {

	Optional<Geste> gesteOptional = gesteRepo.findById(id);

	if (gesteOptional.isPresent()) {
	    return ResponseEntity.ok(gesteOptional.get());
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/findByAtelierId")
    public ResponseEntity<List<Geste>> findByAtelierId(
	    @RequestParam(value = "atelier_id", required = true) long atelierId) {

	Optional<Atelier> atelierOptional = atelierRepo.findById(atelierId);

	if (atelierOptional.isPresent()) {

	    List<Geste> gestes = gesteRepo.findByAtelier(atelierOptional.get());

	    return ResponseEntity.ok(gestes);

	}

	return ResponseEntity.notFound().build();
    }

}
