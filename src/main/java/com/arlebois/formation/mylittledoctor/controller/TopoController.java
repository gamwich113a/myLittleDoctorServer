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

import com.arlebois.formation.mylittledoctor.entite.Topo;
import com.arlebois.formation.mylittledoctor.entite.TopoUrl;
import com.arlebois.formation.mylittledoctor.entite.Utilisateur;
import com.arlebois.formation.mylittledoctor.repository.TopoRepository;
import com.arlebois.formation.mylittledoctor.repository.TopoUrlRepository;
import com.arlebois.formation.mylittledoctor.repository.UtilisateurRepository;

@RestController
@RequestMapping("/topo")
public class TopoController {

    @Autowired
    private UtilisateurRepository utilisateurRepo;

    @Autowired
    private TopoRepository topoRepository;

    @Autowired
    private TopoUrlRepository topoUrlRepository;

    @PostMapping("/create")
    public ResponseEntity<Topo> createTopo(@RequestParam(value = "titre", required = true) String titre,
	    @RequestParam(value = "description", required = true) String description,
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id) {

	Optional<Utilisateur> personneOptional = utilisateurRepo.findById(utilisateur_id);

	if (personneOptional.isPresent()) {

	    Topo topo = new Topo(titre, description, Instant.now(), Instant.now(), personneOptional.get());
	    topoRepository.save(topo);
	    return ResponseEntity.ok(topo);
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/update")
    public ResponseEntity<Topo> updateTopo(@RequestParam(value = "titre", required = true) String titre,
	    @RequestParam(value = "description", required = true) String description,
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id,
	    @RequestParam(value = "topo_id", required = true) Long topo_id) {

	Optional<Utilisateur> personneOptional = utilisateurRepo.findById(utilisateur_id);
	Optional<Topo> topoOptional = topoRepository.findById(topo_id);

	if (personneOptional.isPresent() && topoOptional.isPresent()) {

	    Topo topo = topoOptional.get();

	    topo.setDateUpdate(Instant.now());
	    topo.setDescription(description);
	    topo.setTitre(titre);

	    topoRepository.save(topo);
	    return ResponseEntity.ok(topo);
	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getTopoByTitre")
    public ResponseEntity<Topo> updateTopo(@RequestParam(value = "titre", required = true) String titre) {

	List<Topo> topoList = topoRepository.findByTitre(titre);

	if (topoList.size() > 0) {
	    return ResponseEntity.ok(topoList.get(0));
	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/addUrl")
    public ResponseEntity<TopoUrl> addUrl(@RequestParam(value = "titre", required = true) String titre,
	    @RequestParam(value = "url", required = true) String url,
	    @RequestParam(value = "topo_id", required = true) Long topo_id) {

	Optional<Topo> topoOptional = topoRepository.findById(topo_id);

	if (topoOptional.isPresent()) {
	    Topo topo = topoOptional.get();

	    TopoUrl topoUrl = new TopoUrl(titre, url, topo);

	    topoUrlRepository.save(topoUrl);

	    return ResponseEntity.ok(topoUrl);

	}
	return ResponseEntity.notFound().build();
    }

    // @PostMapping("/getTopoUrlByTopoId")
    // public ResponseEntity<List<TopoUrl>> getTopoUrlByTopoId(
    // @RequestParam(value = "topo_id", required = true) Long topo_id) {
    //
    // Optional<Topo> topoOptional = topoRepository.findById(topo_id);
    //
    // if (topoOptional.isPresent()) {
    // Topo topo = topoOptional.get();
    //
    // return ResponseEntity.ok(topoUrlRepository.findByTopoId(topo.getId()));
    //
    // }
    // return ResponseEntity.notFound().build();
    // }

    @PostMapping("/getTopoById")
    public ResponseEntity<Topo> getTopoById(@RequestParam(value = "topo_id", required = true) Long topo_id) {

	Optional<Topo> topoOptional = topoRepository.findById(topo_id);

	if (topoOptional.isPresent()) {

	    Topo topo = topoOptional.get();

	    return ResponseEntity.ok(topo);

	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getTopoUrlById")
    public ResponseEntity<TopoUrl> getTopoUrlById(
	    @RequestParam(value = "topoUrl_id", required = true) Long topoUrl_id) {

	Optional<TopoUrl> topoUrlOptional = topoUrlRepository.findById(topoUrl_id);

	if (topoUrlOptional.isPresent()) {

	    TopoUrl topoUrl = topoUrlOptional.get();

	    return ResponseEntity.ok(topoUrl);

	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getTopoByAtelierIdAndEtapeId")
    public ResponseEntity<Topo> getTopoByAtelierId(@RequestParam(value = "atelier_id", required = true) Long atelier_id,
	    @RequestParam(value = "etape", required = false) Integer etape) {

	List<Topo> topoList;

	if (etape != null) {
	    topoList = topoRepository.findByAtelierIdAndEtape(atelier_id, etape);
	} else {
	    topoList = topoRepository.findByAtelierId(atelier_id);
	}

	if (!topoList.isEmpty()) {

	    Topo topoPrincipal = topoList.get(0);

	    // // Avoid loop
	    // for (TopoUrl topourl : topoPrincipal.getTopoUrlList()) {
	    // topourl.setTopo(null);
	    // }
	    // topoPrincipal.getAtelier().setGeste(null);

	    return ResponseEntity.ok(topoPrincipal);

	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getTopoByAtelierIdAndEtapeNull")
    public ResponseEntity<Topo> getTopoByAtelierId(
	    @RequestParam(value = "atelier_id", required = true) Long atelier_id) {

	List<Topo> topoList;

	topoList = topoRepository.findByAtelierIdAndEtape(atelier_id, null);

	if (!topoList.isEmpty()) {

	    Topo topoPrincipal = topoList.get(0);

	    // // Avoid loop
	    // for (TopoUrl topourl : topoPrincipal.getTopoUrlList()) {
	    // topourl.setTopo(null);
	    // }

	    return ResponseEntity.ok(topoPrincipal);

	}
	return ResponseEntity.notFound().build();
    }

}
