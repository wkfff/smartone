package com.siping.mat.action;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siping.mat.service.MatCheckSer;

@Controller
@RequestMapping(value = "/mat/matCheck")
public class MatCheckController {

    @Autowired
    private MatCheckSer matCheckSer;

    @RequestMapping(value = "/checkDuplicate")
    @ResponseBody
    public String checkDuplicate(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.matCheckSer.checkDuplicate(request);
    }

}
