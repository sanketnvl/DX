package com.myexample.controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myexample.model.ApplicationDocument;
import com.myexample.service.ApplicationService;
import com.myexample.service.RegisterService;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.UtilityException;
import com.sun.pdfview.PDFFile;
import com.sun.pdfview.PDFPage;



/**
 * @author Matadeen.Sikarawar
 *
 */
@Controller
public class PDFManupulation {

	@Autowired
	ServletContext servletContext;
	@Autowired
	private RegisterService registerService;
	@Autowired
	private ApplicationService applicationService;
	private static String path ;

	private static final Logger logger = Logger.getLogger(PDFManupulation.class);
	
	
	public PDFManupulation() {

		try {
			path = new GlobalFunctions().getUploadPath();
		} catch (UtilityException e) {
			logger.error("Error while getting upload path: "+e.getMessage());
		}
	
	}
	
	
	@RequestMapping(value = "/show")
	public String show() {
		return "home1";
	}

	@RequestMapping(value = "/pdf")
	public ModelAndView pdf(HttpServletRequest request) 
	{
		List<String> list = new ArrayList<String>();
		if(new File(path).exists()){
		for (final File fileEntry : new File(path).listFiles()) {
			list.add(fileEntry.getName());
		}
		}

		Map<String, List<String>> model = new HashMap<String, List<String>>();
		model.put("list", list);
		return new ModelAndView("pdf", model);
	}

	@RequestMapping(value = "/upload")
	public ModelAndView uploadpdf(@RequestParam("file") MultipartFile file,
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

		return new ModelAndView("redirect:/pdf");
	}

	@RequestMapping(value = "/appsigndoc")
	public ModelAndView appsigndoc(@RequestParam("fname") String fname,RedirectAttributes attr, HttpServletRequest request) 
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

				return new ModelAndView("readfile1", model);

			} else {
				attr.addFlashAttribute("fileMsg", "File Not Found.");
				return new ModelAndView("redirect:/pdf");
			}
		} catch (Exception e) {
			logger.error("file exception"+e.getMessage());
			attr.addFlashAttribute("fileMsg", e.getMessage());
			return new ModelAndView("redirect:/pdf");
		}
	}

	
/*	@RequestMapping(value = "/groupsignrender")
	public ModelAndView groupSignRender(@RequestParam("fname") String fname,RedirectAttributes attr, HttpServletRequest request) 
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

				return new ModelAndView("groupsignrender", model);

			} else {
				attr.addFlashAttribute("fileMsg", "File Not Found.");
				return new ModelAndView("redirect:/pdf");
			}
		} catch (Exception e) {
			System.out.println("file exception"+e.getMessage());
			attr.addFlashAttribute("fileMsg", e.getMessage());
			return new ModelAndView("redirect:/pdf");
		}
	}
*/	
	
	@RequestMapping(value = "/signdocument")
	public ModelAndView readfile(@RequestParam("fname") String fname,@RequestParam("token") String token,@RequestParam("email") String email,RedirectAttributes attr, HttpServletRequest request) 
	{
		logger.info(String.format("readfile(fname=%s,token=%s,email=%s)", fname,token,email));
		
		Map<String, String> model = new HashMap<String, String>();
		try {
			
			boolean flag = registerService.checkValidFile(fname,token,email);
			if(flag)
			{
				File f = new File(path + fname);
				if (f.exists()) {
					@SuppressWarnings("resource")
					RandomAccessFile raf = new RandomAccessFile(f, "r");
					FileChannel channel = raf.getChannel();
					ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0,channel.size());
					PDFFile pdf = new PDFFile(buf);
					
					model.put("numpages", "" + pdf.getNumPages());
					model.put("filename", fname);

					return new ModelAndView("readfile", model);

				} else {
					model.put("fileMsg", "File Not Found.");
					return new ModelAndView("readfile", model);
				}
			}else{
				model.put("fileMsg", "Invalid input details.");
				return new ModelAndView("readfile", model);
			}
			
			
		} catch (Exception e) {
			model.put("fileMsg", e.getMessage());
			return new ModelAndView("readfile", model);
		}
	}

	@RequestMapping(value = "/deletefile")
	public ModelAndView deletefile(@RequestParam("fname") String fname, RedirectAttributes attr, HttpServletRequest request) {

		try {
			File f = new File(path + fname);
			if (f.exists()) {
				if (f.delete()) {
					attr.addFlashAttribute("fileMsg",
							"File Deleted successfully.");
				} else {
					attr.addFlashAttribute("fileMsg", "Error in file deleting.");
				}

			} else {
				attr.addFlashAttribute("fileMsg", "File Not Found.");

			}
		} catch (Exception e) {
			attr.addFlashAttribute("fileMsg", e.getMessage());

		}

		return new ModelAndView("redirect:/pdf");
	}

	@RequestMapping(value = "/img")
	public void img(@RequestParam("fileid") String fileid,@RequestParam("filename") String fname,@RequestParam("page") String fpage, RedirectAttributes attr,HttpServletResponse response) 
	{
		logger.info(String.format("img(fileid= %s, fname = %s, fpage = %s)", fileid, fname, fpage));
		try {
			//File f = new File(path + fname);
			ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileid),fname);
			File f = ApplicationUtils.stream2file(doc.getElectronic() ==null ? doc.getOriginal() : doc.getElectronic());
			if (f.exists()) 
			{
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
				out.close();

				// return "";

			*/} else {
				logger.error("File Not Found.");
				attr.addFlashAttribute("fileMsg", "File Not Found.");
			}
			f.deleteOnExit();
		} catch (Exception e) {
			logger.error("Error while Reading file: "+e);
			attr.addFlashAttribute("fileMsg", e);
		}
	}

	
	@RequestMapping(value = "/imgselfsign")
	public void imgselfsign(@RequestParam("filename") String fname,@RequestParam("page") String fpage, RedirectAttributes attr,HttpServletResponse response) 
	{
		logger.info(String.format("imgselfsign( fname = %s, fpage = %s)", fname, fpage));
		try {
			File f = new File(path + fname);
			//ApplicationDocument doc = applicationService.readDocument(Integer.parseInt(fileid),fname);
			//File f = ApplicationUtils.stream2file(doc.getOriginal());
			if (f.exists()) {

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
				out.close();

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

	
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

}
