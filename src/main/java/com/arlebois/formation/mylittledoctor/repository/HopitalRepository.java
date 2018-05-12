package com.arlebois.formation.mylittledoctor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Hopital;

public interface HopitalRepository extends CrudRepository<Hopital, Long> {

    List<Hopital> findByDepartement(int departement);

    List<Hopital> findByVilleContainingIgnoreCase(String ville);

    List<Hopital> findByNomContainingIgnoreCase(String nom);

}