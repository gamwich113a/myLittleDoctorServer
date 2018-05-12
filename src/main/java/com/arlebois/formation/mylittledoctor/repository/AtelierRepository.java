package com.arlebois.formation.mylittledoctor.repository;

import java.time.Instant;
import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Atelier;

public interface AtelierRepository extends CrudRepository<Atelier, Long> {

    List<Atelier> findByTitre(String titre);

    List<Atelier> findByLieu(String lieu);

    List<Atelier> findByDateDebutLessThanAndDateFinGreaterThanEqual(Instant dateDebut, Instant dateFin);
}