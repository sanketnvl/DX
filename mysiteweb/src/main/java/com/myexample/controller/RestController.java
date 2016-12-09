package com.myexample.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myexample.model.User;
import com.myexample.service.DataService;




/**
 * @author Nagesh.Chauhan
 *
 */
@Controller
@RequestMapping("/api/users")
public class RestController {

	@Autowired
	DataService dataService;

	@RequestMapping(value = "/", method = RequestMethod.POST)
	@ResponseBody
	public List<User> list() {
		System.out.println("aman");
		return dataService.getUserList();

	}
}
