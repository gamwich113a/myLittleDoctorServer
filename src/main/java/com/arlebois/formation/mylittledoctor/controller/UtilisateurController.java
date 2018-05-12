package com.arlebois.formation.mylittledoctor.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.NonTransientDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Cursus;
import com.arlebois.formation.mylittledoctor.entite.EnumRole;
import com.arlebois.formation.mylittledoctor.entite.Hopital;
import com.arlebois.formation.mylittledoctor.entite.Utilisateur;
import com.arlebois.formation.mylittledoctor.repository.AtelierRepository;
import com.arlebois.formation.mylittledoctor.repository.CursusRepository;
import com.arlebois.formation.mylittledoctor.repository.HopitalRepository;
import com.arlebois.formation.mylittledoctor.repository.UtilisateurRepository;

@RestController
@RequestMapping("/user")
public class UtilisateurController {

    private final static Logger LOGGER = Logger.getAnonymousLogger();

    @Autowired
    private UtilisateurRepository utilisateurRepo;

    @Autowired
    private CursusRepository cursusRepository;

    @Autowired
    private HopitalRepository hopitalRepository;

    @Autowired
    private AtelierRepository atelierRepository;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

    @PostMapping("/create")
    public ResponseEntity<Utilisateur> createUser(@RequestParam(value = "nom", required = true) String nom,
	    @RequestParam(value = "prenom", required = true) String prenom,
	    @RequestParam(value = "motDePasse", required = true) String motDePasse,
	    @RequestParam(value = "dateNaissance", required = true) String dateNaissance,
	    @RequestParam(value = "email", required = true) String email,
	    @RequestParam(value = "sexe", required = true) Integer sexe,
	    @RequestParam(value = "role", required = true) Integer role,
	    @RequestParam(value = "anneeDes", required = false) Integer anneeDes,
	    @RequestParam(value = "regionFormation", required = false) Integer regionFormation,
	    @RequestParam(value = "hopital_id", required = true) Long hopital_id) throws ParseException {

	Optional<Hopital> hopital = hopitalRepository.findById(hopital_id);

	if (hopital.isPresent()) {

	    Cursus cursus = new Cursus(anneeDes, regionFormation, hopital.get());
	    cursusRepository.save(cursus);

	    Date dateNaissanceFormat = sdf.parse(dateNaissance);

	    Utilisateur personne = new Utilisateur(nom, prenom, motDePasse, email, dateNaissanceFormat, sexe, cursus,
		    role == 0 ? EnumRole.getValue(EnumRole.ETUDIANT) : EnumRole.getValue(EnumRole.FORMATEUR));

	    try {
		utilisateurRepo.save(personne);
	    } catch (NonTransientDataAccessException e) {
		LOGGER.log(Level.SEVERE, "Exception when call save on UtilisateurRepository " + e);
		return ResponseEntity.badRequest().build();
	    }

	    return ResponseEntity.ok(personne);
	}

	LOGGER.log(Level.SEVERE, "Hopital_id send not exist " + hopital_id);

	return ResponseEntity.notFound().build();
    }

