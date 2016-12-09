package com.myexample.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.exceptions.SignatureException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDJpeg;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDPixelMap;
import org.apache.pdfbox.pdmodel.graphics.xobject.PDXObjectImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.google.gson.Gson;
import com.myexample.dao.DaoException;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.DocumentCount;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentSign;
import com.myexample.model.DocumentSignField;
import com.myexample.model.Registration;
import com.myexample.model.ResetPassword;
import com.myexample.model.RestDocument;
import com.myexample.model.Signature;
import com.myexample.model.VerifyDetails;
import com.myexample.service.ApplicationService;
import com.myexample.service.JerseyService;
import com.myexample.service.RegisterService;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.CommonUtils;
import com.myexample.utility.FileUtils;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.SendEmail;
import com.myexample.utility.UtilityException;
import com.myexample.validation.ResetPasswordValidator;
import com.myexample.validation.UpdateProfileValidation;

@Controller
@RequestMapping("/app")
public class ApplicationController {

	@Autowired
	private ApplicationService applicationService;
	@Autowired
	private RegisterService registerService;
	@Autowired
	private ResetPasswordValidator resetPasswordValidator;
	@Autowired
	private UpdateProfileValidation updateProfileValidation;
	@Autowired
	private  JerseyService jerseyService;
	private static final Logger logger = Logger.getLogger(ApplicationController.class);
	
	private static String SERVER_URL ;
	private static String TEMP_ELECTRONIC_URL;
	private static String TEMP_DIGITAL_URL;
	private static String PROFILE_PIC;
	private static String EMAIL_BACKIMAGE ;
	private static String EMAIL_SOURCEHOV_LOGO ;
	private static String EMAIL_DRYSIGN_LOGO ;
	
	String className = this.getClass().getSimpleName();
	public ApplicationController() 
	{
		try {
			SERVER_URL = new GlobalFunctions().getServerUrl();
			TEMP_ELECTRONIC_URL = new GlobalFunctions().getTempAppElectronicSignPdfPath();
			TEMP_DIGITAL_URL = new GlobalFunctions().getTempAppDigitalSignPdfPath();
			PROFILE_PIC = new GlobalFunctions().getProfilePicPath();
			EMAIL_BACKIMAGE=new GlobalFunctions().getEmailBackGroundImage();
			EMAIL_SOURCEHOV_LOGO=new GlobalFunctions().getEmailSourceHOVlogo();
			EMAIL_DRYSIGN_LOGO=new GlobalFunctions().getEmailDrySignLogo();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	}
	
	
	@RequestMapping(value = "/document")
	public ModelAndView document(HttpServletRequest request) 
	{
		return new ModelAndView("document");
	}	
	
	@RequestMapping(value = "/testpage")
	public ModelAndView test(HttpServletRequest request) 
	{
		return new ModelAndView("testpage");
	}
	
	@RequestMapping(value = "/draft")
	public ModelAndView draft(HttpServletRequest request) 
	{
		return new ModelAndView("draft");
	}
	
	@RequestMapping(value = "/groupsign")
	public ModelAndView groupsign(HttpServletRequest request) 
	{
		
		Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Signature> signatureList = applicationService.getUserSignatures(user.getId());
		

		Map<String, List<Signature>> model = new HashMap<String, List<Signature>>();
		model.put("signatures", signatureList);
		return new ModelAndView("groupsign", model);
	}	
	

	
	@RequestMapping(value = "/groupsignrender")
	public ModelAndView groupSignRender(@RequestParam("fileid") String fileId, @RequestParam("fname") String fname,RedirectAttributes attr, HttpServletRequest request) 
	{
		String classMethod = className+ ":  groupSignRender" ;
		logger.info(String.format("Enter into "+classMethod+"(fileid = %s, fname = %s)", fileId, fname));
		File f = null;
		try {
			ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileId),fname);
			
			f = ApplicationUtils.stream2file(doc.getOriginal());
			if (f.exists()) {
				/*@SuppressWarnings("resource")
				RandomAccessFile raf = new RandomAccessFile(f, "r");
				FileChannel channel = raf.getChannel();
				ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
				PDFFile pdf = new PDFFile(buf);*/
				
				int count = ApplicationUtils.getPageCount(f);


				Map<String, String> model = new HashMap<String, String>();
				model.put("numpages", "" + count);
				model.put("filename", fname);
				model.put("fileid",fileId);
				
				logger.info("exit from "+classMethod);
				
				return new ModelAndView("groupsignrender", model);
				
			} else {
				attr.addFlashAttribute("fileMsg", "File Not Found.");
				logger.info("exit from "+classMethod);
				return new ModelAndView("redirect:/pdf");
			}
		} catch (Exception e) {
			attr.addFlashAttribute("fileMsg", e.getMessage());
			return new ModelAndView("redirect:/pdf");
		}finally{
			if(f!=null){f.deleteOnExit();}
		}
	}

	
	
	
	 @SuppressWarnings("resource")
	@RequestMapping(value = "/ajaxupload", method = RequestMethod.POST)
	 public @ResponseBody String ajaxupload(MultipartHttpServletRequest request,HttpServletResponse response) throws Exception 
	 {
			String classMethod = className+ ":  ajaxupload" ;
			logger.info(String.format("Enter into "+classMethod+"(request = %s, response = %s)", request, response));

		    String fileId = null;
		    String fileName = null;
		    String status = null;
		    String message = "";
		    String envelopeId ="";
			try{
				String ipAddress = request.getHeader("X-FORWARDED-FOR");
				if (ipAddress == null) {
					   ipAddress = request.getRemoteAddr();
				}

				String loginuserid = request.getParameter("loginuserid");
				String signtype = request.getParameter("signtype");
		        MultipartFile multipartFile = request.getFile("file");
		        if(multipartFile !=null)
		        {
		        	byte [] byteArr=multipartFile.getBytes();
			        InputStream inputStream = new ByteArrayInputStream(byteArr);
			      
			        fileName = multipartFile.getOriginalFilename();
			        fileName = fileName.replaceAll("[-+^:,]","");
			        
			        inputStream = new FileUtils().WriteFile(inputStream,fileName);
			        
			        String extension = "";
					int i = fileName.lastIndexOf('.');
					if (i >= 0) {
						extension = fileName.substring(i + 1);
					}
					if(loginuserid != null && !loginuserid.isEmpty()){
						if (extension.equals("pdf")) {
							//fileName = new GlobalFunctions().uniqueToken()+fileName;
							envelopeId = new GlobalFunctions().uniqueToken();
							fileId = applicationService.createDocument(Integer.parseInt(loginuserid),envelopeId,fileName,inputStream,0,"A",signtype,ipAddress).toString();
							status = "S";
							message = "Selected file uploaded successfully.";
						} else if(extension.equals("PDF")){
							status = "E";
							message = "Upper case PDF extention not accepted.";
						}else {
							status = "E";
							message = "Only pdf files accepted.";
						}
					}else{
						status = "E";
						message = "Your Login id is Invalid.";

					}
		        }else{
		        	status = "E";
					message = "Please select pdf file.";
		        }
		        
				
			}catch(Exception e){
				message = e.getMessage();
			}
			Gson gson = new Gson(); 
			
			Map<String,String> model = new HashMap<String, String>();
			model.put("status", status);
			model.put("fileName", fileName);
			model.put("fileId", fileId);
			model.put("message", message);
			model.put("envelopeId", envelopeId);
			String json = gson.toJson(model); 

			logger.info("exit from "+classMethod);
	        return json;
	    }
	 
	 
	 @RequestMapping(value = "/deleteajaxuploadeddocument", method = RequestMethod.POST)
	 public @ResponseBody int deleteajaxuploadeddocument(HttpServletRequest request,HttpServletResponse response) throws Exception 
	 {
		 
		String classMethod = className+ ":  deleteajaxuploadeddocument" ;
		logger.info(String.format("Enter into "+classMethod+"(request = %s, response = %s)", request, response));

		 int id = Integer.parseInt(request.getParameter("fileId"));
		 
		 int delete = applicationService.deleteDocument(id);

		 
		/*HttpSession session = request.getSession(true);
	    if(session.getAttribute("user") != null){
	    	System.out.println("user: "+session.getAttribute("user"));
	    }*/
		 logger.info("exit from "+classMethod);
		 return delete;
	 }
	 
	 
	 
