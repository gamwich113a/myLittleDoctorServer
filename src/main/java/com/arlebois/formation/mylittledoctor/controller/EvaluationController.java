package com.arlebois.formation.mylittledoctor.controller;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Evaluation;
import com.arlebois.formation.mylittledoctor.entite.Geste;
import com.arlebois.formation.mylittledoctor.entite.Utilisateur;
import com.arlebois.formation.mylittledoctor.repository.AtelierRepository;
import com.arlebois.formation.mylittledoctor.repository.EvaluationRepository;
import com.arlebois.formation.mylittledoctor.repository.GesteRepository;
import com.arlebois.formation.mylittledoctor.repository.UtilisateurRepository;

import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/evaluation")
public class EvaluationController {

    @Autowired
    private EvaluationRepository evaluationRepo;

    @Autowired
    private UtilisateurRepository utilisateurRepo;

    @Autowired
    private GesteRepository gesteRepo;

    @Autowired
    private AtelierRepository atelierRepo;

    // @GetMapping("/create")
    // public ResponseEntity createEvaluation(@RequestParam(value = "commentaire",
    // required = true) String commentaire,
    // @RequestParam(value = "note", required = true) Integer note,
    // @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id,
    // @RequestParam(value = "atelier_id", required = false) Long atelier_id) {
    //
    // // atelier_id n est pas obligatoire
    // // ca permet d'avoir une evaluation sur un utilisateur
    //
    // //////////////////////////////////////////////////////// CREATE for atelier
    // //////////////////////////////////////////////////////// cree deux version du
    // //////////////////////////////////////////////////////// create evaluation
    // june
    // //////////////////////////////////////////////////////// par atelier et une
    // sans
    // //////////////////////////////////////////////////////// atelier , niveau
    // //////////////////////////////////////////////////////// utilisateur oiur
    // regler
    // //////////////////////////////////////////////////////// le souci de Atelier
    // //////////////////////////////////////////////////////// vide
    //
    // Optional<Utilisateur> personneOptional =
    // utilisateurRepo.findById(utilisateur_id);
    //
    // if (personneOptional.isPresent()) {
    //
    // Optional<Atelier> atelierOptional = atelierRepo.findById(utilisateur_id);
    // Evaluation evt;
    //
    // if (atelierOptional.isPresent()) {
    // Atelier atelier = atelierOptional.get();
    // evt = new Evaluation(Instant.EPOCH, note, commentaire,
    // personneOptional.get(), atelier);
    // } else {
    // evt = new Evaluation(Instant.EPOCH, note, commentaire,
    // personneOptional.get(), null);
    // }
    //
    // evaluationRepo.save(evt);
    //
    // return ResponseEntity.ok(evt);
    // }
    //
    // return ResponseEntity.notFound().build();
    //
    // }

    @PostMapping("/getEvaluationById")
    public ResponseEntity<Evaluation> getEvaluationById(
	    @RequestParam(value = "evaluation_id", required = true) Long evaluation_id) {

	Optional<Evaluation> evtOptional = evaluationRepo.findById(evaluation_id);
	if (evtOptional.isPresent()) {
	    return ResponseEntity.ok(evtOptional.get());
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getEvaluationByUtilisateur")
    public ResponseEntity<List<Evaluation>> getEvaluationByUtilisateur(
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id) {

	Optional<Utilisateur> utilisateurOptional = utilisateurRepo.findById(utilisateur_id);

	if (utilisateurOptional.isPresent()) {

	    List<Evaluation> evaluations = evaluationRepo.findByCreateur(utilisateurOptional.get());

	    if (!evaluations.isEmpty()) {
		return ResponseEntity.ok(evaluations);
	    }
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/sauvegardeEvaluationListSurGeste")
    public ResponseEntity<Iterable<Evaluation>> sauvegardeEvaluationListSurGeste(
	    @ApiParam("Envoi liste d evaluation sur geste") @RequestBody List<Evaluation> evaluation,
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id) {

	Optional<Utilisateur> utilisateurOptional = utilisateurRepo.findById(utilisateur_id);

	if (utilisateurOptional.isPresent()) {

	    // Il s evalue sur un geste et pas sur autre chose
	    evaluation.stream().forEach(geste -> {
		geste.setId(null);
		geste.setDateSaisie(Instant.now());
		geste.setCreateur(utilisateurOptional.get());
		geste.setFormateur(null);
		geste.setAtelier(null);
		// attente de retour delo pour savoir si lon doit aussi set a null le nombre de
		// pratique par an
	    });

	    Iterable<Evaluation> saveIterator = evaluationRepo.saveAll(evaluation);

	    return ResponseEntity.ok(saveIterator);

	} else {
	    System.out.println("Utilisateur non trouve" + utilisateur_id);
	}

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/sauvegardeEvaluationSurGeste")
    public ResponseEntity<Evaluation> sauvegardeEvaluationSurGeste(
	    @RequestParam(value = "note", required = false) Integer note,
	    @RequestParam(value = "nbPratique", required = false) Integer nbPratique,
	    @RequestParam(value = "commentaire", required = true) String commentaire,
	    @RequestParam(value = "geste_id", required = true) Long geste_id,
	    @RequestParam(value = "utilisateur_id", required = true) Long utilisateur_id,
	    @RequestParam(value = "atelier_id", required = false) Long atelier_id) {

	Optional<Utilisateur> utilisateurOptional = utilisateurRepo.findById(utilisateur_id);
	Optional<Geste> gesteOptional = gesteRepo.findById(geste_id);

	if (utilisateurOptional.isPresent() && gesteOptional.isPresent()) {

	    String commentaireData = "Commentaire".equals(commentaire) ? null : commentaire;

	    Evaluation eval = new Evaluation(Instant.now(), note, nbPratique, commentaireData,
		    utilisateurOptional.get(), gesteOptional.get());

	    if (atelier_id != null) {
		Optional<Atelier> atelierOpt = atelierRepo.findById(atelier_id);
		if (atelierOpt.isPresent()) {
		    eval.setAtelier(atelierOpt.get());
		}
	    }

	    eval = evaluationRepo.save(eval);

	    return ResponseEntity.ok(eval);

	} else {
	    System.out.println("Utilisateur non trouve " + utilisateur_id + " ou geste non trouve " + geste_id);
	}

	return ResponseEntity.notFound().build();
    }

}
