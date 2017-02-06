package com.siping.productStorage.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface TaoBaoManageDao {
    public List<LinkedHashMap<String, Object>> getCustById(Object obj);
    
    public int checkOrderTaobao(Object obj);
    
    public int checkProTaobao(Object obj);
}
