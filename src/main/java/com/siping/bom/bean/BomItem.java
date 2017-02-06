package com.siping.bom.bean;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonDeserialize;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.MasterData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.web.utility.BeanDateDeserializer;
import com.siping.web.utility.BeanDateSerializer;

public class BomItem extends MasterData {
    private Bom bom;
    private BomCategory bomCategory;
    private BusinessData material;
    private EngineerChange changeNo;
    private Integer amount;
    private Float looseRate;
    private Date startDate;
    private Date endDate;

    public Bom getBom() {
        return bom;
    }

    public void setBom(Bom bom) {
        this.bom = bom;
    }

    public BomCategory getBomCategory() {
        return bomCategory;
    }

    public void setBomCategory(BomCategory bomCategory) {
        this.bomCategory = bomCategory;
    }

    public BusinessData getMaterial() {
        return material;
    }

    public void setMaterial(BusinessData material) {
        this.material = material;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
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

    public EngineerChange getChangeNo() {
        return changeNo;
    }

    public void setChangeNo(EngineerChange changeNo) {
        this.changeNo = changeNo;
    }

}
