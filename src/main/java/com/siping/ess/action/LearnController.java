package com.siping.ess.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/ess/learn")
public class LearnController {


	@RequestMapping(value = "/learnAdmin", method = RequestMethod.GET)
	public ModelAndView learnAdmin(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/ess/learn/learnAdmin", modelMap);
	}

	@RequestMapping(value = "/learnHr", method = RequestMethod.GET)
	public ModelAndView learnHr(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/ess/learn/learnHr", modelMap);
	}
	
	@RequestMapping(value = "/learnNormal", method = RequestMethod.GET)
	public ModelAndView learnNormal(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/ess/learn/learnNormal", modelMap);
	}
	
	@RequestMapping(value = "/learnManager", method = RequestMethod.GET)
	public ModelAndView learnManager(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/ess/learn/learnManager", modelMap);
	}
}
