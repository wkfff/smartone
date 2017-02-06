package com.siping.ecm.bean;

import java.util.Date;
import java.util.List;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.siping.bom.bean.Bom;
import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.Document;
import com.siping.mat.bean.Material;
import com.siping.web.utility.BeanDateDeserializer;
import com.siping.web.utility.BeanDateSerializer;

public class EngineerChange extends BusinessData {
    public static final String KEY = "changeNo";
    private Date startDate;
    private Date endDate;
    private String reason;
    private List<Document> documents;
    private List<Material> materials;
    private List<Bom> boms;

    @JsonSerialize(using = BeanDateSerializer.class)
    public Date getStartDate() {
        return startDate;
    }

    @JsonDeserialize(using = BeanDateDeserializer.class)
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @JsonSerialize(using = BeanDateSerializer.class)
    public Date getEndDate() {
        return endDate;
    }

    @JsonDeserialize(using = BeanDateDeserializer.class)
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public List<Document> getDocuments() {
        return documents;
    }

    public void setDocuments(List<Document> documents) {
        this.documents = documents;
    }

    public List<Material> getMaterials() {
        return materials;
    }

    public void setMaterials(List<Material> materials) {
        this.materials = materials;
    }

    public List<Bom> getBoms() {
        return boms;
    }

    public void setBoms(List<Bom> boms) {
        this.boms = boms;
    }
}
