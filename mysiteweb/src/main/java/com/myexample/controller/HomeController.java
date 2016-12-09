package com.myexample.controller;

import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.apache.pdfbox.exceptions.COSVisitorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.myexample.dao.DaoException;
import com.myexample.model.DocumentField;
import com.myexample.model.JsonResponse;
import com.myexample.model.Registration;
import com.myexample.model.Signature;
import com.myexample.model.VerifyDetails;
import com.myexample.service.ApplicationService;
import com.myexample.service.JerseyService;
import com.myexample.service.RegisterService;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.CommonUtils;
import com.myexample.utility.DateManipulation;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.ImageResizer;
import com.myexample.utility.ImageType;
import com.myexample.utility.SendEmail;
import com.myexample.utility.UtilityException;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private ApplicationService applicationService;
	
	@Autowired
	private  JerseyService jerseyService;
	
	@Autowired
	private RegisterService registerService;

	public static  String SRC;
	public static  String SIGNATURE_PATH;
	public static  String TYPE_PATH;
	public static  String DOC_PATH;
	public static  String APP_ELECTRONIC_DOCS;
	public static  String APP_DIGITAL_DOCS;
	private static String SERVER_URL ;
	private static String DIGITAL_FILE_PATH ;
	private static String path ;
	public static final String RES = null;
	public static final String STATUS = "No data found";
	private static String EMAIL_BACKIMAGE ;
	private static String EMAIL_SOURCEHOV_LOGO ;
	private static String EMAIL_DRYSIGN_LOGO ;
	private final static Logger logger = Logger.getLogger(HomeController.class);

	public HomeController()
	{
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			SRC = globalfunctions.getUploadPath();
			SIGNATURE_PATH = globalfunctions.getSignaturePath();
			TYPE_PATH = globalfunctions.getTypePath();
			DOC_PATH = globalfunctions.getSignPdfPath();
			APP_ELECTRONIC_DOCS = globalfunctions.getAppElectronicSignPdfPath();
			APP_DIGITAL_DOCS = globalfunctions.getAppDigitalSignPdfPath();
			SERVER_URL = new GlobalFunctions().getServerUrl();
			DIGITAL_FILE_PATH = new GlobalFunctions().getDigitalSignatureFilePath();
			path = new GlobalFunctions().getUploadPath();
			EMAIL_BACKIMAGE=new GlobalFunctions().getEmailBackGroundImage();
			EMAIL_SOURCEHOV_LOGO=new GlobalFunctions().getEmailSourceHOVlogo();
			EMAIL_DRYSIGN_LOGO=new GlobalFunctions().getEmailDrySignLogo();
			logger.info(String.format("HomeController(SRC = %s ,SIGNATURE_PATH = %s ,TYPE_PATH = %s ,DOC_PATH = %s )", SRC,SIGNATURE_PATH,TYPE_PATH,DOC_PATH));
		
		} catch (UtilityException e) {
			logger.error(e);
		}
	}

	
	@RequestMapping(value = "/key", method = RequestMethod.GET)
    public ModelAndView registration(@ModelAttribute("command") Registration registration, BindingResult result) 
    {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	/*if (auth !=null) 
    	{
    	    return new ModelAndView("redirect:/web");
    	}*/

    	Map<String ,Object> map = new HashMap<String,Object>();
    	map.put("registration", registration);
        return new ModelAndView("key");
    }
	
	@RequestMapping(value="/formregisterkey", method = RequestMethod.POST)
    public @ResponseBody Map<String ,Object>  submittedFromData(@RequestBody Registration registration, HttpServletRequest request,HttpServletResponse response) {	
		
		Map<String ,Object> map = new HashMap<String,Object>();
    	String uniqueID = new GlobalFunctions().uniqueToken();
    	registration.setEmail_verification_token(uniqueID);
    	registration.setUser_type(2);
    	registration.setStatus(1);
    	registration.setDate(new DateManipulation().getMyDate());
    	registration.setClientSecret(RandomStringUtils.randomAlphabetic(5));
    	registration.setRole("ROLE_APP");
    	
    	registration.setPhone(registration.getPhone().replace("\"", ""));
    	registration.setPincode(registration.getPincode().replace("\"", ""));
    	//System.out.println(registration.getPhone());
    	String password=RandomStringUtils.randomAlphabetic(5);
    	//registrationValidation.validate(registration, result);
    	registration.setPassword(ApplicationUtils.encryptPassword(password));
    	
			try {
				if(registerService.addRegistration(registration)==1)
				{
					String body=	"Your DrySign account has been activated, with the following login details:<br><br>"
									+"Login name: " + registration.getEmail() +"<br>"
									+"Password: " +password + "<br>"
									+"Client Id: restapp<br>"
									+"Secret Id: restapp<br><br>"
									+"Please refer this link : http://www.drysign/key for download API </strong></p>";
					String subject = "DrySign: Your account is now activated";
					Map<String, String> inlineImages = new HashMap<String, String>();
			        inlineImages.put("image1", EMAIL_BACKIMAGE);
			        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
			        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
					//new SendEmail().SendingEmail("", registration.getEmail(), subject, body);
					new SendEmail().SendingEmailWithImages("", registration.getEmail(), subject, body, inlineImages,registration.getFirstName());
					
					registration.setFirstName(null);
					registration.setEmail(null);
					registration.setPassword(null);
					
					map.put("msg", "1");
					
					
				}
				else if(registerService.addRegistration(registration)==2)
				{
					map.put("msg", "This Email is Already exists.");
				
				}
				else if(registerService.addRegistration(registration)==3)
				{
					map.put("msg", "Problem in Registration.");
				
				}
			} catch (DaoException e) {
				logger.error("Error while Registration: "+e);
			}
		
		return map;
	}	
	
	@RequestMapping(value = "registerkey", method = RequestMethod.POST)
    public ModelAndView registerkey(@ModelAttribute("command") Registration registration, BindingResult result,HttpServletRequest request,HttpServletResponse response) 
    {

    	Map<String ,Object> map = new HashMap<String,Object>();
    	
    	String uniqueID = new GlobalFunctions().uniqueToken();
    	registration.setEmail_verification_token(uniqueID);
    	registration.setUser_type(2);
    	registration.setStatus(1);
    	registration.setIsCompany("Yes");
    	registration.setDate(new DateManipulation().getMyDate());
    	registration.setClientSecret(RandomStringUtils.randomAlphabetic(5));
    	registration.setRole("ROLE_APP");
    	
    	registration.setPhone(registration.getPhone().replace("\"", ""));
    	registration.setPincode(registration.getPincode().replace("\"", ""));
    	System.out.println(registration.getPhone());
    	//registrationValidation.validate(registration, result);
    	registration.setPassword(ApplicationUtils.encryptPassword(RandomStringUtils.randomAlphabetic(5)));
    	
			try {
				if(registerService.addRegistration(registration)==1)
				{
					String url = SERVER_URL+"verify?token="+uniqueID+"&email="+registration.getEmail();
					String body = "Dear "+registration.getFirstName()+", \n"
							+ "You have registerd successfully in eSign here is your email: "+ registration.getEmail()+"\n password is: "+registration.getPassword()+""
									+ " and your application key is "+ uniqueID+" \n \n kindly verify you account by clicking on this <a href='"+url+"'>link</a>. \n <br/><br/> Thanks for going paperless.<br/> - eSign Team";
					
					String subject = "Registration Verification: eSign";
					
					try {
						new SendEmail().SendingEmail("", registration.getEmail(), subject, body);
					} catch (UtilityException e) {
						logger.error("Error while sending email to current register user: "+e.getMessage());
					}
					
					registration.setFirstName(null);
					registration.setLastname(null);
					registration.setEmail(null);
					registration.setPassword(null);
					
					map.put("msg", "1");
					
					
				}
				else if(registerService.addRegistration(registration)==2)
				{
					map.put("msg", "This Email is Already exists.");
				
				}
				else if(registerService.addRegistration(registration)==3)
				{
					map.put("msg", "Problem in Registration.");
				
				}
			} catch (DaoException e) {
				logger.error("Error while Registration: "+e);
			}
			return new ModelAndView("key", map);
	    }

	@RequestMapping(value = "/reorder", method = RequestMethod.GET)
	public String reorder() {
		return "reorder";
	}


	
	
	
	
	
	
	
	@RequestMapping(value = "/saveDocumentSign", method = RequestMethod.POST)
	public @ResponseBody void saveDocumentSign(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute(value = "user") User user)
					throws IOException, IOException,COSVisitorException {
		String signatureString = null;

		if (user.getFullName() != null && user.getSignDate() != null && user.getSignature() != null) {
			logger.info("Name: " + user.getFullName());
			logger.info("Sign Date: " + user.getSignDate());
			logger.info("Signature: " + user.getSignature());

			user.setNameLeft(user.getNameLeft().replaceAll("px", ""));
			user.setNameTop(user.getNameTop().replaceAll("px", ""));
			user.setDateLeft(user.getDateLeft().replaceAll("px", ""));
			user.setDateTop(user.getDateTop().replaceAll("px", ""));
			user.setSignLeft(user.getSignLeft().replaceAll("px", ""));
			user.setSignTop(user.getSignTop().replaceAll("px", ""));
			user.setSignPosition(user.getSignPosition().replaceAll("px", ""));
			PDFModifier mod = new PDFModifier();
			signatureString = modifySignatureData(user.getSignature());
			String createdSign = createSignature(signatureString);
			user.setCreatedSign(createdSign);
			mod.appManipulatePdf(SRC + user.getFileName(), APP_ELECTRONIC_DOCS, user);

		} 
		String json = new Gson().toJson("sucess");
		response.setContentType("application/json");
		response.getWriter().write(json);

	}
	
	/*public String createSignature(String mySignature, String fileName) throws IOException {
		String filePath = SIGNATURE_PATH + fileName + "_signature_" + new Date().getTime() + ".png";
		// Converting a Base64 String into Image byte array
		byte[] imageByteArray = CommonUtils.decodeImage1(mySignature);
		// Write a image byte array into file system
		FileOutputStream imageOutFile = new FileOutputStream(filePath);
		imageOutFile.write(imageByteArray);
		// imageInFile.close();
		imageOutFile.close();
		return filePath;
	}*/
	
	
	@RequestMapping(value = "/ajax/saveDocument", method = RequestMethod.POST)
	public @ResponseBody void saveDocument(HttpServletRequest request, HttpServletResponse response,@RequestBody List<DocumentField> documentField) 
	{
		String documentName=documentField.get(0).getDocumentName();
		String status = "error";
		//save document fields
		if(documentField != null){
			
		    int[] updatefields = null;
			try {
				updatefields = jerseyService.saveDocumentFields(documentField);
			} catch (DaoException e) {
				logger.error("Error while save document: "+e);
			}
			
			String signatureString = null;
			VerifyDetails verifyDetails = null;
			try{
				if(updatefields.length > 0){
					List<DocumentField> fields=CommonUtils.replacePixelName(documentField);	
					PDFModifier mod = new PDFModifier();
					for(DocumentField df:fields){
						if(df.getFieldType().equals("image")){
							signatureString = modifySignatureData(df.getFieldValue());
							String createdSign = createSignature(signatureString);
							df.setFieldValue(createdSign);
						}
					}
					
					mod.manipulatePdf(fields);
					verifyDetails = jerseyService.updateDocument(documentName);
					status = "success";
				}
			}catch(Exception e1){
				logger.error("Error while modify pdf or writing values to pdf or updating status of document: "+ e1);
				verifyDetails = null;
				status = "error";
			}
			
			
			if(verifyDetails != null && verifyDetails.getSigner() != null && verifyDetails.getOriginator() != null)
			{
				String url = SERVER_URL+"viewsigneddocument?signingdetailid="+verifyDetails.getId()+"&token="+verifyDetails.getToken()+"&fname="+verifyDetails.getFileName()+"&semail="+verifyDetails.getSigner()+"&oemail="+verifyDetails.getOriginator();
	        	String body = "Dear "+verifyDetails.getOriginator()+ ", \n<br/>"+verifyDetails.getFileName()+ " has been signed by "+verifyDetails.getSigner()+". You can see your document anytime by clicking view on eSign  <a href='"+url+"'>View on eSign</a>. \n<br/><br/> Thanks for going paperless.<br/> - eSign Team ";
	        	
	        	String subject = "Document Signing Complete: eSign";
	        	try {
					new SendEmail().SendingEmail(verifyDetails.getSigner(), verifyDetails.getOriginator(), subject, body);
				} catch (UtilityException e) {
					logger.error("Error while sending email to signer when document signed by signer "+e);
				}
			}
			
		}

		String json = new Gson().toJson(status);
		response.setContentType("application/json");
		try {
			response.getWriter().write(json);
		} catch (IOException e2) {logger.error("Error while write json to response : "+ e2.getMessage());}

	}
	
	@RequestMapping("/viewsigneddocument")
	public void viewsigneddocument(HttpServletRequest request, HttpServletResponse response,@RequestParam("signingdetailid") String signingdetailid,@RequestParam("token") String token,@RequestParam("fname") String fname,@RequestParam("semail") String semail,@RequestParam("oemail") String oemail)
	{
		boolean flag = false;
		if(signingdetailid != null && token != null && fname !=null && semail != null && oemail != null)
		{
			try {
				flag = jerseyService.readValidFileFromOriginator(Integer.parseInt(signingdetailid), token, fname, semail, oemail);
			} catch (NumberFormatException e) {
				flag = false;
				logger.error("Error while converting signingdetailid to int: "+e);
			} catch (DaoException e) {
				flag = false;
				logger.error("Error while readValidFile: "+e);
				
			}
		}else{
			flag = false;
		}
		

		if(flag)
		{
			
			


			File file = null;
			String fileName = fname;
			try{
			file = new File(DIGITAL_FILE_PATH + fileName);
			System.out.println(DIGITAL_FILE_PATH + fileName);
			if (!file.exists()) 
			{
				String errorMessage = "Sorry. The file you are looking for does not exist";
				OutputStream outputStream = response.getOutputStream();
				outputStream.write(errorMessage.getBytes(Charset.forName("UTF-8")));
				outputStream.close();
				return;
			}

			String mimeType = URLConnection.guessContentTypeFromName(file.getName());
			if (mimeType == null) {
				mimeType = "application/octet-stream";
			}

			response.setContentType(mimeType);
			if (true) {
				response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() + "\""));
			} 
			response.setContentLength((int) file.length());
			InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

			FileCopyUtils.copy(inputStream, response.getOutputStream());
			}catch(Exception e){
				logger.error("Error while file read: "+e);
			}
			
		}
		
		

		
	}
	

	/**
	 * Modify signature string data
	 * 
	 * @author Sanket.Navale
	 * @param mySignature
	 * @return
	 */
	public static String modifySignatureData(String mySignature) {
		String removeString = null, modifyString = null, LastString = null;
		removeString = mySignature.substring(22); // remove start string
													// data:image/png;base64,
		modifyString = removeString.substring(0, removeString.length() - 1); // remove
																				// end
																				// String
																				// =
		LastString = modifyString.replace(' ', '+'); // replace space with +
		//logger.info("My Siganture: " + LastString);
		return LastString;
	}

	/***
	 * create signature image using base64 to PNG
	 * 
	 * @author Sanket.Navale
	 * @param mySignature
	 * @throws IOException
	 */
	public String createSignature(String mySignature) throws IOException {
		String filePath = SIGNATURE_PATH +"signature_" + new Date().getTime() + ".png";
		// Converting a Base64 String into Image byte array
		byte[] imageByteArray = CommonUtils.decodeImage1(mySignature);
		// Write a image byte array into file system
		FileOutputStream imageOutFile = new FileOutputStream(filePath);
		imageOutFile.write(imageByteArray);
		// imageInFile.close();
		imageOutFile.close();
        try {
        BufferedImage image = ImageIO.read(new File(
                            filePath));
               ImageIO.write(ImageResizer.resizeTrick(image, 209, 40), "png",
                            new File(filePath));
        } catch (IOException e) {
               e.printStackTrace();
        }

		return filePath;
	}

	/**
	 * redirect to show list of PDF Files
	 * 
	 * @author Sanket.Navale
	 * @return
	 */
	@RequestMapping(value = "/showFiles", method = RequestMethod.GET)
	public ModelAndView showFiles() {

		File folder = new File(APP_DIGITAL_DOCS);
		File[] listOfFiles = folder.listFiles();
		List<String> fileNameList = new ArrayList<String>();
		for (int i = 0; i < listOfFiles.length; i++) {
			if (listOfFiles[i].isFile()) {
				System.out.println("File " + listOfFiles[i].getName());
				fileNameList.add(listOfFiles[i].getName());
			} else if (listOfFiles[i].isDirectory()) {
				System.out.println("Directory " + listOfFiles[i].getName());
				fileNameList.add(listOfFiles[i].getName());
			}
		}
		ModelAndView model = new ModelAndView("showFiles");
		model.addObject("lists", fileNameList);
		return model;

	}

	@RequestMapping(value = "/check/{type}", method = RequestMethod.GET)
	public @ResponseBody void check(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type) throws IOException {
		String fileName = request.getParameter("fileName");

		//String json = new Gson().toJson(new RSASecurityPack().decryption(fileName));
		String json = new Gson().toJson(fileName);
		response.setContentType("application/json");
		response.getWriter().write(json);

	}



	@RequestMapping(value = "/ajax/createTypeFonts", method = RequestMethod.GET)
	public @ResponseBody void createTypeFonts(@RequestParam(value = "imgType") String imgType,HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		// List of Base64 String

		if (imgType != null && imgType != "") {
			List<String> typeFontList = createType(imgType, "mytype");
			String json = new Gson().toJson(typeFontList);
			response.setContentType("application/json");
			response.getWriter().write(json);
		} else {
			String json = new Gson().toJson(STATUS);
			response.setContentType("application/json");
			response.getWriter().write(json);
		}

	}

	/***
	 * @author Sanket.Navale This API is used to create different font style
	 *         List
	 * @param myType
	 * @param fileName
	 * @return
	 * @throws IOException
	 */
	public static List<String> createType(String myType, String fileName) throws IOException {

		List<String> type = new ArrayList<String>();

		CommonUtils c = new CommonUtils();
		for (ImageType im : c.getPropValues()) {

			BufferedImage image = new CommonUtils().convertTextToGraphic(myType, new Font(im.getFont(), Font.PLAIN, 32));
			String prefix = "file";
			String suffix = ".png";
			File directory = new File(TYPE_PATH);
			File tempFile3 = null;
			tempFile3 = File.createTempFile(prefix, suffix, directory);
			ImageIO.write(image, "png", tempFile3);
			File file = new File(directory + "/" + tempFile3.getName());
			FileInputStream imageInFile = new FileInputStream(file);
			byte imageData[] = new byte[(int) file.length()];
			imageInFile.read(imageData);

			// Converting Image byte array into Base64 String
			String imageDataString = CommonUtils.encodeImage(imageData);
			String LastString = imageDataString.replace('_', '/');
			String myString = LastString.replace('-', '+');
			String imgSrc = "data:image/png;base64," + myString;
			type.add(imgSrc);
			imageInFile.close();
			if (file.delete()) {
				//System.out.println("File is deleted");
			} else {
				System.out.println("File not found!");
			}
		}

		return type;
	}

	
	@RequestMapping(value = "/ajax/getFieldData", method = RequestMethod.GET)
	public void getFieldData(@RequestParam(value = "documentName") String documentName,HttpServletResponse response) 
	{
		logger.info(String.format("getFieldData(documentName = %s)", documentName));
		
		response.setContentType("application/json");
		List<DocumentField> f = null;
		try {
			f = jerseyService.getFieldData(documentName);
		} catch (DaoException e) 
		{
			logger.error("Error while getFieldData: "+e);
		}
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			logger.error("Error while gettting getWriter: "+e.getMessage());
		}
	
		Gson gson = new Gson();
		out.print(gson.toJson(f));
		out.flush();
		
	}
	
	@RequestMapping(value = "/ajax/checkUserIsExist", method = RequestMethod.GET)
	public void checkUserIsExist(@RequestParam(value = "emailId") String emailId,HttpServletResponse response) 
	{
		logger.info(String.format("checkUserIsExist(checkUserIsExist = %s)", emailId));
		response.setContentType("application/json");
		boolean checkUser = false;
		try {
			checkUser = jerseyService.checkUserIsExist(emailId);
		} catch (DaoException e) 
		{
			logger.error("Error while getFieldData: "+e);
		}
		PrintWriter out = null;
		
		try {
			out = response.getWriter();
		} catch (IOException e) {
			logger.error("Error while gettting getWriter: "+e.getMessage());
		}
	
		Gson gson = new Gson();
		out.print(gson.toJson(checkUser));
		out.flush();
		
	}

		
	/***
	 * @author Sanket.Navale
	 * Quick register with third party application.
	 * @param registration
	 * @param result
	 * @return
	 * @throws DaoException
	 */
	@RequestMapping(value = "/ajax/quickRegister", method = RequestMethod.POST)
	public @ResponseBody JsonResponse quickRegister(@ModelAttribute(value = "registration") Registration registration,
			BindingResult result) throws DaoException {
		JsonResponse res = new JsonResponse();
		ValidationUtils.rejectIfEmpty(result, "email", "Email can not be empty.");
		ValidationUtils.rejectIfEmpty(result, "password", "Please enter your password");
		String uniqueID = new GlobalFunctions().uniqueToken();
	   	registration.setEmail_verification_token(uniqueID);
		registration.setUser_type(1);
		registration.setStatus(0);
		registration.setRole("ROLE_USER");
		
		//String password=registration.getPassword();
		registration.setDate(new DateManipulation().getMyDate());
		registration.setPassword(ApplicationUtils.encryptPassword(registration.getPassword()));
		if (!result.hasErrors()) {
			if (registerService.addRegistration(registration) == 1) {
				String url = SERVER_URL+"verify?token="+uniqueID+"&email="+registration.getEmail();
				String body=	"Thank you for registering with DrySign.<br><br>"
						+"Kindly verify your account by clicking on this link:  <a href='"+url+"'>Verify Account</a></strong></p>";
				String subject = "DrySign: Registration";
				
				Map<String, String> inlineImages = new HashMap<String, String>();
				inlineImages.put("image1", EMAIL_BACKIMAGE);
				inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
				inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
				new SendEmail().SendingEmailWithImages("", registration.getEmail(), subject, body, inlineImages,
						registration.getFirstName());
				res.setStatus("SUCCESS");
				//res.setResult("Thank you for registering with DrySign.Email has sent successfully !!.");
			} else if (registerService.addRegistration(registration) == 2) {
				res.setStatus("EXIST");
				res.setResult("User is already exist in system.");
			} else if (registerService.addRegistration(registration) == 3) {
				res.setStatus("PROBLEM");
				res.setResult("Problem in Registration.");
			}
		} else {
			res.setStatus("FAIL");
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	/***
	 * @author Sanket.Navale
	 * Quick sign with third party application.
	 * @param registration
	 * @param result
	 * @return
	 * @throws DaoException
	 */
	@RequestMapping(value = "/ajax/quickSign", method = RequestMethod.POST)
	public @ResponseBody JsonResponse quickSign(@ModelAttribute(value = "registration") Registration registration,
			BindingResult result) throws DaoException {
		JsonResponse res = new JsonResponse();
		BCryptPasswordEncoder enc =new BCryptPasswordEncoder();
		ValidationUtils.rejectIfEmpty(result, "email", "Email can not be empty.");
		ValidationUtils.rejectIfEmpty(result, "password", "Please enter your password");
		if (!result.hasErrors()) {
				Registration reg=jerseyService.getPassword(registration.getEmail());
				String currPassword=registration.getPassword();
				if(!enc.matches(currPassword,reg.getPassword())){
					res.setStatus("FAIL");
					res.setResult("You have enter wrong password.");
				}else if (reg.getStatus() == 0){
					res.setStatus("FAIL");
					res.setResult("Your Account is Inactive Please verify from email. ");
				}else{
					List<Signature> signatureList = applicationService.getUserSignatures(reg.getId());
					res.setStatus("SUCCESS");
					res.setResult(signatureList);
				}
			} else {
			res.setStatus("FAIL");
			res.setResult(result.getAllErrors());
		}
		return res;
	}
}