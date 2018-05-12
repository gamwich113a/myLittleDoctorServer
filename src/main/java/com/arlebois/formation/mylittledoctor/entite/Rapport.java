package com.arlebois.formation.mylittledoctor.entite;

import java.time.Instant;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Rapport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titre;
    private Instant dateSaisie;
    private String rapport;

    @OneToOne
    @JoinColumn(name = "atelier_id")
    private Atelier atelier;

    @OneToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur createur;

    protected Rapport() {

    }

    public Rapport(String titre, Instant dateSaisie, String rapport, Utilisateur createur, Atelier atelier) {
	this.titre = titre;
	this.dateSaisie = dateSaisie;
	this.rapport = rapport;
	this.createur = createur;
	this.atelier = atelier;
    }

}
