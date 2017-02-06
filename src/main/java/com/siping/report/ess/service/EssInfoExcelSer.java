package com.siping.report.ess.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface EssInfoExcelSer {

    public void viewWhInfoReport(HttpServletRequest request, HttpServletResponse response);

    public void viewWhConclusion(HttpServletRequest request, HttpServletResponse response);

    public void viewWhConclusionSum(HttpServletRequest request, HttpServletResponse response);
}
