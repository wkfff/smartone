package com.siping.productStorage.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.taobao.api.domain.AddressResult;
import com.taobao.api.domain.Item;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.domain.LogisticsCompany;
import com.taobao.api.domain.Shop;
import com.taobao.api.domain.Trade;
import com.taobao.api.domain.User;

import javax.servlet.http.HttpServletRequest;

public interface TaoBaoManageSer {
    public User getSellerBySessionKey(HttpServletRequest request);
    
    public Shop getShopByNick(HttpServletRequest request);
    
    public List<Item> getTaoBaoProOnSale(HttpServletRequest request);
    
    public String removeProFromTaoBao(HttpServletRequest request);
    
    public List<Trade> getTaoBaoTradeList(HttpServletRequest request);
    
    public Trade getTaoBaoTradeDetailById(HttpServletRequest request,String tid);
    
    public String addOrUpdateProduct(HttpServletRequest request) throws Exception;
    
    @SuppressWarnings("rawtypes")
    public String updateTaoBaoItemOwnerId(HttpServletRequest request,Map map);
    
    public List<ItemCat> getTaoBaoCatById(HttpServletRequest request,String cid);
    
    public List<LinkedHashMap<String, Object>> getCustById(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List<Map> saveOrderFromTaobao(HttpServletRequest request) throws Exception;
    
    public String checkOrderTaobao(HttpServletRequest request,String taobaoId);
    
    public String checkProTaobao(HttpServletRequest request,String outer_id);
    
    public List<AddressResult> getSellerAddress(HttpServletRequest request);
    
    public List<LogisticsCompany> getLogCompanies(HttpServletRequest request);
    
    public String saveSend(HttpServletRequest request);
    
    public String updateItem(HttpServletRequest request);
}
