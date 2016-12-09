package com.myexample.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myexample.dao.DaoException;
import com.myexample.model.Registration;
import com.myexample.service.RegisterService;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.DateManipulation;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.SendEmail;
import com.myexample.utility.UtilityException;
import com.myexample.validation.RegistrationValidation;


@Controller
public class FrontController {
	
	@Autowired
    private RegistrationValidation registrationValidation;
	@Autowired
	private RegisterService registerService;

	private static String SERVER_URL ;
	private static String EMAIL_BACKIMAGE ;
	private static String EMAIL_SOURCEHOV_LOGO ;
	private static String EMAIL_DRYSIGN_LOGO ;
	private static final Logger logger = Logger.getLogger(FrontController.class);

	
		public FrontController() 
		{
			try {
				SERVER_URL = new GlobalFunctions().getServerUrl();
				EMAIL_BACKIMAGE=new GlobalFunctions().getEmailBackGroundImage();
				EMAIL_SOURCEHOV_LOGO=new GlobalFunctions().getEmailSourceHOVlogo();
				EMAIL_DRYSIGN_LOGO=new GlobalFunctions().getEmailDrySignLogo();
				
			} catch (UtilityException e) {
				logger.error("Error while getting upload path: "+e.getMessage());
			}
		}

	
	   /* @RequestMapping(value = "/home", method = RequestMethod.GET)
	    public ModelAndView login(@Validated User user, Model model, HttpServletRequest request) 
	    {
	    	logger.info(String.format("login(user = %s ,model = %s, request = %s)", user,model,request));
	        return new ModelAndView("redirect:/pdf");
	    }*/
 	    
	    @RequestMapping(value = "/upload", method = RequestMethod.GET)
	    public String upload(ModelMap map) {
	 
	        return "editEmployeeList";
	    }
	 	 
	    @RequestMapping(value = "/", method = RequestMethod.GET)
	    public ModelAndView login(ModelMap model) 
	    {
	    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if(auth == null)
			{
				return new ModelAndView("redirect:/login");
			}else if(!(auth instanceof AnonymousAuthenticationToken))
			{   
				Registration registrtaion = (Registration) auth.getPrincipal();
				if(registrtaion.getRole().equals("ROLE_ADMIN")){
					return new ModelAndView("redirect:/admin/view");
				}
				return new ModelAndView("redirect:/app/web");
			}else{
				return new ModelAndView("redirect:/login");
			}
	    }
	    @RequestMapping(value = "/web", method = RequestMethod.GET)
	    public ModelAndView web(ModelMap model) 
	    {
	    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    	if(auth == null)
			{
				return new ModelAndView("redirect:/login");
			}else
			{   
				Registration registrtaion = (Registration) auth.getPrincipal();
				if(registrtaion.getRole().equals("ROLE_ADMIN")){
					return new ModelAndView("redirect:/admin/view");
				}
				return new ModelAndView("redirect:/app/web");
			}
		}
	    
	    
	    @RequestMapping(value = "/login", method = RequestMethod.GET)
	    public ModelAndView log(ModelMap model,HttpServletRequest request) 
	    {
	    	
	    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    	
	    	/*if(auth !=null){
	    		 return new ModelAndView("redirect:/app/web");
	    	}*/
	    	if (!(auth instanceof AnonymousAuthenticationToken) && auth!=null) 
	    	{
    			Registration registrtaion = (Registration) auth.getPrincipal();
				if(registrtaion.getRole().equals("ROLE_ADMIN")){
					return new ModelAndView("redirect:/admin/view");
				}
				return new ModelAndView("redirect:/app/web");
			  
	    	}
	    	
	    	/*HttpSession session = request.getSession(true);
	    	if(session.getAttribute("user") != null){
	    		return new ModelAndView("redirect:/app/web");
	    	}*/
	    	
	        return new ModelAndView("login");
	    }
	 
	    @RequestMapping(value = "/accessdenied", method = RequestMethod.GET)
	    public String loginerror(ModelMap model) {
	        model.addAttribute("error", "true");
	        return "denied";
	    }
	 
	    @RequestMapping(value = "/logout", method = RequestMethod.GET)
	    public String logout(ModelMap model,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
	        System.out.println("logged out");
	        removeAuthentication(request, response);
		    return "redirect:/login";
	    }
	  
