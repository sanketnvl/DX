package com.myexample.controller;

import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.myexample.dao.DaoException;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.Document;
import com.myexample.model.DocumentField;
import com.myexample.service.ApplicationService;
import com.myexample.service.DocumentService;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.CommonUtils;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.ImageResizer;
import com.myexample.utility.SelfSignPdfModifier;
import com.myexample.utility.SendEmail;
import com.myexample.utility.UtilityException;

/*
 * This controller manage Self-Sign functionality 
 * @author: Sanket Navale
 */

@Controller
@RequestMapping("/app")
public class SelfsignController {
	private static String path,SIGNATURE_PATH ;
	private static String TEMP_DIGITAL_URL;
	private static String APP_DIGITAL_DOCS;
	private static final Logger logger = Logger.getLogger(SelfsignController.class);
	
	@Autowired
	private ApplicationService applicationService;
	
	@Autowired
	private DocumentService documentService;
	
	SelfsignController(){

		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			path = globalfunctions.getUploadPath();
			SIGNATURE_PATH = globalfunctions.getSignaturePath();
			TEMP_DIGITAL_URL = new GlobalFunctions().getTempAppDigitalSignPdfPath();
			APP_DIGITAL_DOCS = globalfunctions.getAppDigitalSignPdfPath();
			logger.info(String.format("SelfsignController(PATH = %s , )", path));
		
		} catch (UtilityException e) {
			logger.error(e);
		}
		
	}
	
	/***
	 * Redirect to SelfSign JSP
	 * @author Sanket.Navale
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = "/redirectSelfSign",method = RequestMethod.POST)
	public String redirectSelfSign(@ModelAttribute DocumentField df, Model model,HttpServletRequest request,HttpServletResponse response) 
	{
		logger.info("PDF data"+df.getDocData());
		model.addAttribute("fileName",df.getFileName());
		model.addAttribute("fileId",df.getFileId());
		model.addAttribute("pdfData", df.getDocData());
		model.addAttribute("enable", 1);
		return "selfSign";
	}
	
	/***
	 * Redirect to SelfSign JSP
	 * @author Sanket.Navale
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/selfSign")
	public ModelAndView selfSign(HttpServletRequest request) 
	{
		List<String> list = new ArrayList<String>();
		if(new File(path).exists()){
			for (final File fileEntry : new File(path).listFiles()) {
				list.add(fileEntry.getName());
			}
		}

		Map<String, List<String>> model = new HashMap<String, List<String>>();
		model.put("list", list);
		
		return new ModelAndView("selfSign", model);
	}
	
	/**
	 * View SelfSign PDF
	 * @author Sanket.Navale
	 * @param fname
	 * @param attr
	 * @param request
	 * @return
	 */
	/*@RequestMapping(value = "/viewselfsign")
	public ModelAndView viewselfsign(@RequestParam("fname") String fname,RedirectAttributes attr, HttpServletRequest request) 
	{
		try {
			File f = new File(path + fname);
			if (f.exists()) {
				System.out.println("file exitst");
				@SuppressWarnings("resource")
				RandomAccessFile raf = new RandomAccessFile(f, "r");
				FileChannel channel = raf.getChannel();
				ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
				PDFFile pdf = new PDFFile(buf);

				Map<String, String> model = new HashMap<String, String>();
				model.put("numpages", "" + pdf.getNumPages());
				model.put("filename", fname);

				return new ModelAndView("viewselfSign", model);

			} else {
				attr.addFlashAttribute("fileMsg", "File Not Found.");
				return new ModelAndView("redirect:/viewselfSign");
			}
		} catch (Exception e) {
			logger.error("file exception"+e.getMessage());
			attr.addFlashAttribute("fileMsg", e.getMessage());
			return new ModelAndView("redirect:/viewselfSign");
		}
	}*/
	@RequestMapping(value = "/viewselfsign")
	public ModelAndView viewselfsign(@RequestParam("fileid") String fileId, @RequestParam("fname") String fname,RedirectAttributes attr, HttpServletRequest request) 
	{
		String classMethod =":  viewselfsign" ;
		logger.info(String.format("Enter into "+classMethod+"(fileid = %s, fname = %s)", fileId, fname));
		File f = null;
		try {
			ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileId),fname);
			
			f = ApplicationUtils.stream2file(doc.getOriginal());
			if (f.exists()) {
				int count = ApplicationUtils.getPageCount(f);
				Map<String, String> model = new HashMap<String, String>();
				model.put("numpages", "" + count);
				model.put("filename", fname);
				model.put("fileid",fileId);
				logger.info("exit from "+classMethod);
				return new ModelAndView("selfsignrender", model);
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

	/*@RequestMapping(value = "/viewselfsign")
	public ModelAndView viewselfsign(@RequestParam("fileId") String fileId, @RequestParam("fileName") String fname,RedirectAttributes attr, HttpServletRequest request) 
	{
		logger.info(String.format("groupSignRender(fileid = %s, fname = %s)", fileId, fname));
		try {
			ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileId),fname);
			
			File f = ApplicationUtils.stream2file(doc.getOriginal());
			if (f.exists()) {
				@SuppressWarnings("resource")
				RandomAccessFile raf = new RandomAccessFile(f, "r");
				FileChannel channel = raf.getChannel();
				ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
				PDFFile pdf = new PDFFile(buf);
				int count = ApplicationUtils.getPageCount(f);
				Map<String, String> model = new HashMap<String, String>();
				model.put("numpages", "" + count);
				model.put("filename", fname);
				model.put("fileid",fileId);
				model.put("type","1");
				return new ModelAndView("viewselfSign", model);

			} else {
				attr.addFlashAttribute("fileMsg", "File Not Found.");
				return new ModelAndView("redirect:/viewselfSign");
			}
		} catch (Exception e) {
			attr.addFlashAttribute("fileMsg", e.getMessage());
			return new ModelAndView("redirect:/viewselfSign");
		}
	}*/
	
	/**
	 * Render nth number of PDF pages
	 * @author Sanket.Navale
	 * @param fname
	 * @param fpage
	 * @param attr
	 * @param response
	 */
	@RequestMapping(value = "/renderSelfsign")
	public void renderSelfsign(@RequestParam("fileid") String fileid,@RequestParam("filename") String fname,@RequestParam("page") String fpage, RedirectAttributes attr,HttpServletResponse response) 
	{
		logger.info(String.format("imgselfsign( fname = %s, fpage = %s)", fname, fpage));
		try {
			//File f = new File(path + fname);
			ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileid),fname);
			File f = ApplicationUtils.stream2file(doc.getOriginal());
			if (f.exists()) {
				
				ApplicationUtils.writeImageToBrowser(response,f,fpage);
/*
				@SuppressWarnings("resource")
				RandomAccessFile raf = new RandomAccessFile(f, "r");
				FileChannel channel = raf.getChannel();
				ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
				PDFFile pdf = new PDFFile(buf);

				PDFPage page = pdf.getPage(Integer.parseInt(fpage));
				int width = 890;
				int height = 1152;

				Rectangle rect = new Rectangle(0, 0, (int) page.getBBox().getWidth(), (int) page.getBBox().getHeight());
				BufferedImage bufferedImage = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);

				Image image = page.getImage(width, height, rect, null, true,true);
				Graphics2D bufImageGraphics = bufferedImage.createGraphics();
				bufImageGraphics.drawImage(image, 0, 0, null);

				response.setContentType("image/jpeg");
				OutputStream out = response.getOutputStream();
				ImageIO.write(bufferedImage, "jpg", out);

				out.flush();
				out.close();*/

				// return "";

			} else {
				logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
		} catch (Exception e) {
			logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		}
	}
	
	/**
	 * Upload PDF File on SelfSign
	 * @author Sanket.Navale
	 * @param file
	 * @param attr
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uploadSelfSignFile")
	public ModelAndView uploadSelfSignFile(@RequestParam("file") MultipartFile file,
			RedirectAttributes attr, HttpServletRequest request) {

		try {
			byte[] b = file.getBytes();
			File f = new File(path + file.getOriginalFilename());

			String extension = "";

			int i = file.getOriginalFilename().lastIndexOf('.');
			if (i >= 0) {
				extension = file.getOriginalFilename().substring(i + 1);
			}
			//System.out.println(extension);

			if (extension.toLowerCase().equals("pdf")) {
				BufferedOutputStream out;
				out = new BufferedOutputStream(new FileOutputStream(f));
				out.write(b);
				out.close();
				attr.addFlashAttribute("fileMsg", "Successfully uploaded");
			} else {
				attr.addFlashAttribute("fileMsg", "Only pdf files allowed.");
			}

		} catch (Exception e) {
			attr.addFlashAttribute("fileMsg",
					"Error in file Upload: " + e.getMessage());
		}

		return new ModelAndView("redirect:/viewselfSign");
	}
	
	/***
	 * Save self sign meta data and store digitally sign PDF as BLOB in database
	 * @author Sanket.Navale
	 * @param request
	 * @param response
	 * @param documentField
	 */
	@RequestMapping(value = "/ajax/saveSelfSign", method = RequestMethod.POST)
	public @ResponseBody void saveSelfSign(HttpServletRequest request, HttpServletResponse response,@RequestBody List<DocumentField> documentField,@RequestParam("email") String email,@RequestParam("recipient") String recipient,@RequestParam("cc") String cc,@RequestParam("title") String title,@RequestParam("message") String message,@RequestParam("userId") String userId) 
	{
		
		logger.info("========================================================================>[Start] SelfSign Method");
		logger.info("[SelfSign Document Data] Email:"+email+" & Recipient:"+recipient+" & cc:"+cc+" & Title:"+title+" & Message:"+message+" & UserId:"+userId);
		
		
		String statusResponse=null;
		String signatureString = null;
		int eBlob=0 ;
		int dBlob=0;
		try{
	
			if(documentField.size()>0){
				
				List<DocumentField> fields=CommonUtils.replacePixelName(documentField);	
				
				SelfSignPdfModifier modifier = new SelfSignPdfModifier();
				
				for(DocumentField df:documentField){
						
						
						if(df.getFieldType().equalsIgnoreCase("image")){
							
							    //Base64 modify
							    signatureString = CommonUtils.modifySignatureData(df.getFieldValue());
								String createdSign = null;
								try {
									createdSign = createSignature(signatureString);
								} catch (IOException e) {
									e.printStackTrace();
								}
							df.setFieldValue(createdSign);
						}
						
						//get page number
						int pageNo= modifier.getPageNumber(Float.parseFloat(df.getTop()));
						
						//set top position
						float fTopPosition=modifier.getTopPosition(pageNo,Float.parseFloat(df.getTop()));
						String top=String.valueOf(fTopPosition);
						
						df.setPageNumber(pageNo);
						df.setTop(top);
						logger.info("[SelfSign Modfied Document Data] >>>> PageNo:"+pageNo+ " & Top:"+df.getTop()+ " & Left:" +df.getLeft()+ " & DocumentName:"+df.getDocumentName()+ " & FieldValue:"+df.getFieldValue()+ " & FieldType:"+df.getFieldType()+ " & FieldName" +df.getFieldType() );
						
				}
				
				//Update electronics blob document
			    if(!documentField.isEmpty()){
			    	File file = null;
			    	InputStream is = null;
			    	try {
			    		ApplicationDocument document = applicationService.readDocument(documentField.get(0).getDocId(), documentField.get(0).getDocumentName());
											//create temp file
						file = ApplicationUtils.stream2file(document.getOriginal());
						
						
						is=modifier.selfSignManipulatePdf(fields,file);
						
						eBlob= applicationService.saveModifiedDocument(Integer.toString(documentField.get(0).getDocId()), is, false);
						is.close();
					
						File digitaltemp = new File(TEMP_DIGITAL_URL+documentField.get(0).getDocumentName());
						new ApplicationUtils().createDigitalSignature(file,digitaltemp,document.getEnvelopeId());
						
						InputStream dis = new FileInputStream(digitaltemp);
						dBlob = applicationService.saveModifiedDocument(Integer.toString(documentField.get(0).getDocId()),dis,true);
						
						dis.close();
						digitaltemp.delete();
						
					} catch (DaoException de) {
						logger.error("Error while reading document for self sign: "+de);
					}catch(Exception e){
						logger.error("Error while writing values on document for self sign: "+e);
					}finally{
						if(is!=null){is.close();}
						if(file!=null){file.delete();}
					}
			    	
			    

				Document document=new Document();
				document.setId(documentField.get(0).getDocId());	
				document.setSubject(title!=null? title: "");
				document.setMessage(message!=null? message: "");
				document.setSignType("S"); //G-GroupSign and S-SelfSign
				document.setStatus(1);
				document.setUpdatedOn(CommonUtils.currentDate());
				
			
				String responseDocument=documentService.saveOrUpdateDocument(document);
				logger.info("[End] SelfSign saveOrUpdateDocument");
			
				logger.info("[Start] SelfSign saveDocumentFields");
				String responseDocumentField=documentService.saveDocumentFields(documentField);
				logger.info("[End] SelfSign saveDocumentFields");
				
				
				if(responseDocument.equalsIgnoreCase("success") && responseDocumentField.equalsIgnoreCase("success") && eBlob == 1 && dBlob == 1){
					
					//Send Email with Attachment 
					SendEmail se=new SendEmail();
					
					ApplicationDocument d1 = documentService.getDocument(documentField.get(0).getDocId());
					//Write File 
					InputStream inputStream =d1.getDigital();
					try{
						FileOutputStream fos = new FileOutputStream(APP_DIGITAL_DOCS+ d1.getFileName());
						int b = 0;
						while ((b = inputStream.read()) != -1)
						{
						    fos.write(b); 
						}
						fos.close();
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						inputStream.close();
					}
					
					se.SendingEmailWithAttachment(email, recipient, title, message, d1.getFileName(), APP_DIGITAL_DOCS);
					//Send Email with Attachment 
					
					statusResponse=new Gson().toJson("success");
					
				}else{
					statusResponse=new Gson().toJson("failure");
				}
				
			   }
				
			}else{
				statusResponse=new Gson().toJson("There is network problem while saving document. Please contact support team");
			}
		}catch(Exception e1){
			e1.printStackTrace();
			
		}
		
		String json = new Gson().toJson(statusResponse);
		response.setContentType("application/json");
		try {
			response.getWriter().write(json);
		} catch (IOException e2) {
			e2.printStackTrace();
		}
		
		logger.info("========================================================================>[End] SelfSign Method");
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
		byte[] imageByteArray = CommonUtils.decodeImage1(mySignature);
		FileOutputStream imageOutFile = new FileOutputStream(filePath);
		imageOutFile.write(imageByteArray);
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
	


}
