package com.myexample.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.myexample.model.Audit;
import com.myexample.model.JsonDashboardData;
import com.myexample.model.JsonDocumentData;
import com.myexample.model.Registration;
import com.myexample.service.AdminService;
import com.myexample.service.ApplicationSessionListener;
import com.myexample.service.DocumentService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = Logger.getLogger(AdminController.class);
	String className = this.getClass().getSimpleName();

	@Autowired
	private AdminService adminService;

	@Autowired
	private DocumentService documentService;
	/****
	 * @author Sanket.Navale Redirect Admin page
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonGenerationException
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public ModelAndView view() throws JsonGenerationException, JsonMappingException, IOException {
		String classMethod = className + ":  view";
		logger.info(String.format("Enter into " + classMethod + "()"));
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			Registration registrtaion = (Registration) auth.getPrincipal();

			if (registrtaion.getRole().equals("ROLE_ADMIN")) {

				ObjectMapper mapper = new ObjectMapper();
				List<JsonDashboardData> dashobardList = new ArrayList<JsonDashboardData>();
				Map<String, String> model = new HashMap<String, String>();
				JsonDashboardData dasboard = new JsonDashboardData();

				dasboard.setTotalActiveUser(ApplicationSessionListener.getTotalActiveSession());
				dasboard.setTotalDocuments(100);
				dasboard.setTotalSubscription(20);
				dasboard.setTotalUsers(200);
				dashobardList.add(dasboard);
				model.put("dashbaordList", mapper.writeValueAsString(dashobardList));
				return new ModelAndView("view",model);
			}
		} else {
			return new ModelAndView("redirect:/login");
		}
		logger.info("exit from " + classMethod);
		return new ModelAndView("redirect:/login");
	}

	/***
	 * @author Sanket.Navale Render Completed Documents Data
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/userlist", method = RequestMethod.GET)
	public ModelAndView getAllUserList() throws JsonGenerationException, JsonMappingException, IOException {
		String classMethod = className + ":  view";
		logger.info(String.format("Enter into " + classMethod + "()"));

		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> model = new HashMap<String, String>();
		List<Registration> userList = new ArrayList<Registration>();

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			Registration user = (Registration) auth.getPrincipal();
			String role = user.getRole();

			if (role.equals("ROLE_ADMIN")) {
				userList = adminService.getUserList();
			}
		}

		logger.info("getUserList Data " + mapper.writeValueAsString(userList));
		model.put("userlist", mapper.writeValueAsString(userList));

		logger.info("exit from " + classMethod);
		return new ModelAndView("userlist", model);
	}

	@RequestMapping(value = "/userdetail", method = RequestMethod.GET)
	public ModelAndView getUserDetails(@RequestParam("email") String email)
			throws JsonGenerationException, JsonMappingException, IOException {
		String classMethod = className + ":  view";
		logger.info(String.format("Enter into " + classMethod + "()"));

		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> model = new HashMap<String, String>();
		/*
		 * List<Registration> userList = new ArrayList<Registration>();
		 * 
		 * Authentication auth =
		 * SecurityContextHolder.getContext().getAuthentication();
		 * if(auth!=null){ Registration user = (Registration)
		 * auth.getPrincipal(); String role = user.getRole();
		 * 
		 * if(role.equals("ROLE_ADMIN")){ userList = adminService.getUserList();
		 * } }
		 * 
		 * logger.info("getUserList Data " +
		 * mapper.writeValueAsString(userList)); model.put("userlist",
		 * mapper.writeValueAsString(userList));
		 */
		model.put("classActiveSettings","active");
		model.put("redirecPage","userdetail");
		logger.info("exit from " + classMethod);
		return new ModelAndView("userdetail", model);
	}
	
	/*
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/completed", method = RequestMethod.GET)
	public void completed(HttpServletRequest request, HttpServletResponse response,@RequestParam("userId") String userId)throws IOException {
		List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
		jsonDocList = documentService.completedDocuments(userId == null ? 0 : Integer.parseInt(userId));
		ObjectMapper mapper = new ObjectMapper();
		logger.info("CompletedDocuments Data " + mapper.writeValueAsString(jsonDocList));
		response.setContentType("application/json");
		String json = new Gson().toJson(jsonDocList);
		try {
			response.getWriter().write(json);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
	}
	
	/***
	 * @author Sanket.Navale Render document history
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/documenthistory", method = RequestMethod.GET)
	public ModelAndView documentHistory() throws JsonGenerationException, JsonMappingException, IOException {
		List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
		jsonDocList = documentService.getDocumentsHistory();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> model = new HashMap<String, String>();
		logger.info("CompletedDocuments Data " + mapper.writeValueAsString(jsonDocList));
		model.put("list", mapper.writeValueAsString(jsonDocList));
		return new ModelAndView("dcoumentHistory", model);
		
	}
	
	/***
	 * @author Sanket.Navale Render document history
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/webservicelogs", method = RequestMethod.GET)
	public ModelAndView webserviceLogs() throws JsonGenerationException, JsonMappingException, IOException {
		List<Audit> auditList = new ArrayList<Audit>();
		auditList = documentService.getWebserviceLogs();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> model = new HashMap<String, String>();
		logger.info("CompletedDocuments Data " + mapper.writeValueAsString(auditList));
		model.put("list", mapper.writeValueAsString(auditList));
		return new ModelAndView("webservicelogs", model);
		
	}
}