		private static void removeAuthentication(HttpServletRequest request, HttpServletResponse response) {   
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		    if (auth != null) { 
		    	new SecurityContextLogoutHandler().logout(request, response, auth);
		    }
		    
		    HttpSession session = request.getSession();
		    if(session != null) {
		    	session.invalidate();
		    	System.out.println("session is invalidate ===== ");
		    } else {
		    	System.out.println("session is null already ===== ");
		    }
		}

	    @RequestMapping(value = "/general-error", method = RequestMethod.GET)
	    public ModelAndView generalError(HttpServletRequest request) 
	    {
	        return new ModelAndView("general_error");
	    }
	    
	    @RequestMapping(value = "/registration", method = RequestMethod.GET)
	    public ModelAndView registration(@ModelAttribute("command") Registration registration, BindingResult result) 
	    {
	    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    	if (!(auth instanceof AnonymousAuthenticationToken)) 
	    	{
	    	    return new ModelAndView("redirect:/app/web");
	    	}

	    	Map<String ,Object> map = new HashMap<String,Object>();
	    	map.put("registration", registration);
	        return new ModelAndView("registration");
	    }
	    @RequestMapping(value = "/registration", method = RequestMethod.POST)
	    public ModelAndView registrationsubmit(@ModelAttribute("command") Registration registration, BindingResult result, HttpServletRequest request) 
	    {
	    	logger.info(String.format("registration=%s, result = %s, request = %s ", registration, result, request));
	    	Map<String ,Object> map = new HashMap<String,Object>();
	    	
	    	String uniqueID = new GlobalFunctions().uniqueToken();
	    	registration.setEmail_verification_token(uniqueID);
	    	registration.setUser_type(1);
	    	registration.setStatus(0);
	    	registration.setDate(new DateManipulation().getMyDate());
	    	registration.setRole("ROLE_USER");
	    	registrationValidation.validate(registration, result);
	    	registration.setPassword(ApplicationUtils.encryptPassword(registration.getPassword()));
	    	
	    	if (result.hasErrors()) 
	    	{
	    		return new ModelAndView("registration");
	        } 
	    	
	    	
	    	else
				try {
					if(registerService.addRegistration(registration)==1)
					{
						String url = SERVER_URL+"verify?token="+uniqueID+"&email="+registration.getEmail();
						
						String body=	"Thank you for registering with DrySign.<br><br>"
								+"Kindly verify your account by clicking on this link:  <a href='"+url+"'>Verify Account</a></strong></p>";
				String subject = "DrySign: Registration";
				Map<String, String> inlineImages = new HashMap<String, String>();
		        inlineImages.put("image1", EMAIL_BACKIMAGE);
		        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
		        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
		        new SendEmail().SendingEmailWithImages("", registration.getEmail(), subject, body, inlineImages,registration.getFirstName());
				
		        registration.setFirstName(null);
		        registration.setLastname(null);
				registration.setEmail(null);
				registration.setPassword(null);
				
				map.put("msg", "1");
					}
					else if(registerService.addRegistration(registration)==2)
					{
						map.put("msg", "The user is already registered. Please login to the system using the registered credentials.");
					}
					else if(registerService.addRegistration(registration)==3)
					{
						map.put("msg", "Problem in Registration.");
					}
				} catch (DaoException e) {
					logger.error("Error while Registration: "+e);
				}
	    	
	    	return new ModelAndView("registration", map);
	    }
	
	    
	    @RequestMapping(value = "/verify", method = RequestMethod.GET)
	    public ModelAndView verify(@RequestParam("token") String token, @RequestParam("email") String email) 
	    {
	    	String message = null;
	    	int status = 0;
	    	if(token.equals(null)){
	    		message = "Token cant be null.";
	    	}else
	    	{
	    		try {
					status = registerService.verifyRegistration(token,email);
				} catch (DaoException e) {
					logger.error("Error while getting verify registration: "+e);
				}
	    		if(status == 1){
	    			message = "1";
	    		}else if(status == 2){
	    			message = "Invalid Token.";
	    		}
	    	}
	    	
	    	Map<String ,Object> map = new HashMap<String,Object>();
	    	map.put("message", message);
	        return new ModelAndView("verify", map);
	    }

	   
		@RequestMapping(value="/index",method=RequestMethod.GET)
		public ModelAndView index()
		{
			return new ModelAndView("index");
		}   
	    
		@RequestMapping(value = "/termsandconditions", method = RequestMethod.GET)
	    public ModelAndView termsAndConditions(ModelMap model,HttpServletRequest request) 
	    {
	        return new ModelAndView("termsandconditions");
	    }
		
		
		
}
