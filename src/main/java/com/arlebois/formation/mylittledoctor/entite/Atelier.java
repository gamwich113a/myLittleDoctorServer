package com.arlebois.formation.mylittledoctor.entite;

import java.time.Instant;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Atelier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titre;
    private Instant dateDebut;
    private Instant dateFin;
    private String description;
    private String lieu;

    @OneToOne
    @JoinColumn(name = "createur_id")
    private Utilisateur createur;

    @OneToMany(mappedBy = "atelier")
    private List<Geste> geste;

    protected Atelier() {

    }

    public Atelier(String titre, Instant dateDebut, Instant dateFin, String description, String lieu,
	    Utilisateur createur) {
	this.titre = titre;
	this.dateDebut = dateDebut;
	this.dateFin = dateFin;
	this.description = description;
	this.lieu = lieu;
	this.createur = createur;
    }

}
