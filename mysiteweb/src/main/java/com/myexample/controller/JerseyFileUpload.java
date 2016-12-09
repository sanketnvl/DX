package com.myexample.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.ObjectWriter;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.myexample.dao.DaoException;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.ClientAuth;
import com.myexample.model.ClientUser;
import com.myexample.model.Registration;
import com.myexample.model.RestDocument;
import com.myexample.model.RestDocumentField;
import com.myexample.service.JerseyService;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.FileUtils;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.UtilityException;


 /**
 * @author matadeen.sikarawar
 *
 */
@Path("/api")
@Controller
public class JerseyFileUpload extends SpringBeanAutowiringSupport{
	
	@Autowired
	private  JerseyService jerseyService;
	String className = this.getClass().getSimpleName();
	
	private final static Logger logger = Logger.getLogger(JerseyFileUpload.class);
	private static String SERVER_URL ;

	
	ObjectMapper mapper = new ObjectMapper();
	FileUtils fileUtils = new FileUtils();
	public JerseyFileUpload() {
		try {
			SERVER_URL = new GlobalFunctions().getServerUrl();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	}
	
	
	
	
	

	@POST
	@Path("/adduserservice")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces({ MediaType.APPLICATION_JSON })
	public Response addUserService(String jsonClientUser)
	{	
		logger.info(String.format("addUserService(jsonClientUser = %s )", jsonClientUser));
		String message = null;
		
		ClientUser clientUser = null;
		//read data from json
		try {
			clientUser = mapper.readValue(jsonClientUser,ClientUser.class);
			//validation
			
			if(clientUser.getEmail() == null && clientUser.getEmail().isEmpty()){
				message = "User email can't be null.";
			}else if(clientUser.getPassword() == null && clientUser.getPassword().isEmpty()){
				message = "User password can't be null.";
			}else if(clientUser.getClient().getClientId() == 0){
				message = "Please specify client id.";
			}else{
				
				//add user
				try {
					message = jerseyService.addUserJersey(clientUser);
				} 
				catch (DaoException e) 
				{
					logger.error("Error while addUser: "+e);
					message = "Error while addUser: "+e.getMessage();
				}
				
			}
						
		}
		catch(Exception e)
		{
			logger.error("Error while parsing readValue from jsonDocumentWrapper: "+e);
			message = "Error while parsing readValue from jsonDocumentWrapper: "+e.getMessage();
		}
		
		
		return Response.ok(message).build();
	}

	@POST
	@Path("/getAllClientUser")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces({ MediaType.APPLICATION_JSON })
	public Response getAllClientUser(String jsonClientAuth)
	{
		logger.info(String.format("getAllClientUser( jsonClientAuth = %s)", jsonClientAuth));
		ClientAuth clientUserAuth = null;
		String message = null;
		
		ClientUser clientUser = new ClientUser();

		/*clientUser.setEmail("user@gmail.com");
		clientUser.setPassword("user");
		clientUser.setStatus(1);
		clientUser.setDateTime(new Date(0));

		ClientUser clientUser1 = new ClientUser();
		clientUser1.setEmail("user@gmail.com");
		clientUser1.setPassword("user");
		clientUser1.setStatus(1);
		clientUser1.setDateTime(new Date(0));*/

		List<ClientUser> clientUsers = new ArrayList<ClientUser>();
		/*clientUsers.add(clientUser);
		clientUsers.add(clientUser1);*/
		
		try {
			clientUserAuth = mapper.readValue(jsonClientAuth,ClientAuth.class);
			
			
			
			try {
				clientUsers = jerseyService.getAllClientUserService(clientUserAuth);

				ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
				
				try {
					message = ow.writeValueAsString(clientUsers);
				}catch (Exception e1) {
					logger.error("Error while writing to json: "+e1);
					message = "Error while writing to json: "+e1.getMessage();
				}
				
			} catch (DaoException e) {
				logger.error(e);
				message = e.getMessage();
			}
			
			
		} catch (Exception e) {
			logger.error("Error while parsing readValue from jsonDocumentWrapper: "+e);
			message = "Error while parsing readValue from jsonDocumentWrapper: "+e.getMessage();
		}

		
		logger.info(message);
		return Response.ok(message).build();
	}
	

	

	@POST
	@Path("/createdocument")
	@Consumes({ MediaType.MULTIPART_FORM_DATA })
	public Response createDocument(@FormDataParam("file") InputStream fileInputStream, @FormDataParam("file") FormDataContentDisposition fileMetaData, @FormDataParam("jsonDocumentWrapper") String jsonObject, @HeaderParam("Authorization") String auth)
	{
		String classMethod = className+ ":  createDocument" ;
		logger.info(String.format("Enter into "+classMethod+"(fileInputStream = %s, fileMetaData = %s, jsonDocumentWrapper = %s, auth = %s )", fileInputStream,fileMetaData,jsonObject, auth));		
		RestDocument document = null;
		String envelopeId = new GlobalFunctions().uniqueToken();
		String msg = null;
		try {
			document = mapper.readValue(jsonObject, RestDocument.class);
			document.setDocumentName(fileMetaData.getFileName());
			msg= uploadUtil(envelopeId,fileInputStream,fileMetaData,document);
			if(msg == "success"){
				document.setEnvelopeId(envelopeId);
			}
		}catch (IOException e1) {
			e1.printStackTrace();
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonClientUser = jsonObject;
		document.setStatus(msg);
		try {
			jsonClientUser = ow.writeValueAsString(document);
		} catch (IOException e) {
			logger.error("Error while write value as stirng by objectWriter: "+e);
		}
		

		
		logger.info("message: "+msg);
		logger.info("Exit from: "+ classMethod );
		return Response.ok(jsonClientUser).build();
	}
	


	
	@POST
	@Path("/updatedocument")
	public Response updatedocument(String jsonObject)
	{
		String classMethod = className+ ":  updatedocument" ;
		logger.info(String.format("Enter into "+classMethod+"(jsonObject = %s)", jsonObject));		
		
		RestDocument document = null;
		
		String msg = "success";
		try {
			document = mapper.readValue(jsonObject, RestDocument.class);
			if(document != null && document.getDocumentFields() != null)
			{
				String flag = fileUtils.validateDocument(document);
				if(flag.equals("success"))
				{
					String envelopeId = document.getEnvelopeId();
					if(envelopeId !=null && envelopeId != "")
					{
						String isValidEnvelopeIdVar = jerseyService.isValidEnvelopeId(envelopeId,document.getOriginatorEmail());
						if(isValidEnvelopeIdVar.equals("success"))
						{
							String token = new GlobalFunctions().uniqueToken();
							String message = jerseyService.modifyDocument(document,token);
							if(message == "success")
							{
								String validation = fieldsValidation(document);
								if( validation == "success")
								{
									try {
										ApplicationDocument doc = jerseyService.getDocument(envelopeId);
										if(doc.getOriginal() !=null){
											File f = ApplicationUtils.stream2file(doc.getOriginal());
											InputStream electronic = fileUtils.writeEnvelopeId(f, envelopeId);
											int updateStatus = jerseyService.modifyDocumentBlob(electronic, envelopeId, "electronic");
											if(updateStatus != 1){
												message = "Error while updating blob field in document table.";
											}else{
												String returnUrl = document.getReturnUrl() == null ? "": document.getReturnUrl();
												String url = SERVER_URL+"app/applicationsigndocument?token="+token+"&envelopeid="+envelopeId+"&email="+document.getSignerEmail()+"&redirecturl="+returnUrl;
												document.setUrl(url);
											}
											
										}else{
											msg = "File Blob is null. ";
										}
										
										
									} catch (Exception e) {
										msg = e.toString();
									}
									
								}else{
									msg = validation;
								}
								
								
								
							}else{
								msg = message;
							}
						}else{
							msg = isValidEnvelopeIdVar;
						}
						
					}else{
						msg = "EnvelopeId cannot be empty";
					}
					
				}else{
					msg = flag;
				}
			}
			
		}catch (IOException e1) {
			msg = e1.getMessage();
			e1.printStackTrace();
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonClientUser = jsonObject;
		document.setStatus(msg);
		try {
			jsonClientUser = ow.writeValueAsString(document);
		} catch (IOException e) {
			logger.error("Error while write value as stirng by objectWriter: "+e);
		}
		

		
		logger.info("message: "+msg);
		
		logger.info("Exit from "+classMethod);
		return Response.ok(jsonClientUser).build();
	}

	
	private String fieldsValidation(RestDocument document) 
	{
		String message = "";
		for(RestDocumentField documentSignField: document.getDocumentFields())
		{	
			String fieldType = documentSignField.getFieldType();
			if( fieldType.equals("text") || fieldType.equals("image"))
			{
				String fieldName = documentSignField.getFieldName();
				if(fieldName.equals("name") || fieldName.equals("date") || fieldName.equals("sign"))
				{
					if(documentSignField.getPageNumber() >0)
					{
						
						if(documentSignField.getxPosition() >0 && documentSignField.getxPosition() <= 814)
						{}else{
							message = "Field X position must be between 1 to 814.";
							break;
						}

						if(documentSignField.getyPosition()>0 && documentSignField.getyPosition() <=1154)
						{}else{
							message = "Field Y position must be between 1 to 1154.";
							break;
						}

						if(documentSignField.getFieldHeight() > 9 && documentSignField.getFieldHeight() <= 50 )
						{}else{
							message = "Field Height must be between 10 to 50.";
							break;
						}

						if(documentSignField.getFieldWidth() > 99 && documentSignField.getFieldWidth() <= 200)
						{
							message = "success";
						}else{
							message = "Field Width must be between 100 to 200.";
							break;
						}
					
					
					
					}else{
						message = "Field Page number must be greater than 1.";
						break;
					}
				}else{
					message = "Field Name must be name or date or sign";
					break;
				}
			}else{
				message = "Field Type must be text or image.";
				break;
			}
		}
		
		return message;
	}






	@POST
	@Path("/upload")
	@Consumes({ MediaType.MULTIPART_FORM_DATA })
	public Response uploadDocument(@FormDataParam("file") InputStream fileInputStream, @FormDataParam("file") FormDataContentDisposition fileMetaData, @FormDataParam("jsonDocumentWrapper") String jsonObject, @HeaderParam("Authorization") String auth)
	{
		String classMethod = className+ ":  updatedocument" ;
		logger.info(String.format("Enter into "+classMethod+"(jsonObject = %s)", jsonObject));		
		
		RestDocument document = null;
		
		String msg = "success";
		try {
			document = mapper.readValue(jsonObject, RestDocument.class);
			if(document != null && document.getDocumentFields() != null)
			{
				String flag = fileUtils.validateDocument(document);
				if(flag.equals("success"))
				{
					String envelopeId = new GlobalFunctions().uniqueToken();
					String uploadStatus= uploadUtil(envelopeId,fileInputStream,fileMetaData,document);
					if(uploadStatus == "success"){
						document.setEnvelopeId(envelopeId);
						String token = new GlobalFunctions().uniqueToken();
						String message = jerseyService.modifyDocument(document,token);
						if(message == "success")
						{

							String returnUrl = document.getReturnUrl() == null ? "": document.getReturnUrl();
							String url = SERVER_URL+"applicationsigndocument?token="+token+"&envelopeid="+envelopeId+"&email="+document.getSignerEmail()+"&redirecturl="+returnUrl;
							document.setUrl(url);
							
						}else{
							msg = message;
						}
					}else{
						msg = uploadStatus;
					}
					
					
				}else{
					msg = flag;
				}
			}
			
		}catch (IOException e1) {
			msg = e1.getMessage();
			e1.printStackTrace();
		}
		
		
		ObjectWriter ow = mapper.writer().withDefaultPrettyPrinter();
		String jsonClientUser = jsonObject;
		document.setStatus(msg);
		try {
			jsonClientUser = ow.writeValueAsString(document);
		} catch (IOException e) {
			logger.error("Error while write value as stirng by objectWriter: "+e);
		}
		

		
		logger.info("message: "+msg);
		
		logger.info("Exit from "+classMethod);
		return Response.ok(jsonClientUser).build();
	}
	
	
	@POST
	@Path("/downloadDocument")
	public Response downloadDocument(String documentId)
	{
		ApplicationDocument document = new ApplicationDocument();
		InputStream is = null;
		try {
			document = jerseyService.getDocument(documentId);
			File file = ApplicationUtils.stream2file(document.getDigital());
			
			is = new FileInputStream(file);
			return Response.ok(is).build();
		} catch (Exception e) {
			logger.error("Error while downloadDocument By web service api: for documentid: "+documentId+" Error is : "+e);
			e.printStackTrace();
		}
		return null;

		
		
	}

	
	public Registration getUser(String email){
		Registration user = null;
		try {
			user = jerseyService.getUser(email);
		} catch (DaoException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public String uploadUtil(String envelopeId, InputStream fileInputStream, FormDataContentDisposition fileMetaData, RestDocument document)
	{
		
		String msg ="";
		String fileName = fileMetaData.getFileName();
		String signType = "R";//R=>REST
		int status = 0;
		
		
			if(document != null)
			{
				String email = document.getOriginatorEmail();
				boolean flag = false;
				if(email !=null){
					flag = ApplicationUtils.validate(email);
				}
				
				if(flag)
				{
					// Start pdf uploading
					if(fileUtils.checkValidPdf(fileName))
					{
						InputStream inputStream = fileUtils.WriteFile(fileInputStream,fileName);
						if(inputStream !=null)
						{
							
							Registration user = getUser(email);
							if(user != null)
							{
								int uploadFlag;
								try {
									uploadFlag = jerseyService.createDocument(user.getId(),envelopeId,fileName,inputStream,status,signType,document.getSubject(),document.getMessage());
									if(uploadFlag > 0)
									{
										msg = "success";
									}else{
										msg = "problem while inserting to db.";
									}
								} catch (DaoException e) {
									logger.error("problem while inserting to db: "+e);
								}
								
							}else{
								msg = "Originator email not exist.";
							}
						}else{ msg = "Error while writing pdf to physical directory. "; }
					}else{ msg = "Only pdf files accepted."; }
					// End pdf uploading
				}else{ msg = "Originator email not valid."; }
			}
	
		return msg;
	}
	
    
}