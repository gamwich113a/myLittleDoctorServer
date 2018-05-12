package com.arlebois.formation.mylittledoctor.repository;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Rapport;

public interface RapportRepository extends CrudRepository<Rapport, Long> {

}