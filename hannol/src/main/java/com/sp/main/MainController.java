package com.sp.main;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("mainController")
public class MainController {
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String method() {
		

/*		String temp = new BCryptPasswordEncoder().encode("test");
		System.out.println(temp);
		*/
		return ".mainLayout";
	}
}
