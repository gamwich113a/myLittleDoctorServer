package com.arlebois.formation.mylittledoctor.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.arlebois.formation.mylittledoctor.entite.TopoUrl;

public interface TopoUrlRepository extends CrudRepository<TopoUrl, Long> {

    List<TopoUrl> findByUrl(String url);

    // List<TopoUrl> findByTopoId(long topoId);
}