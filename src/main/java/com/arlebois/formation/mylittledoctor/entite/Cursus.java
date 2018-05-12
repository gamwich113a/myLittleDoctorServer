package com.arlebois.formation.mylittledoctor.entite;

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
public class Cursus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private Integer anneeDes;
    private Integer regionFormation;

    @OneToOne
    @JoinColumn(name = "hopital_id")
    private Hopital hopital;

    protected Cursus() {

    }

    public Cursus(Integer anneeDes, Integer regionFormation, Hopital hopital) {
	this.anneeDes = anneeDes;
	this.regionFormation = regionFormation;
	this.hopital = hopital;
    }

}
