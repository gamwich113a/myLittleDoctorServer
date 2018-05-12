package com.arlebois.formation.mylittledoctor.entite;

public enum EnumRole {
    ETUDIANT(0), FORMATEUR(1), ADMINISTRATEUR(2);

    private int value;

    EnumRole(int value) {
	this.value = value;
    }

    public static int getValue(EnumRole role) {
	return role.value;
    }

}
