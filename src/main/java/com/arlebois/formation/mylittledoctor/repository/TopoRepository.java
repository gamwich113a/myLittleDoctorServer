package com.arlebois.formation.mylittledoctor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.Topo;

public interface TopoRepository extends CrudRepository<Topo, Long> {

    List<Topo> findByTitre(String titre);

    List<Topo> findByAtelierIdAndEtape(Long atelierId, Integer etape);

    List<Topo> findByAtelierId(Long atelierId);
}