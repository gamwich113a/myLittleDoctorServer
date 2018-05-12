package com.arlebois.formation.mylittledoctor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Evaluation;
import com.arlebois.formation.mylittledoctor.entite.Utilisateur;

public interface EvaluationRepository extends CrudRepository<Evaluation, Long> {

    List<Atelier> findByAtelier(Atelier atelier);

    List<Evaluation> findByCreateur(Utilisateur createur);

}