package com.myexample.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.myexample.dao.DaoException;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.JsonDocumentData;
import com.myexample.model.Registration;
import com.myexample.service.DocumentService;
import com.myexample.utility.GlobalFunctions;
import com.myexample.utility.UtilityException;

@Controller
@RequestMapping("/app")

/***
 * 
 * @author Sanket.Navale
 *
 */
public class DocumentController {
	private static final Logger logger = Logger.getLogger(DocumentController.class);
	private static String TEMP_DIGITAL_URL, APP_DIGITAL_DOCS = null;
	@Autowired
	private DocumentService documentService;

	DocumentController() {
		GlobalFunctions globalfunctions = new GlobalFunctions();
		try {
			TEMP_DIGITAL_URL = globalfunctions.getDigitalSignatureFilePath();
			APP_DIGITAL_DOCS = globalfunctions.getAppDigitalSignPdfPath();
			logger.info(String.format("SelfsignController(PATH = %s , )", TEMP_DIGITAL_URL));

		} catch (UtilityException e) {
			logger.error(e);
		}
	}

	/**
	 * @author Sanket.Navale Render OutForSignature Data
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/outforSignature", method = RequestMethod.GET)
	public ModelAndView outforSignature() throws JsonGenerationException, JsonMappingException, IOException {
		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = String.valueOf(user.getId());

		List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
		jsonDocList = documentService.outForSignature(userId == null ? 0 : Integer.parseInt(userId));
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> model = new HashMap<String, String>();
		logger.info("OutForSignature Data " + mapper.writeValueAsString(jsonDocList));
		model.put("list", mapper.writeValueAsString(jsonDocList));
		return new ModelAndView("outforSignature", model);
	}

	/***
	 * @author Sanket.Navale Render Completed Documents Data
	 * @return
	 * @throws JsonGenerationException
	 * @throws JsonMappingException
	 * @throws IOException
	 */
	@RequestMapping(value = "/completedDocuments", method = RequestMethod.GET)
	public ModelAndView completedDocuments() throws JsonGenerationException, JsonMappingException, IOException {
		Registration user = (Registration) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userId = String.valueOf(user.getId());

		List<JsonDocumentData> jsonDocList = new ArrayList<JsonDocumentData>();
		jsonDocList = documentService.completedDocuments(userId == null ? 0 : Integer.parseInt(userId));
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> model = new HashMap<String, String>();
		logger.info("CompletedDocuments Data " + mapper.writeValueAsString(jsonDocList));
		model.put("list", mapper.writeValueAsString(jsonDocList));
		return new ModelAndView("completedDocuments", model);
	}

	/**
	 * @author Sanket.Navale view and download a file from - inside project,
	 *         located in resources folder. - outside project, located in File
	 *         system somewhere.
	 * @param response
	 * @param type
	 * @throws IOException
	 * @throws DaoException
	 * @throws NumberFormatException
	 */
	@RequestMapping(value = "/downloadFiles/{type}", method = RequestMethod.GET)
	public @ResponseBody void downloadFiles(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type) throws IOException, NumberFormatException, DaoException {
		String docId = request.getParameter("docId");
		ApplicationDocument document = documentService.getDocument(Integer.parseInt(docId));

		InputStream is = document.getDigital();
		try {
			FileOutputStream fos = new FileOutputStream(APP_DIGITAL_DOCS + document.getFileName());
			int b = 0;
			while ((b = is.read()) != -1) {
				fos.write(b);
			}
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			is.close();
		}
		String json = new Gson().toJson(document.getFileName());
		response.setContentType("application/json");
		try {
			response.getWriter().write(json);
		} catch (IOException e2) {
			logger.error("Error while write json to response : " + e2.getMessage());
		}

	}

	/**
	 * @author Sanket.Navale view and download a file from - inside project,
	 *         located in resources folder. - outside project, located in File
	 *         system somewhere.
	 * @param response
	 * @param type
	 * @throws IOException
	 */
	@RequestMapping(value = "/download/{type}", method = RequestMethod.GET)
	public @ResponseBody void downloadFile(HttpServletRequest request, HttpServletResponse response,
			@PathVariable("type") String type) throws IOException {

		File file = null;
		String fileName = request.getParameter("fileName");
		file = new File(APP_DIGITAL_DOCS + fileName);
		if (!file.exists()) {
			String errorMessage = "Sorry. The file you are looking for does not exist";
			// System.out.println(errorMessage);
			OutputStream outputStream = response.getOutputStream();
			outputStream.write(errorMessage.getBytes(Charset.forName("UTF-8")));
			outputStream.close();
			return;
		}

		String mimeType = URLConnection.guessContentTypeFromName(file.getName());
		if (mimeType == null) {
			// System.out.println("mimetype is not detectable, will take
			// default");
			mimeType = "application/octet-stream";
		}
		// System.out.println("mimetype : " + mimeType);
		response.setContentType(mimeType);
		if (type.equalsIgnoreCase("internal")) {
			response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() + "\""));
		} else {
			response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
		}
		response.setContentLength((int) file.length());
		InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
		// Copy bytes from source to destination(outputstream in this example),
		// closes both streams.
		FileCopyUtils.copy(inputStream, response.getOutputStream());
	}

}
