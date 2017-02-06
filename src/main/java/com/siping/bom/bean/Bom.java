package com.siping.bom.bean;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.mat.bean.Material;
import com.siping.web.utility.BeanDateDeserializer;
import com.siping.web.utility.BeanDateSerializer;

public class Bom extends BusinessData {
    public static final String KEY = "bom";

    private String factoryId;
    private Material material;
    private EngineerChange changeNo;
    private Float looseRate;

    private Date startDate;

    public String getFactoryId() {
        return factoryId;
    }

    public void setFactoryId(String factoryId) {
        this.factoryId = factoryId;
    }

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }

    public EngineerChange getChangeNo() {
        return changeNo;
    }

    public void setChangeNo(EngineerChange changeNo) {
        this.changeNo = changeNo;
    }

    public Float getLooseRate() {
        return looseRate;
    }

    public void setLooseRate(Float looseRate) {
        this.looseRate = looseRate;
    }

    @JsonSerialize(using = BeanDateSerializer.class)
    public Date getStartDate() {
        return startDate;
    }

    @JsonDeserialize(using = BeanDateDeserializer.class)
    public void setStartDate(Date starDate) {
        this.startDate = starDate;
    }

}
