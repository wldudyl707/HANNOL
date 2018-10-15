package com.sp.company;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("company.companyController")
public class CompanyController {
	@RequestMapping(value="/company/info")
	public String info(Model model) throws Exception {
		model.addAttribute("subMenu", "1");
		return ".four.menu1.company.info";
	}
	
	@RequestMapping(value="/company/way")
	public String history(Model model) throws Exception {
		model.addAttribute("subMenu", "2");
		return ".four.menu1.company.way";
	}
	
	@RequestMapping(value="/company/guideMap")
	public String guideMap(Model model) throws Exception {
		model.addAttribute("subMenu", "3");
		return ".four.menu1.company.guidemap";
	}
	
}
