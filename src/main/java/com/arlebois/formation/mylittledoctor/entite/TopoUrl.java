package com.arlebois.formation.mylittledoctor.entite;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class TopoUrl {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titre;
    private String url;
    private Integer type;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topo_id")
    private Topo topo;

    protected TopoUrl() {

    }

    public TopoUrl(String titre, String url, Topo topo) {
	this.titre = titre;
	this.url = url;
	this.topo = topo;
    }

}
