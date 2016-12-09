package com.myexample.utility;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.RandomStringUtils;
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

import com.myexample.controller.PDFManupulation;
import com.myexample.model.DocumentField;
/**
 * This class handle self sign modification
 * @author Sanket.Navale
 *
 */
public class SelfSignPdfModifier {
	
	private final static Logger logger = Logger.getLogger(PDFManupulation.class);
	public static final float width = 814f;
	public static final float height = 1152f;
	public static String ORIGNAL_FILE_PATH=null,SIGNED_FILE_PATH=null;
	public SelfSignPdfModifier() {
		// TODO Auto-generated constructor stub
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			SIGNED_FILE_PATH = globalfunctions.getSignPdfPath();
			ORIGNAL_FILE_PATH = globalfunctions.getOrignalPdfPath();
			
		
		} catch (UtilityException e) {
			logger.error(e);
		}
	}
	
	/**
	 * Modified SelfSign PDF and Create Digital Signed PDF
	 * @author Sanket.Navale
	 * @param documentField
	 * @throws IOException
	 * @throws COSVisitorException
	 * @throws KeyStoreException
	 * @throws NoSuchAlgorithmException
	 * @throws CertificateException
	 * @throws SignatureException
	 */
	public InputStream selfSignManipulatePdf(List<DocumentField> documentField,File file) throws IOException, COSVisitorException, KeyStoreException, NoSuchAlgorithmException, CertificateException, SignatureException
	{
		logger.info("[Start] SelfSign selfSignManipulatePdf >>>>");
		
		PDDocument doc = PDDocument.load(file);
		PDFont font = PDType1Font.HELVETICA;
		
		PDPageContentStream contentStream=null;
		for(DocumentField df:documentField){
			 
			List allPages = doc.getDocumentCatalog().getAllPages();
			PDPage page = (PDPage) allPages.get(df.getPageNumber());
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
				float scale = 1.2f;
                PDPageContentStream contentStream1 = new PDPageContentStream(doc, page, true, false);
                float y=(page.getMediaBox().getHeight()-30f)- df.getyPosition();
               
                contentStream1.drawXObject(ximage, df.getxPosition(),y , 87*scale, 25*scale);
				contentStream1.close();
			}else{
				contentStream = new PDPageContentStream(doc, page, true, false);
				contentStream.beginText();
				contentStream.setFont(font, 10);
				float y=(page.getMediaBox().getHeight()-20f) - df.getyPosition();
				contentStream.moveTextPositionByAmount(df.getxPosition(), y);
				contentStream.drawString(df.getFieldValue());
				contentStream.endText();
				contentStream.close();
			}
		}
		doc.save(file);
		doc.close();
		
		InputStream is = new FileInputStream(file);
		logger.info("[End] SelfSign selfSignManipulatePdf >>>>");
		
		return is;	
		//Handle digitally sign PDF 
		//CommonUtils.createDigitalSignature(ABSOULATE_SIGNED_PATH,SIGNED_PATH);
		
	}	
	
	/***
	 * @author Sanket.Navale
	 * Get Page Number from Pixels
	 * @param position
	 * @return
	 */
	public int getPageNumber(float position){
		float total= position / height ;
		String string_temp = new Float(total).toString();
		String string_form = string_temp.substring(0,string_temp.indexOf('.'));
		int pageNo = Integer.valueOf(string_form);
		return pageNo;
		
	}
	
	/**
	 * Modified Top Position based on Page Number 
	 * @author Sanket.Navale
	 * @param pageNo
	 * @param YPosition
	 * @return
	 */
	public float getTopPosition(int pageNo,float YPosition){
		float fYPosition=YPosition-(pageNo*height);
		return fYPosition;
		
	}
}
