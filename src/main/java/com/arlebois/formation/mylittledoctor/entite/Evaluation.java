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
public class Evaluation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Instant dateSaisie;
    private Integer note;
    private String commentaire;
    private Integer nombrePratiqueAn;

    @OneToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur createur;

    @OneToOne
    @JoinColumn(name = "atelier_id")
    private Atelier atelier;

    @OneToOne
    @JoinColumn(name = "geste_id")
    private Geste geste;

    @OneToOne
    @JoinColumn(name = "formateur_id")
    private Utilisateur formateur;

    protected Evaluation() {

    }

    public Evaluation(Instant dateSaisie, Integer note, Integer nombrePratiqueAn, String commentaire,
	    Utilisateur createur, Geste geste) {
	this.dateSaisie = dateSaisie;
	this.note = note;
	this.nombrePratiqueAn = nombrePratiqueAn;
	this.commentaire = commentaire;
	this.createur = createur;
	this.geste = geste;
    }

}
