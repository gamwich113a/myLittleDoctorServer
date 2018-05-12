package com.arlebois.formation.mylittledoctor.entite;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Hopital {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String nom;
    private String ville;
    private int departement;

    protected Hopital() {

    }

    public Hopital(String nom, String ville, int departement) {
	this.nom = nom;
	this.ville = ville;
	this.departement = departement;
    }

}