    @PostMapping("/update")
    public ResponseEntity<Utilisateur> UpdateUser(@RequestParam(value = "nom", required = true) String nom,
	    @RequestParam(value = "prenom", required = true) String prenom,
	    @RequestParam(value = "motDePasse", required = true) String motDePasse,
	    @RequestParam(value = "dateNaissance", required = true) String dateNaissance,
	    @RequestParam(value = "email", required = true) String email,
	    @RequestParam(value = "sexe", required = true) int sexe,
	    @RequestParam(value = "anneeDes", required = true) int anneeDes,
	    @RequestParam(value = "regionFormation", required = true) int regionFormation,
	    @RequestParam(value = "hopital_id", required = true) long hopital_id,
	    @RequestParam(value = "utilisateur_id", required = true) long utilisateur_id) throws ParseException {

	Optional<Utilisateur> personneOptional = utilisateurRepo.findById(utilisateur_id);

	if (personneOptional.isPresent()) {
	    Utilisateur personne = personneOptional.get();

	    Date dateNaissanceFormat = sdf.parse(dateNaissance);

	    personne.setNom(nom);
	    personne.setPrenom(prenom);
	    personne.setMdp(motDePasse);
	    personne.setDateNaissance(dateNaissanceFormat);
	    personne.setSexe(sexe);
	    personne.setEmail(email);

	    Cursus cursus = personne.getCursus();
	    cursus.setAnneeDes(anneeDes);
	    cursus.setRegionFormation(regionFormation);

	    Optional<Hopital> hopitalOptional = hopitalRepository.findById(hopital_id);

	    if (hopitalOptional.isPresent()) {
		cursus.setHopital(hopitalOptional.get());

		cursusRepository.save(cursus);
		utilisateurRepo.save(personne);

		return ResponseEntity.ok(personne);
	    } else {
		LOGGER.log(Level.SEVERE, "Hopital_id send not exist " + hopital_id);
	    }
	} else {
	    LOGGER.log(Level.SEVERE, "utilisateur_id send not exist " + hopital_id);
	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getByNomAndPrenom")
    public ResponseEntity<Utilisateur> getByNomAndPrenom(@RequestParam(value = "nom", required = true) String nom,
	    @RequestParam(value = "prenom", required = true) String prenom) {

	List<Utilisateur> utilisateurList = utilisateurRepo.findByNomIgnoreCaseAndPrenomIgnoreCase(nom, prenom);

	if (utilisateurList.size() == 1) {
	    return ResponseEntity.ok(utilisateurList.get(0));
	} else if (utilisateurList.size() > 1) {
	    LOGGER.log(Level.SEVERE, "utilisateur nom " + nom + " and prenom " + prenom + " is not uniq ");
	} else {
	    LOGGER.log(Level.SEVERE, "utilisateur nom " + nom + " and prenom " + prenom + " not found ");
	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/getByNomAndPrenomAndMdp")
    public ResponseEntity<Utilisateur> getByNomAndPrenomAndMdp(@RequestParam(value = "nom", required = true) String nom,
	    @RequestParam(value = "prenom", required = true) String prenom,
	    @RequestParam(value = "mdp", required = true) String mdp) {

	List<Utilisateur> utilisateurList = utilisateurRepo.findByNomIgnoreCaseAndPrenomIgnoreCaseAndMdp(nom, prenom,
		mdp);

	if (utilisateurList.size() == 1) {

	    return ResponseEntity.ok(utilisateurList.get(0));

	} else if (utilisateurList.size() > 1) {
	    LOGGER.log(Level.SEVERE, "utilisateur nom " + nom + " and prenom " + prenom + " is not uniq ");
	} else {
	    LOGGER.log(Level.SEVERE, "utilisateur nom " + nom + " and prenom " + prenom + " not found ");
	}
	return ResponseEntity.notFound().build();
    }

    @PostMapping("/linkToAtelier")
    public ResponseEntity linkToAtelier(@RequestParam(value = "utilisateur_id", required = true) long utilisateur_id,
	    @RequestParam(value = "atelier_id", required = false) Long atelier_id) {

	Optional<Utilisateur> personneOptional = utilisateurRepo.findById(utilisateur_id);
	Optional<Atelier> atelierOptional = atelierRepository.findById(atelier_id);

	if (personneOptional.isPresent() && (atelierOptional.isPresent() || atelier_id == -1L)) {

	    Utilisateur utilisateur = personneOptional.get();
	    if (atelier_id == -1L) {
		utilisateur.setAtelierEnCours(null);
	    } else {
		utilisateur.setAtelierEnCours(atelierOptional.get());
	    }

	    utilisateurRepo.save(utilisateur);

	    return ResponseEntity.ok(null);
	}

	return ResponseEntity.notFound().build();
    }

}
