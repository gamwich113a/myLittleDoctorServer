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
public class Topo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titre;
    private String description;
    private Instant dateSaisie;
    private Instant dateUpdate;
    private Integer etape;

    @OneToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur creator;

    @OneToOne
    @JoinColumn(name = "atelier_id")
    private Atelier atelier;

    @OneToMany(mappedBy = "topo")
    private List<TopoUrl> topoUrlList;

    protected Topo() {

    }

    public Topo(String titre, String description, Instant dateSaisie, Instant dateUpdate, Utilisateur creator) {
	this.titre = titre;
	this.description = description;
	this.dateSaisie = dateSaisie;
	this.dateUpdate = dateUpdate;
	this.creator = creator;
    }

}
