package com.arlebois.formation.mylittledoctor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Utilisateur;

public interface UtilisateurRepository extends CrudRepository<Utilisateur, Long> {

    List<Utilisateur> findByNomIgnoreCaseAndPrenomIgnoreCaseAndMdp(String nom, String prenom, String mdp);

    List<Utilisateur> findByNomIgnoreCaseAndPrenomIgnoreCase(String nom, String prenom);

}