/*	 @RequestMapping(value="/loginSuccess", method={RequestMethod.GET, RequestMethod.POST})
     public String loginSuccess(HttpSession session) {
             logger.info("Login Success starts....... ");
             String redirectURL = "";
             
             Authentication auth = SecurityContextHolder.getContext().getAuthentication();
             try {
                    if (auth != null) {
                          String userName = String.valueOf(auth.getPrincipal()).trim();
                          
                          Registration register = (Registration) auth.getPrincipal();

                          session.setAttribute("user", register);
                          if(register == null) {
                        	  redirectURL = "/login";
                          }else{
                        	  redirectURL = "/dashboard";
                          }
                 }
                                        
                 logger.info("Login Success ends....... ");
                    
                 return "redirect:"+redirectURL;
                    
             }catch(Exception e){
                    logger.error(" Exception in loginSuccess...",e);
                    return "/accessdenied";
             }      
      }*/
	 
	 
	 @RequestMapping(value="/groupsignsend", method=RequestMethod.POST)
	 public @ResponseBody String groupSignSend(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws JsonParseException, JsonMappingException, IOException
	 {

		String classMethod = className+ ":  groupSignSend" ;
		logger.info(String.format("Enter into "+classMethod+"(request = %s, response = %s, session = %s)", request, response, session));

		String msg = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth == null){
			msg = "Please login.";
		}else{
		Registration user = (Registration)auth.getPrincipal();
		 
		 String redirectUrl = "";
		 String envelopeId = request.getParameter("envelopeid");
		 String signatureid = request.getParameter("signatureid");
		 /*if(user != null && user.getId() == Integer.parseInt(request.getParameter("groupfileid")))
		 {*/
			
			 DocumentSign groupSign = prepareGroupSignModel(request);
			 msg = applicationService.createGroupSign(groupSign,signatureid);
			 if(msg == "success")
			 {
				msg = "Successfully sent the document for signing to the intended signees in the order of priority...";
			 	List<DocumentSignField> signerPriority = groupSign.getDocumentSignField();
			    Integer minPriority = Integer.MAX_VALUE;
			    String email = null;
			    String name = null;
			    List<DocumentField> selfSignDocumentField = new ArrayList<DocumentField>();
			    int count = 0;
			    for (int i = 0; i < signerPriority.size(); i++) 
			    {
			        int priority = Integer.parseInt(signerPriority.get(i).getPriority());
			        
			        if(priority == 0)
			        {
			        	DocumentField df = new DocumentField();
			        	df.setLeft(signerPriority.get(i).getLeft().replaceAll("px", ""));
			        	df.setTop(signerPriority.get(i).getTop().replaceAll("px", ""));
			        	df.setFieldValue(signerPriority.get(i).getFieldValue());
			        	if(signerPriority.get(i).getFieldtype().equals("image"))
						{
							String signatureString = new HomeController().modifySignatureData(signerPriority.get(i).getFieldValue());
							String createdSign = new HomeController().createSignature(signatureString);
							df.setFieldValue(createdSign);
						}
			        	df.setFieldName(signerPriority.get(i).getFieldName());
			        	df.setFieldType(signerPriority.get(i).getFieldtype());
			        	df.setPageNumber(Integer.parseInt(signerPriority.get(i).getPageNumber()));

			        	selfSignDocumentField.add(df);
			        }
			        
			        
			        if (priority == 1 && count == 0) 
			        {
			        	minPriority = priority;
			            email		= signerPriority.get(i).getSignerEmail();
			            name 		= signerPriority.get(i).getSignerName();
			            count++;
			        }
			    }
			    
			    //for electronic signature of self sign
			    if(!selfSignDocumentField.isEmpty()){
			    	File file = null;
			    	InputStream is = null;
			    	try {
						ApplicationDocument document = applicationService.readDocument(groupSign.getDocumentId(), groupSign.getDocumentName());
						//System.out.println("self sign: "+selfSignDocumentField);

						file = ApplicationUtils.stream2file(document.getOriginal());
						
						is = manipulatePdf(selfSignDocumentField,file);
						applicationService.saveModifiedDocument(Integer.toString(groupSign.getDocumentId()), is, false);
						
					} catch (DaoException de) {
						logger.error("Error while reading document for self sign: "+de);
					}catch(Exception e){
						logger.error("Error while writing values on document for self sign: "+e);
					}finally{
						if(is!=null){is.close();}
						if(file!=null){file.delete();}
					}
			    	
			    }
			    
			    String token = applicationService.getTokenOfDocumentSignEmail(groupSign.getDocumentId(),email);
			    String subject = "DrySign: "+ groupSign.getTitle();
			    String userUrl = "&projectname="+user.getProject()+"&theme="+user.getTheme()+"&linktodrysign="+user.getLinktodrysign()+"&deviceversion="+user.getDeviceVersion();
			    String url = SERVER_URL+"app/applicationsigndocument?token="+token+"&envelopeid="+envelopeId+"&email="+email+"&signername="+name+userUrl+"&redirecturl="+redirectUrl;
				
			    Map<String, String> inlineImages = new HashMap<String, String>();
		        inlineImages.put("image1", EMAIL_BACKIMAGE);
		        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
		        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
			    
			    String body = "You have been requested by <b>"+user.getFirstName()+"</b> to sign a document in DrySign. "
						+ "<br/> <b>"+user.getFirstName()+"</b> has sent you the following message: "+groupSign.getMessage()+""
						+ " <br/> <br/> Kindly sign the document by clicking on this link:  <a href='"+url+"'>Sign Document</a>";
				
			    
				try {
					//new SendEmail().SendingEmail(user.getEmail(), email, subject, body);
					new SendEmail().SendingEmailWithImages(user.getEmail(), email, subject, body, inlineImages, name);
					logger.info(body);
				} catch (Exception e) {
					logger.error("Error while sending email to current register user: "+e.getMessage());
				}
						    
			 }
			 
		 /*}else{
			 msg = "Invalid login id please login again.";
		 }*/
		}
	    logger.info("exit from "+classMethod);
		return msg;	 
	 }




	@SuppressWarnings("unchecked")
	private DocumentSign prepareGroupSignModel(HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException 
	{
		String classMethod = className+ ":  prepareGroupSignModel" ;
		logger.info(String.format("Enter into "+classMethod+"(request = %s)", request));

		ObjectMapper mapper = new ObjectMapper();
		
		DocumentSign groupSign = new DocumentSign();
		
		groupSign.setDocumentId(Integer.parseInt(request.getParameter("groupfileid")));
		groupSign.setDocumentName(request.getParameter("groupfilename"));
		groupSign.setOriginatorId(Integer.parseInt(request.getParameter("grouploginuserid")));
		groupSign.setTitle(request.getParameter("title"));
		groupSign.setMessage(request.getParameter("groupsignmessage"));
		groupSign.setStatus("0");
		
		String jsonData = request.getParameter("signerjsondata");
		groupSign.setDocumentSignField((List<DocumentSignField>) mapper.readValue(jsonData,TypeFactory.defaultInstance().constructCollectionType(List.class,  DocumentSignField.class)));
		
		/*List<DocumentSignField> signerPriority = mapper.readValue(jsonData,TypeFactory.defaultInstance().constructCollectionType(List.class,  DocumentSignField.class));
		for(DocumentSignField s: signerPriority){
			System.out.println(s.getPriority());
			System.out.println(s.getSignerEmail());
		}*/
		
		logger.info("exit from "+classMethod);
		return groupSign;
	}
	 
	@RequestMapping(value = "/applicationsigndocument")
	public ModelAndView applicationsigndocument(@RequestParam("envelopeid") String envelopeid, @RequestParam("token") String token,@RequestParam("email") String email,RedirectAttributes attr, HttpServletRequest request) 
	{
		String classMethod = className+ ":  applicationsigndocument" ;
		logger.info(String.format("Enter into "+classMethod+"(envelopeid= %s, token= %s, email= %s)",envelopeid,token,email));
		
		Map<String, String> model = new HashMap<String, String>();
		File f = null;
		try {
			RestDocument restDocument = getDocumentByEnvelopeId(envelopeid);
			if(restDocument != null)
			{
				String fileid = ""+restDocument.getId();
				String fname = restDocument.getDocumentName();
				boolean flag = applicationService.checkValidFile(fileid, fname,token,email);
				if(flag)
				{
					ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileid),fname);
					
					if(doc.getElectronic() == null){
						 f = ApplicationUtils.stream2file(doc.getOriginal());
					}else{
						 f = ApplicationUtils.stream2file(doc.getElectronic());
					}
					
					//File f = new File(path + fname);
					if (f.exists()) {
						/*@SuppressWarnings("resource")
						RandomAccessFile raf = new RandomAccessFile(f, "r");
						FileChannel channel = raf.getChannel();
						ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
						PDFFile pdf = new PDFFile(buf);*/
						int count = ApplicationUtils.getPageCount(f);
						model.put("numpages", "" + count);
						model.put("filename", fname);
						model.put("fileid", fileid);
						model.put("redirecturl", request.getParameter("redirecturl"));
						model.put("envelopeid", envelopeid);
						model.put("email", email);
						model.put("token", token);

						logger.info("exit from "+classMethod);
						return new ModelAndView("readfilegroupsign", model);

					} else {
						model.put("fileMsg", "File Not Found.");
						return new ModelAndView("readfilegroupsign", model);
					}
				}else{
					model.put("fileMsg", "Invalid input details.");
					return new ModelAndView("readfilegroupsign", model);
				}
			}else{
				model.put("fileMsg", "Invalid Envelope Id.");
				return new ModelAndView("readfilegroupsign", model);
			}
			
			
			
			
		} catch (Exception e) {
			model.put("fileMsg", e.getMessage());
			return new ModelAndView("readfilegroupsign", model);
		}finally{
			if(f!=null){f.delete();}
		}
	}

	@RequestMapping(value = "/ajax/getApplicationFieldData", method = RequestMethod.GET)
	public void getApplicationFieldData(@RequestParam("fname") String fname,@RequestParam("fileid") String fileid,@RequestParam("email") String signeremail,HttpServletResponse response) 
	{
		String classMethod = className+ ":  getApplicationFieldData";
		logger.info(String.format("Enter into "+classMethod+"(fname = %s, fileid= %s, signeremail = %s, response = %s)", fname,fileid,signeremail,response));
		
		response.setContentType("application/json");
		List<DocumentField> f = null;
		try {
			f = applicationService.getApplicationFieldData(fname, fileid, signeremail);
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
		
		logger.info("exit from "+classMethod);
		out.flush();
		
	}	 


	/*@RequestMapping(value = "/ajax/apppSaveDocument", method = RequestMethod.POST)
	public @ResponseBody void apppSaveDocument(HttpServletRequest request, HttpServletResponse response) 
	{
		ObjectMapper mapper = new ObjectMapper();
		List<DocumentField> list = null;
		try {
			list = mapper.readValue(request.getParameter("data"),TypeFactory.defaultInstance().constructCollectionType(List.class,  DocumentField.class));
		} catch (IOException e) {
			logger.error("Error while converting json data to object: "+e);
		}
		
	}*/
	
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/ajax/appSaveDocument", method = RequestMethod.POST)
	public @ResponseBody void saveDocument(HttpServletRequest request, HttpServletResponse response,@RequestBody List<DocumentField> documentField) 
	{
		String classMethod = className+ ":  saveDocument";
		logger.info(String.format("Enter into "+classMethod+"(request = %s, response= %s, documentField = %s)", request,response,documentField));

		String status = "error";
		String signerEmail = request.getParameter("signeremail");

		String token = request.getParameter("token");
		String envelopeId = request.getParameter("envelopeid");
		
		String redirectUrl = request.getParameter("redirecturl");
		String isLoginParameter = request.getParameter("islogin");
		boolean isLogin=Boolean.parseBoolean(isLoginParameter);

		boolean digital = false;
		File file = null;
		
		
		
		//save document fields
		if(documentField != null && envelopeId != null){
			
			RestDocument restDocument = getDocumentByEnvelopeId(envelopeId);
			if(restDocument != null )
			{
				String fname = restDocument.getDocumentName();
				String fileId = ""+restDocument.getId();
			
				Map<String, Object> appDetails = null;
				try {
					appDetails = applicationService.saveAppDocumentFields(documentField,signerEmail,fileId,token,fname);
					
					if(appDetails.get("priority") != null && Integer.parseInt(appDetails.get("priority").toString()) >0)
					{
						
						// start modified document to electronic and digital
						Registration nextSigner = (Registration) appDetails.get("nextSigner");
						String signatureString = null;
						VerifyDetails verifyDetails = null;
						try{
							
							List<DocumentField> fields=CommonUtils.replacePixelName(documentField);	
							for(DocumentField df:fields)
							{
								if(df.getFieldType().equals("image"))
								{
									if(isLogin==true){
										Registration registration = registerService.loginCall(signerEmail);
										//int saveSign=applicationService.saveSignature(registration.getId(),df.getFieldValue());
										logger.info("save signature succesfully");
									}
									signatureString = new HomeController().modifySignatureData(df.getFieldValue());
									String createdSign = new HomeController().createSignature(signatureString);
									df.setFieldValue(createdSign);
									
								}
							}
							
							if(nextSigner ==null){
								digital = true;
							}
							ApplicationDocument document = (ApplicationDocument) appDetails.get("document");
							if(document != null && document.getElectronic() !=null)
							{
								file = ApplicationUtils.stream2file(document.getElectronic());
							}else if(document != null && document.getElectronic() ==null){
								file = ApplicationUtils.stream2file(document.getOriginal());
							}
							InputStream modifiedFile = manipulatePdf(fields,file);
							
							int esuccess = applicationService.saveModifiedDocument(fileId,modifiedFile,false);
							modifiedFile.close();
							if(digital){
								File digitaltemp = new File(TEMP_DIGITAL_URL+fname);
								new ApplicationUtils().createDigitalSignature(file,digitaltemp,envelopeId);
								InputStream dis = new FileInputStream(digitaltemp);
								int dsuccess = applicationService.saveModifiedDocument(fileId,dis,true);
								dis.close();
								digitaltemp.delete();
							}
							//save signature
							
							 Map<String, String> inlineImages = new HashMap<String, String>();
						        inlineImages.put("image1", EMAIL_BACKIMAGE);
						        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
						        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
							//start send mail to originator
							Registration originator = (Registration) appDetails.get("originator");
							Registration signer = (Registration) appDetails.get("signer");
							String originatorMailSubject = "DrySign: Document Sign";
							String originatorMailBody = " Your document <b>"+ fname +"</b> has been signed by <b>"+signer.getFirstName()+"</b>. You may view the status of your document at any time by logging in to DrySign.";
							try {
								 new SendEmail().SendingEmailWithImages(signer.getEmail(), originator.getEmail(), originatorMailSubject, originatorMailBody, inlineImages, originator.getFirstName());
								//new SendEmail().SendingEmail(signer.getEmail(), originator.getEmail(), originatorMailSubject, originatorMailBody);
							} catch (Exception e) {
								logger.error("Error while sending email to originator:"+originator.getEmail()+" when document signed by signer: "+signer.getEmail()+" "+e);
							}
							//end send mail to originator
							
							
							//send email to next signer if available
							
							if(nextSigner != null)
							{
								DocumentSign documentSign = (DocumentSign) appDetails.get("documentSign");
								String nextSigntoken = applicationService.getTokenOfDocumentSignEmail(Integer.parseInt(fileId),nextSigner.getEmail());
							    
								String updateMailCount = applicationService.increaseReminderEmailCount(1,Integer.parseInt(fileId),nextSigner.getEmail());
								if(updateMailCount.equals("1")){
									
								}
								String nextSignsubject = "DrySign: "+documentSign.getTitle();
								Authentication auth = SecurityContextHolder.getContext().getAuthentication();
								Registration user = (Registration)auth.getPrincipal();
								String userUrl = "&projectname="+user.getProject()+"&theme="+user.getTheme()+"&linktodrysign="+user.getLinktodrysign()+"&deviceversion="+user.getDeviceVersion();
								String signerName = nextSigner.getFirstName();
								String url = SERVER_URL+"app/applicationsigndocument?token="+nextSigntoken+"&envelopeid="+envelopeId+"&email="+nextSigner.getEmail()+"&signername="+signerName+userUrl+"&redirecturl="+redirectUrl;
								/*String body = "You have requested for signing the document in DrySign. "
										+ "<br/> Message from requester- "+originator.getFirstName()+" is : "+documentSign.getMessage()+""
										+ " <br/> <br/> kindly sign the document by clicking on this <a href='"+url+"'>link</a>";*/
								
								String body = "You have been requested by <b>"+originator.getFirstName()+"</b> to sign a document in DrySign. "
										+ "<br/> <b>"+originator.getFirstName()+"</b> has sent you the following message: "+documentSign.getMessage()+""
										+ " <br/> <br/> Kindly sign the document by clicking on this link:  <a href='"+url+"'>Sign Document</a>";
								
								
								try {
									 new SendEmail().SendingEmailWithImages(signer.getEmail(), nextSigner.getEmail(), nextSignsubject, body, inlineImages, nextSigner.getFirstName());
									//new SendEmail().SendingEmail(originator.getEmail(), nextSigner.getEmail(), nextSignsubject, body);
								} catch (Exception e) {
									logger.error("Error while sending email to signer:"+nextSigner.getEmail()+" when document requested by signer: "+originator.getEmail()+" "+e);						
								}
		
							}
							//end send email to next signer if available
							
							status = "success";
							
							
							//verifyDetails = jerseyService.updateDocument(documentName);
							
						}catch(Exception e1){
							logger.error("Error while modify pdf or writing values to pdf or updating status of document: "+ e1);
						}finally{
							if(file != null){file.delete();}
						}
						
						// end modified document to electronic and digital
						
						
						
					}
				} catch (DaoException e) {
				status = "error";
				logger.error("Error while save document: "+e);
			}
			
			}else{
				  status = "error";
				} 	
		}else{
			status = "error";
		}

		String json = new Gson().toJson(status);
		response.setContentType("application/json");
		try {
			response.getWriter().write(json);
			logger.info("exit from "+classMethod);
		} catch (IOException e2) {logger.error("Error while write json to response : "+ e2.getMessage());}

	}
	

	
	public InputStream manipulatePdf(List<DocumentField> documentField, File file) throws IOException, COSVisitorException, KeyStoreException, NoSuchAlgorithmException, CertificateException, SignatureException
	{
		String classMethod = className+ ":  manipulatePdf";
		logger.info(String.format("Enter into "+classMethod+"(documentField = %s, file= %s)", documentField,file));

		float width = 814f;
		float height = 1152f;
		/*String ORIGNAL_FILE_PATH="";
		String SIGNED_FILE_PATH="";*/

		PDDocument doc = PDDocument.load(file);
		PDFont font = PDType1Font.HELVETICA;
		
		PDPageContentStream contentStream=null;
		for(DocumentField df:documentField){
			 
			List allPages = doc.getDocumentCatalog().getAllPages();
			PDPage page = (PDPage) allPages.get(df.getPageNumber()-1);
			df.setyPosition(page.getMediaBox().getHeight()/(height / Float.parseFloat(((DocumentField) df).getTop())));
    		df.setxPosition(page.getMediaBox().getWidth()/(width / Float.parseFloat(((DocumentField) df).getLeft())));
			
			if(df.getFieldType().equals("image")){
				String image = df.getFieldValue();
				BufferedImage awtImage;
				PDXObjectImage ximage = null;
				if (image.toLowerCase().endsWith(".jpg")) {
					ximage = new PDJpeg(doc, new FileInputStream(image));
				} else {
					awtImage = ImageIO.read(new File(image));
					ximage = new PDPixelMap(doc, awtImage);
				}
				float scale = 1f;
                PDPageContentStream contentStream1 = new PDPageContentStream(doc, page, true, false);
                float y=(792f - 20f) - df.getyPosition();
               
                contentStream1.drawXObject(ximage, df.getxPosition(),y , 68*scale, 38*scale);
				contentStream1.close();
			}else{
				contentStream = new PDPageContentStream(doc, page, true, false);
				contentStream.setNonStrokingColor(0,0,0);
				contentStream.beginText();
				contentStream.setFont(font, 10);
				float y=(792f - 20f) - df.getyPosition();
				contentStream.moveTextPositionByAmount(df.getxPosition(), y);
				contentStream.drawString(df.getFieldValue());
				contentStream.endText();
				contentStream.close();
			}
		}
		
 	   
		doc.save(file);
		doc.close();
		InputStream is = new FileInputStream(file);
		logger.info("exit from "+classMethod);
		return is;		
	}		
	
	/*@RequestMapping(value = "/my", method = RequestMethod.GET)
	 public  void my(String[] args) throws DaoException, IOException 
	 {
		 
		 InputStream inputStream = null;
		 OutputStream outputStreamUtil = null;
		 OutputStream outputStream = null;
		 String fileName = "0cd7e735-8ab3-4802-9238-51871d2c9a49agreement.pdf";
		 String filePath = TEMP_ELECTRONIC_URL+fileName;
		 File f = new File(filePath);
		 ApplicationDocument document = applicationService.readDocument(314, fileName);
		 inputStream = document.getDigital();
		 outputStream = new FileOutputStream(f);
		 
		 outputStreamUtil = new ApplicationUtils().getOutputStream(f,outputStream,inputStream);
		 inputStream.close();
		 outputStream.close();
		 //f.delete();
		System.out.println(outputStreamUtil);

	}*/
	
	@RequestMapping(value="/profile", method = RequestMethod.GET)
	public ModelAndView profile(@ModelAttribute("command") Registration registration, BindingResult result)
	{
		String classMethod = className+ ":  profile";
		logger.info(String.format("Enter into "+classMethod+"()"));
		
		Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Signature> signatureList = applicationService.getUserSignatures(user.getId());
		
		if(registration.getFirstName() == null){
			registration.setFirstName(user.getFirstName());
			registration.setLastname(user.getLastname());
			registration.setPhone(user.getPhone());
			registration.setCountry(user.getCountry());
			registration.setState(user.getState());
			registration.setPincode(user.getPincode());
		}
		
		Map<String,List<Signature>> model = new HashMap<String,List<Signature>>();
		model.put("signatures", signatureList);
	
		logger.info("exit from "+classMethod);
		return new ModelAndView("profile",model);
	}
 

	
	@RequestMapping(value="/profile", method = RequestMethod.POST)
	public ModelAndView profileUpdate(@ModelAttribute("command") Registration registration, BindingResult result)
	{
		String classMethod = className+ ":  profile";
		logger.info(String.format("Enter into "+classMethod+"()"));
		String updateStatus = null;
		List<Object> status = new ArrayList<Object>();
		Map<String,List> model = new HashMap<String,List>();
		
		Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(registration.getFirstName() == null){
			registration.setFirstName(user.getFirstName());
			registration.setLastname(user.getLastname());
			registration.setPhone(user.getPhone());
			registration.setCountry(user.getCountry());
			registration.setState(user.getState());
			registration.setPincode(user.getPincode());
		}

		updateProfileValidation.validate(registration, result);
		if(!result.hasErrors()){
			registration.setId(user.getId());
			updateStatus = applicationService.updateProfile(registration);
			
			
			if(updateStatus !=null && updateStatus.equals("1"))
			{
				status.add(updateStatus);
				model.put("updateStatus", status);
				
				//update current user session
				registration.setPhoto(user.getPhoto());
				registration.setRole(user.getRole());
				registration.setEmail(user.getEmail());
				updateSession(registration);
				/*user.setFirstName(registration.getFirstName());
				user.setLastname(registration.getLastname());
				user.setPhone(registration.getPhone());
				user.setCountry(registration.getCountry());
				user.setState(registration.getState());
				user.setPincode(registration.getPincode());
				List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
	            grantedAuths.add(new SimpleGrantedAuthority(user.getRole()));
				Authentication authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), grantedAuths);
				SecurityContextHolder.getContext().setAuthentication(authentication);*/
			}			
		}
		
		List<Signature> signatureList = (List<Signature>)applicationService.getUserSignatures(user.getId());

		model.put("signatures", signatureList);
	

		
		
		logger.info("exit from "+classMethod);
		return new ModelAndView("profile",model);
	}
	
/*	@RequestMapping(value="/app")
	public String checkvalid(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth == null){
			return new ModelAndView("redirect:/login");
		}
		return "redirect:/login";
	}*/
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/web", method = RequestMethod.GET)
	public ModelAndView web() 
	{
		String classMethod = className+ ":  web";
		logger.info(String.format("Enter into "+classMethod+"()"));
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth == null){
			return new ModelAndView("redirect:/login");
		}
		Registration user = (Registration)auth.getPrincipal();
		List signatureList =  applicationService.getUserSignatures(user.getId());
		


		@SuppressWarnings("rawtypes")
		List docCount = new ArrayList();
		try {
			DocumentCount documentCount = applicationService.getDocumentCount(user.getId());
			if(documentCount != null){
				docCount.add(documentCount.getTotal());
				docCount.add(documentCount.getComplete());
				docCount.add(documentCount.getUncomplete());
			}
		} catch (DaoException e) {
			logger.error("Error while getting documents count: "+e);
			e.printStackTrace();
		}
	
		Map<String,List<Object>> model = new HashMap<String,List<Object>>();
		model.put("signatures", signatureList);
		model.put("docCount", docCount);

		
		logger.info("exit from "+classMethod);
		return new ModelAndView("dashboard",model);
	}
	
	@RequestMapping(value="/changepassword", method = RequestMethod.POST)
	public @ResponseBody String changepassword(HttpServletRequest request,HttpServletResponse response)
	{
		String classMethod = className+ ":  changepassword";
		logger.info(String.format("Enter into "+classMethod+"(request =%s, response =%s)",request,response));

		String message = null;
		String oldpassword = request.getParameter("oldpassword");
		String newpassword = request.getParameter("newpassword");
		String confirmpassword = request.getParameter("confirmpassword");
		
		if(oldpassword == null || oldpassword.isEmpty()){
			message = "Enter old password.";
		}else if(newpassword == null || newpassword.isEmpty()){
			message = "Enter new password password.";
		}else if(newpassword.length()>25 || newpassword.length()<8){
			message = "Password between 8 to 25 chars accepted.";
        }else if(confirmpassword == null || confirmpassword.isEmpty()){
			message = "Enter confirm password.";
		}else if(!newpassword.equals(confirmpassword)){
			message = "The New and Confirm password are not matching";
		}else if(oldpassword.equals(newpassword)){
			message = "Old and New Password should not be same.  Please enter a different password.";
		}
		
		
		
		if(message == null)
		{
			newpassword = ApplicationUtils.encryptPassword(newpassword);
			Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String status = applicationService.changePassword(oldpassword,newpassword,user.getEmail());
			if(status == "success")
			{
				user.setPassword(newpassword);
				List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
	            grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
				Authentication authentication = new UsernamePasswordAuthenticationToken(user, newpassword, grantedAuths);
				SecurityContextHolder.getContext().setAuthentication(authentication);
				message = "1";
			}else{
				message = "Old password is not correct.";
			}
		}
		
		logger.info("exit from "+classMethod);
		return message;
	}
	
	@RequestMapping(value="changeprofilepic", method=RequestMethod.POST)
	public @ResponseBody String changeprofilepic(MultipartHttpServletRequest request,HttpServletResponse response)
	{
		String classMethod = className+ ":  changeprofilepic";
		logger.info(String.format("Enter into "+classMethod+"(request =%s, response =%s)",request,response));

	    boolean updateStatus;
	    String fileName = null;
	    String status = null;
	    String message = "";
	    OutputStream outputStream = null;
	    InputStream inputStream = null;

		try{
			Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			int loginuserid = user.getId();
	        MultipartFile multipartFile = request.getFile("profilepic");
	        if(multipartFile !=null){
	        	byte [] byteArr=multipartFile.getBytes();
		        inputStream = new ByteArrayInputStream(byteArr);
		      
		        fileName = new GlobalFunctions().uniqueToken()+"_"+multipartFile.getOriginalFilename();
		        
		        
				 
		        
		        String extension = "";
				int i = fileName.lastIndexOf('.');
				if (i >= 0) {
					extension = fileName.substring(i + 1);
				}
				if(loginuserid != 0){
					if (extension.toLowerCase().equals("jpg") || extension.toLowerCase().equals("jpeg") || extension.toLowerCase().equals("png")) 
					{
						//start profile picture upload to file system
				         String path = PROFILE_PIC;
				         String filePath = path+fileName;
						 File f = new File(filePath);
						 outputStream = new FileOutputStream(f);			 
						 new ApplicationUtils().getOutputStream(f,outputStream,inputStream);
						 inputStream.close();
						 outputStream.close();
						//end profile picture upload to file system 
						 
						updateStatus = applicationService.updatePhoto(loginuserid,fileName);
						if(updateStatus)
						{
							File deleteFile = new File(path+user.getPhoto());
							deleteFile.delete();
							user.setPhoto(fileName);
							List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
				            grantedAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
							Authentication authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), grantedAuths);
							SecurityContextHolder.getContext().setAuthentication(authentication);
							status = "S";
							message = "1";
						}else{
							status = "E";
							message = "Error while updating to profile pic.";
						}
					} else {
						status = "E";
						message = "Only JPEG or PNG images accepted.";
					}
				}else{
					status = "E";
					message = "Your Login id is Invalid.";

				}
	        }else{
	        	status = "E";
	        	message = "Please select photo.";
	        }
	        
			
		}catch(Exception e){
			status = "E";
			message = e.getMessage();
		}
		Gson gson = new Gson(); 
		
		Map<String,String> model = new HashMap<String, String>();
		model.put("status", status);
		model.put("fileName", fileName);
		model.put("message", message);
		String json = gson.toJson(model); 

		logger.info("exit from "+classMethod);
        return json;
    }
	
	@RequestMapping(value="/ajax/forgotpassword", method=RequestMethod.POST)
	public @ResponseBody String forgotpassword(HttpServletRequest request)
	{
		String classMethod = className+ ":  forgotpassword";
		logger.info(String.format("Enter into "+classMethod+"(request =%s)",request));


		String status = "";
		String email = request.getParameter("forgotemail");
		if(ApplicationUtils.validate(email))
		{ 	
			String token = new GlobalFunctions().uniqueToken(); 
			status = applicationService.forgotPasswordService(email,token);
			if(status.equals("error")){
				status = "Email not exist in our system.";
			}else{
				//send email to user
				String subject = "DrySign: Reset Password";
				String url = SERVER_URL+"app/resetpassword?token="+token+"&userid="+status+"&email="+email;
				String body = "Please click on the link below to reset your password. <br/> <br/>  <a href='"+url+"'>Reset Password</a> <br/>";
				 Map<String, String> inlineImages = new HashMap<String, String>();
			        inlineImages.put("image1", EMAIL_BACKIMAGE);
			        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
			        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
				try {
					new SendEmail().SendingEmailWithImages("", email, subject, body, inlineImages, email);
					//new SendEmail().SendingEmail("", email, subject, body);
					status = "1";
				} catch (Exception e) {
					logger.error("Error while sending email to user:"+email+" when forgot password: "+e);						
				}
			}
		}else{
			status = "Please enter valid email address.";
		}
		
		logger.info("exit from "+classMethod);
		return status;
	}
	
	@RequestMapping(value="/resetpassword", method=RequestMethod.GET)
	public @ResponseBody ModelAndView resetpassword(@ModelAttribute("command") ResetPassword resetPassword, HttpServletRequest request)
	{
		String classMethod = className+ ":  resetpassword";
		logger.info(String.format("Enter into "+classMethod+"(resetPassword=%s,request =%s)",resetPassword, request));

		
		String email = request.getParameter("email");
		String userid = request.getParameter("userid");
		String token = request.getParameter("token");
		
		resetPassword.setEmail(email);
		resetPassword.setUserid(userid);
		resetPassword.setToken(token);
		String flag = applicationService.checkValidResetPassword(resetPassword);
		Map<String, Object> model = new HashMap<String,Object>();
		model.put("resetPassword", resetPassword);
		model.put("flag", flag);
		
		logger.info("exit from "+classMethod);
		return new ModelAndView("resetpassword",model);
		
	}
	
	@RequestMapping(value="/resetpassword", method=RequestMethod.POST)
	public @ResponseBody ModelAndView resetpasswordSubmit(@ModelAttribute("command") ResetPassword resetPassword,BindingResult result, HttpServletRequest request)
	{
		String classMethod = className+ ":  resetpasswordSubmit";
		logger.info(String.format("Enter into "+classMethod+"(resetPassword=%s, result = %s, request = %s) ", resetPassword, result, request));
		Map<String, Object> model = new HashMap<String,Object>();
		
		String flag = applicationService.checkValidResetPassword(resetPassword);
		if(flag !=null && flag.equals("1"))
		{
			resetPasswordValidator.validate(resetPassword, result);
			String email = request.getParameter("email");
			String userid = request.getParameter("userid");
			String token = request.getParameter("token");
			if(result.hasErrors())
			{
				
				resetPassword.setEmail(email);
				resetPassword.setUserid(userid);
				resetPassword.setToken(token);
				
				model.put("resetPassword", resetPassword);
				//return new ModelAndView("resetpassword",model);
				
			}else{
				int status = applicationService.resetPasswordService(resetPassword);
				if(status>0){
					model.put("msg", "1");
				}else{
					model.put("msg", "Error while reseting password.");
				}
			}
		}
		
		
		
		model.put("flag", flag);
		model.put("resetPassword", resetPassword);

		
		logger.info("exit from "+classMethod);
		return new ModelAndView("resetpassword",model);
		
	}	
	

	
	public RestDocument getDocumentByEnvelopeId(String envelopeId)
	{
		String classMethod = className+ ":  getDocumentByEnvelopeId";
		logger.info(String.format("Enter into "+classMethod+"(envelopeId = %s) ",envelopeId));
		RestDocument restDocument = null;
		try {
			restDocument = applicationService.getDocumentByEnvelopeId(envelopeId);
		} catch (DaoException e) {
			logger.error("Error while getting document by envelopeId: "+envelopeId +" Error is : "+e);
			e.printStackTrace();
		}
		
		logger.info("exit from "+classMethod);

		return restDocument;
	}
	
	@ResponseBody
	@RequestMapping(value="/deletesignature", method=RequestMethod.POST)
	public int deletesignature(@RequestParam("signId") String signId)
	{
		int status = applicationService.deletesignature(signId);
		return status;
	}
	
	@RequestMapping(value="/savesignature", method=RequestMethod.POST)
	public @ResponseBody int savesignature(@RequestParam("dataURL") String dataURL)
	{	
		Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int id = applicationService.saveSignature(user.getId(),dataURL);
		return id;
		
	}
	
	@RequestMapping(value="/deleteprofilepic", method=RequestMethod.POST)
	public @ResponseBody int deleteprofilepic(@RequestParam("picName") String picName)
	{
		Registration user = (Registration)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int status = applicationService.deleteProfilePic(user.getId());
		if(status == 1)
		{
			String path = PROFILE_PIC+picName;
			File file = new File(path);
			file.delete();
			user.setPhoto(null);
			updateSession(user);
		}
		return status;		
	}
	
	public void updateSession(Registration user){
		user.setFirstName(user.getFirstName());
		user.setLastname(user.getLastname());
		user.setPhone(user.getPhone());
		user.setCountry(user.getCountry());
		user.setState(user.getState());
		user.setPincode(user.getPincode());
		user.setEmail(user.getEmail());
		List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
        grantedAuths.add(new SimpleGrantedAuthority(user.getRole()));
		Authentication authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), grantedAuths);
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	
	 @ResponseBody
	 @RequestMapping(value="/sendreminder", method=RequestMethod.POST)
	 public  String sendReminder( HttpServletRequest request)
	 {
		 	String message = "";
		 	String status = applicationService.increaseReminderEmailCount(Integer.parseInt(request.getParameter("mailcount"))+1,Integer.parseInt(request.getParameter("docId")),request.getParameter("signerEmailId"));
		 	if(status.equals("1"))
		 	{
		 		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				Registration user = (Registration)auth.getPrincipal();
				String userUrl = "&projectname="+user.getProject()+"&theme="+user.getTheme()+"&linktodrysign="+user.getLinktodrysign()+"&deviceversion="+user.getDeviceVersion();
			 	String token = applicationService.getTokenOfDocumentSignEmail(Integer.parseInt(request.getParameter("docId")),request.getParameter("signerEmailId"));
			    String subject = "DrySign: "+request.getParameter("subject");
			    String url = SERVER_URL+"app/applicationsigndocument?token="+token+"&envelopeid="+request.getParameter("envelopeId")+"&email="+request.getParameter("signerEmailId")+"&signername="+request.getParameter("signerName")+userUrl+"&redirecturl=";
				
			    Map<String, String> inlineImages = new HashMap<String, String>();
		        inlineImages.put("image1", EMAIL_BACKIMAGE);
		        inlineImages.put("image2", EMAIL_DRYSIGN_LOGO);
		        inlineImages.put("image3", EMAIL_SOURCEHOV_LOGO);
			    
			    /*String body = "This is a friendly reminder that you are invited to sign the document in DrySign. "
						+ "<br/> Message from requester- "+request.getParameter("requestedBy")+" is : "+request.getParameter("message")+""
						+ " <br/> <br/> Kindly sign the document by clicking on this <a href='"+url+"'>link</a>";*/
			    
			    String body = "This is a friendly reminder that you are invited to sign the document in DrySign. <br/><br/>"
			    		+ "You have been requested by <b>"+request.getParameter("requestedBy")+"</b> to sign a document in DrySign. "
						+ "<br/> <b>"+request.getParameter("requestedBy")+"</b> has sent you the following message: "+request.getParameter("message")+""
						+ " <br/> <br/> Kindly sign the document by clicking on this link:  <a href='"+url+"'>Sign Document</a>";
			    
				try {
					//new SendEmail().SendingEmail(user.getEmail(), email, subject, body);
					new SendEmail().SendingEmailWithImages(user.getEmail(), request.getParameter("signerEmailId"), subject, body, inlineImages, request.getParameter("signerName"));
					message = "Reminder has been sent successfully.";
					logger.info(body);
				} catch (Exception e) {
					message = "Error while sending reminder to signer: "+e.getMessage();
					logger.error("Error while sending reminder to signer: "+e.getMessage());
				}
		 	}else{
		 		message = "Error while sending reminder to signer ";
		 	}
		 	
		 return message;
	 }

}
