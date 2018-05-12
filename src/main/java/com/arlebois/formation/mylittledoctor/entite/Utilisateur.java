package com.arlebois.formation.mylittledoctor.entite;

import java.util.Date;

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
public class Utilisateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nom;
    private String prenom;
    private String mdp;
    private String email;
    private Date dateNaissance;
    private int sexe;
    private int role;

    @OneToOne
    @JoinColumn(name = "cursus_id")
    private Cursus cursus;

    @OneToOne
    @JoinColumn(name = "atelier_en_cours")
    private Atelier atelierEnCours;

    protected Utilisateur() {

    }

    public Utilisateur(String nom, String prenom, String mdp, String email, Date dateNaissance, int sexe, Cursus cursus,
	    int role) {
	this.nom = nom;
	this.prenom = prenom;
	this.mdp = mdp;
	this.dateNaissance = dateNaissance;
	this.sexe = sexe;
	this.cursus = cursus;
	this.email = email;
	this.role = role;
    }

}
