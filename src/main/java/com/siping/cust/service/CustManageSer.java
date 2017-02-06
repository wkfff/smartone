package com.siping.cust.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.siping.cust.bean.Customer;

public interface CustManageSer {
    public Customer getCustomerDetail(HttpServletRequest request);

    public String removeCustomer(HttpServletRequest request, String customerId, String removeRemark) throws SQLException;

    public String checkCustomerID(HttpServletRequest request);

    public String changeCustomerEMPID(HttpServletRequest request);

    public String updateCustomer(HttpServletRequest request, Customer customer) throws SQLException;

    public String addCustomer(HttpServletRequest request, Customer customer) throws SQLException;

    public Customer getCustomerNameById(HttpServletRequest request);

    public void downloadCustsTemp(HttpServletRequest request, HttpServletResponse response);

    public String uploadCustInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception;

    @SuppressWarnings("rawtypes")
    public List getCustColumnList() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getCustTmpInfoList() throws Exception;

    public String saveCustTmpInfo(HttpServletRequest request) throws Exception;
}
