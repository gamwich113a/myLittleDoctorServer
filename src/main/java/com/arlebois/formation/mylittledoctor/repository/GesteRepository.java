package com.arlebois.formation.mylittledoctor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Atelier;
import com.arlebois.formation.mylittledoctor.entite.Geste;

public interface GesteRepository extends CrudRepository<Geste, Long> {

    List<Geste> findByDescriptionContainingIgnoreCase(String description);

    List<Geste> findByAtelier(Atelier atelier);

}