package com.scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.myexample.controller.ApplicationController;
import com.myexample.dao.DaoException;
import com.myexample.model.User;
import com.myexample.service.ApplicationService;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.SendEmail;
import com.myexample.utility.UtilityException;

@Controller
public class EmailScheduler extends SpringBeanAutowiringSupport{
	
	
	@Autowired
	private ApplicationService applicationService;
	
	
	
	
private static final Logger logger = Logger.getLogger(ApplicationController.class);
	
	private static String SERVER_URL ;
	private static String PROFILE_PIC;
	private static String EMAIL_BACKIMAGE ;
	private static String EMAIL_SOURCEHOV_LOGO ;
	private static String EMAIL_DRYSIGN_LOGO ;
	
	String className = this.getClass().getSimpleName();
	public EmailScheduler() 
	{
		try {
			SERVER_URL = new GlobalFunctions().getServerUrl();
			PROFILE_PIC = new GlobalFunctions().getProfilePicPath();
			EMAIL_BACKIMAGE=new GlobalFunctions().getEmailBackGroundImage();
			EMAIL_SOURCEHOV_LOGO=new GlobalFunctions().getEmailSourceHOVlogo();
			EMAIL_DRYSIGN_LOGO=new GlobalFunctions().getEmailDrySignLogo();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//  0/50 * * * * *    0 0 10 1/1 * ?
	@Scheduled(cron = " 0 0 10 1/1 * ?")
	public void demoServiceMethod() {

		/*EmailScheduler e = new EmailScheduler();
		e.getUnRegUsers();*/
	
	}

	public static void main(String[] args) 
	{
		
		/*EmailScheduler e = new EmailScheduler();
		e.getUnRegUsers();
		*/
		
	}
	
	
	public void getUnRegUsers()
	{
		String subject = "DrySign: Promotional email.";
		String url = SERVER_URL+"registration";
		String body = " &nbsp &nbsp You recently signed a document using DrySign. We hope you enjoyed your experience. <br/> "
				+ "How would you like to continue enjoying the convenience offered by DrySign? <br/>"
				+ "DrySign allows you to: <br/><br/>"
				+ "<ul>"
				+ "<li>Sign documents digitally: sign from anywhere, any time; all you need is an internet connection and your mobile phone or a desktop</li>"
				+ "<li>Send documents to multiple people for their signatures</li>"
				+ "<li>Track the status of documents that need multiple signatures</li>"
				+ "<li>View signature history</li>"
				+ "</ul>"
				+ "<br/>"
				+ "Registration is easy, click on the following link: <a href='"+url+"'>Register</a>"
				+ "<br><br>"
				+ "We look forward to you joining our growing pool of satisfied customers! <br/>";
		
		Map<String, String> inlineImages = new HashMap<String, String>();
        inlineImages.put("image1", EMAIL_BACKIMAGE);
        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
		
		
		try {
			List<User> users = applicationService.getUnRegisteredUsers();
			for(User user: users){
				new SendEmail().SendingEmailWithImages("", user.getEmail(), subject, body, inlineImages, user.getName());
			}
			//new SendEmail().SendingEmailWithImages("", "matadeen.sikarawar@banctec.in", subject, body, inlineImages, "Aman");
			
		} catch (Exception e) {
			logger.error("Error while sending promotional email to signers : "+e);
		}
	}
}
