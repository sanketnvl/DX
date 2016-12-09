package com.myexample.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

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

import com.myexample.model.DocumentField;
import com.myexample.utility.CommonUtils;
import com.myexample.utility.GlobalFunctions;







/**
 * @author Aman.Sikarawar
 *
 */
public class PDFModifier {

	private final static Logger logger = Logger.getLogger(PDFManupulation.class);
	public static final float width = 814f;
	public static final float height = 1152f;
	public static final String ORIGNAL_FILE_PATH="D:\\sourceHOV\\original\\";
	public static final String SIGNED_FILE_PATH="D:\\sourceHOV\\signedpdf\\";
	public   String APP_DIGITAL_DOCS = "D:/sourceHOV/application_digital_docs/";
	public   String APP_ELECTRONIC_DOCS = "D:/sourceHOV/application_electronic_docs/";
	//private static int pdfY = 1152;
	
	public void appManipulatePdf(String src, String dest, User user)
	{
		logger.info(String.format("manipulatedPDF(src = %s, dest = %s, user = %s)", src, dest,user));
		
		String filePath = dest + user.getFileName();
		

		logger.info("name: " + user.getFullName() + " nameLeft: "+ user.getNameLeft() + " nameTop: " + user.getNameTop());
		logger.info("date: " + user.getSignDate() + " dateLeft: "+ user.getDateLeft() + " dateTop: " + user.getDateTop());
		logger.info("left: " + user.getSignLeft() + " top: "+ user.getSignTop());

		try{
		// pdfbox implementation
		PDDocument doc = PDDocument.load(src);
		@SuppressWarnings("rawtypes")
		List allPages = doc.getDocumentCatalog().getAllPages();

		PDPage page = (PDPage) allPages.get(0);

		PDFont font = PDType1Font.HELVETICA;


		float xSignPosition = page.getMediaBox().getHeight()/(height / Float.parseFloat(user.getSignLeft()));
		float ySignPosition = page.getMediaBox().getWidth()/(width / Float.parseFloat(user.getSignTop()));

		float xNamePosition = page.getMediaBox().getHeight()/(height / Float.parseFloat(user.getNameLeft()));
		float yNamePosition = page.getMediaBox().getWidth()/(width / Float.parseFloat(user.getNameTop()));

		float xDatePosition = page.getMediaBox().getHeight()/(height / Float.parseFloat(user.getDateLeft()));
		float yDatePosition = page.getMediaBox().getWidth()/(width / Float.parseFloat(user.getDateTop()));
		
		
		String image = user.getCreatedSign();
		
		BufferedImage awtImage;
		PDXObjectImage ximage = null;
		
		if (image.toLowerCase().endsWith(".jpg")) {
			ximage = new PDJpeg(doc, new FileInputStream(image));
		} else {
			awtImage = ImageIO.read(new File(image));
			ximage = new PDPixelMap(doc, awtImage);
		}

		PDPageContentStream contentStream = new PDPageContentStream(doc, page,true, false);

		// name
		
		
		contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.beginText();
		contentStream.setFont(font, 10);
		float yName=(792f - 20f) - yNamePosition;
		contentStream.moveTextPositionByAmount(xNamePosition, yName);
		contentStream.drawString(user.getFullName());
		contentStream.endText();
		contentStream.close();
		
		/*contentStream.beginText();
		contentStream.setFont( font, 10 );
		contentStream.moveTextPositionByAmount(Float.parseFloat(user.getNameLeft()),Float.parseFloat(user.getNameTop()));
		contentStream.drawString(user.getFullName());
		contentStream.endText();
		contentStream.close();*/

		// date
		
		
		contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.beginText();
		contentStream.setFont(font, 10);
		float yDate=(792f - 20f) - yDatePosition;
		contentStream.moveTextPositionByAmount(xDatePosition, yDate);
		contentStream.drawString(user.getSignDate());
		contentStream.endText();
		contentStream.close();

		
		
		/*contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.beginText();
		contentStream.setFont( font, 10 );
		contentStream.moveTextPositionByAmount(Float.parseFloat(user.getDateLeft()),Float.parseFloat(user.getDateTop()));
		contentStream.drawString(user.getSignDate());
		contentStream.endText();
		contentStream.close();*/

		// signature
		
		
		float scale = 1f;
        contentStream = new PDPageContentStream(doc, page, true, false);
        float ySign=(792f - 20f) - ySignPosition;
       
        contentStream.drawXObject(ximage, xSignPosition,ySign , 68*scale, 38*scale);
		contentStream.close();
		
		
		/*contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.drawXObject(ximage, Float.parseFloat(user.getSignLeft()),Float.parseFloat(user.getSignTop()), 200, 40);
		contentStream.close();*/

		doc.save(filePath);
		doc.close();
		
		new CommonUtils().createAppDigitalSignature(filePath,APP_DIGITAL_DOCS,user.getFileName());
		
		//new RSASecurityPack().encryption(src, dest, user.getFileName());
		}catch(Exception e){
			logger.error("Error while writting pdf: "+e);
			System.out.println("error");
		}
		System.out.println("Done");

	}




	
	public void manipulatePdf(List<DocumentField> documentField) throws IOException, COSVisitorException, KeyStoreException, NoSuchAlgorithmException, CertificateException, SignatureException
	{
		
		PDDocument doc = PDDocument.load(ORIGNAL_FILE_PATH+documentField.get(0).getDocumentName());
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
				/*contentStream = new PDPageContentStream(doc, page, true, false);
				contentStream.drawXObject(ximage, df.getxPosition(), (792f - 20f) - df.getyPosition(), 80, 30);*/
				System.out.println("sign: "+ximage);
				float scale = 1f;
                PDPageContentStream contentStream1 = new PDPageContentStream(doc, page, true, false);
                float y=(792f - 20f) - df.getyPosition();
               
                contentStream1.drawXObject(ximage, df.getxPosition(),y , 68*scale, 38*scale);
				contentStream1.close();
			}else{
				contentStream = new PDPageContentStream(doc, page, true, false);
				contentStream.beginText();
				contentStream.setFont(font, 10);
				float y=(792f - 20f) - df.getyPosition();
				contentStream.moveTextPositionByAmount(df.getxPosition(), y);
				contentStream.drawString(df.getFieldValue());
				contentStream.endText();
				contentStream.close();
			}
		}
		String SIGNED_PATH=documentField.get(0).getDocumentName();
		String ABSOULATE_SIGNED_PATH=SIGNED_FILE_PATH+SIGNED_PATH;
		doc.save(ABSOULATE_SIGNED_PATH);
		doc.close();
		
		CommonUtils.createDigitalSignature(ABSOULATE_SIGNED_PATH,SIGNED_PATH);
		
	}	
	
	public void appManipulatePdf1(String src, String dest, User user)
	{
		logger.info(String.format("manipulatedPDF(src = %s, dest = %s, user = %s)", src, dest,user));
		
		String filePath = dest + user.getFileName();
		

		

		logger.info("name: " + user.getFullName() + " nameLeft: "+ user.getNameLeft() + " nameTop: " + user.getNameTop());
		logger.info("date: " + user.getSignDate() + " dateLeft: "+ user.getDateLeft() + " dateTop: " + user.getDateTop());
		logger.info("left: " + user.getSignLeft() + " top: "+ user.getSignTop());

		try{
		// pdfbox implementation
		PDDocument doc = PDDocument.load(src);
		@SuppressWarnings("rawtypes")
		List allPages = doc.getDocumentCatalog().getAllPages();

		PDPage page = (PDPage) allPages.get(0);

		PDFont font = PDType1Font.HELVETICA;


		String image = user.getCreatedSign();
		BufferedImage awtImage;

		PDXObjectImage ximage = null;
		if (image.toLowerCase().endsWith(".jpg")) {
			ximage = new PDJpeg(doc, new FileInputStream(image));
		} else {
			awtImage = ImageIO.read(new File(image));
			ximage = new PDPixelMap(doc, awtImage);
		}

		PDPageContentStream contentStream = new PDPageContentStream(doc, page,
				true, false);

		// name
		contentStream.beginText();
		contentStream.setFont( font, 10 );
		contentStream.moveTextPositionByAmount(Float.parseFloat(user.getNameLeft()),Float.parseFloat(user.getNameTop()));
		contentStream.drawString(user.getFullName());
		contentStream.endText();
		contentStream.close();

		// date
		contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.beginText();
		contentStream.setFont( font, 10 );
		//contentStream.moveTextPositionByAmount(Float.parseFloat(user.getDateLeft()),Float.parseFloat(user.getDateTop()));
		contentStream.moveTextPositionByAmount(Float.parseFloat(user.getDateLeft()),Float.parseFloat(user.getDateTop()));
		contentStream.drawString(user.getSignDate());
		contentStream.endText();
		contentStream.close();

		// signature
		contentStream = new PDPageContentStream(doc, page, true, false);
		contentStream.drawXObject(ximage, Float.parseFloat(user.getSignLeft()),Float.parseFloat(user.getSignTop()), 200, 40);
		contentStream.close();

		doc.save(filePath);
		doc.close();
		
		new CommonUtils().createAppDigitalSignature(filePath,APP_DIGITAL_DOCS,user.getFileName());
		
		//new RSASecurityPack().encryption(src, dest, user.getFileName());
		}catch(Exception e){
			logger.error("Error while writting pdf: "+e);
			System.out.println("error");
		}
		System.out.println("Done");

	}

}
