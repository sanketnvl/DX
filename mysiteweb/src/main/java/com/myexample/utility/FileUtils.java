package com.myexample.utility;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.exceptions.SignatureException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentCatalog;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.edit.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;

import com.myexample.model.RestDocument;
import com.myexample.model.RestDocumentField;

public class FileUtils {

	
	private static String TEMP_FILE_PATH;
	private final static Logger logger = Logger.getLogger(FileUtils.class);
	public FileUtils() {
		try {
		
			TEMP_FILE_PATH = new GlobalFunctions().getTemporaryFilePath();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	}
	//**************************************************************************Util methods***************************************************/	

	
	

	
	public String validateDocument(RestDocument document) 
	{
		String message = "success";
		
		if(document != null && document.getDocumentFields() != null)
		{
			if(document.getOriginatorEmail() ==null )
			{
				message = "Originator email cannot be empty.";
			}else if(!ApplicationUtils.validate(document.getOriginatorEmail()))
			{
				message = "Originator email not valid.";
			}else if(document.getSignerEmail() == null)
			{
				message = "Signer email cannot be empty.";
			}else if(!ApplicationUtils.validate(document.getSignerEmail()))
			{
				message = "Signer email not valid.";
			}else if(document.getDocumentFields() !=null)
			{
				for(RestDocumentField df : document.getDocumentFields())
		   		 {		 
					if(df.getFieldType() == null && df.getFieldType().isEmpty()){
						message = "Document type can't be null.";
						break;
					}else if(!(df.getPageNumber() > 0 )){
						message = "Document page number must be greater than 0";
						break;
					}else if(df.getxPosition() <= 0){
						message = "Document field x position must be greater than 0";
						break;
					}else if(df.getyPosition() <= 0){
						message = "Document field y position must be greater than 0";
						break;
					}else if(df.getFieldHeight() < 0){
						message = "Document field height position must be greater than 0";
						break;
					}else if(df.getFieldWidth() < 0 ){
						message = "Document field width position must be greater than 0";
						break;
					}else if(df.getFieldName() == null && df.getFieldName().isEmpty()){
						message = "Field name can't be empty.";
						break;
					}
		   		 }
			}
		}else{
			message = "Document cant be empty.";
		}
		
		return message;
	}
	
	
	public boolean checkValidPdf(String fileName)
	{
		boolean flag = false;
		String extension = "";
		int i = fileName.lastIndexOf('.');
		if (i >= 0) 
		{
			extension = fileName.substring(i + 1);
			if (extension.equals("pdf")) {
				flag = true;
			}
		}

		
		return flag;
	}
	
	public InputStream WriteFile(InputStream fileInputStream,String fileName)
	{
		InputStream inputStream = null; 
		int read = 0;
		byte[] bytes = new byte[1024];
		String filePath =TEMP_FILE_PATH+fileName; 
		
		try{
			File file = new File(filePath);
			OutputStream out = new FileOutputStream(file);
			while ((read = fileInputStream.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			out.flush();
			out.close();
			
			if((inputStream = makeFlattenFile(file,fileName)) == null)
			{
				inputStream = new FileInputStream(file);
			}
			
			
			file.deleteOnExit();
		}catch(Exception e){
			logger.error("Error while writing pdf to physical directory: "+e);
		}
		return inputStream;
	}
	
    public InputStream writeEnvelopeId(File file, String envelopeId ) throws IOException, COSVisitorException, KeyStoreException, NoSuchAlgorithmException, CertificateException, SignatureException
	{

		PDDocument doc = PDDocument.load(file);
		PDFont font = PDType1Font.HELVETICA;
		
		PDPageContentStream contentStream=null;
		
		
		List<PDPage> allPages = doc.getDocumentCatalog().getAllPages();
		PDPage page = (PDPage) allPages.get(1-1);
		contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.setNonStrokingColor(0,0,0);
		contentStream.beginText();
		contentStream.setFont(font, 10);

		contentStream.moveTextPositionByAmount(20, 780);
		contentStream.drawString("EnvelopeID:"+envelopeId);
		contentStream.endText();
		contentStream.close();
	
		
		doc.save(file);
		doc.close();
		InputStream is = new FileInputStream(file);
		
		return is;		
	}
	
    @SuppressWarnings("unchecked")
	public InputStream makeFlattenFile(File file,String fileName)
    {
    	
    	InputStream newStream = null;
    	
    	try{
	    	PDDocument document = PDDocument.load(file);
			List<PDPage> allPages = document.getDocumentCatalog().getAllPages();
			
			PDDocumentCatalog pdCatalog = document.getDocumentCatalog();
			PDAcroForm acroForm = pdCatalog.getAcroForm();
			if(acroForm != null)
			{
				List<PDField> fields = acroForm.getFields();
				
			    for (PDField field : fields) 
			    {
			        field.setReadonly(true);	       
			    }
			    
			    //start create new document
			    File newFile  = new File(TEMP_FILE_PATH+fileName);
			    PDDocument doc = new PDDocument();
				if(allPages.size()>0)
				{
					for(int i=0; i<allPages.size(); i++)
					{
						PDPage page = (PDPage) allPages.get(i);	//PDPage page = new PDPage();
						doc.addPage(page);
					}
					doc.save(newFile);
					newStream = new FileInputStream(newFile);
				}
				newFile.deleteOnExit();
				//end create new document
			}else{
				newStream = new FileInputStream(file);
			}
    	}catch(Exception e){
    		logger.error(e);
    	}
    	return newStream;
    }
	
}
