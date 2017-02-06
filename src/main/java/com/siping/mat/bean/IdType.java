package com.siping.mat.bean;

import org.codehaus.jackson.annotate.JsonCreator;

public enum IdType {
    INNER(1), OUTER(2), MIX(3);
    private Integer id;

    IdType(Integer id) {
        this.id = id;
    }

    @JsonCreator
    public static IdType create(Integer id) {
        IdType[] idTypes = IdType.values();
        for (IdType idType : idTypes) {
            if (idType.id == id) {
                return idType;
            }
        }
        return INNER;
    }
}
