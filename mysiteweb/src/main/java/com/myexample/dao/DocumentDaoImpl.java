package com.myexample.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myexample.model.ApplicationDocument;
import com.myexample.model.Audit;
import com.myexample.model.Document;
import com.myexample.model.DocumentEmail;
import com.myexample.model.DocumentField;
import com.myexample.model.JsonDocumentData;
import com.myexample.utility.CommonUtils;

import org.apache.commons.lang3.StringUtils;
@Repository("documentDao")
@Transactional
public class DocumentDaoImpl implements DocumentDao{
	
	public final static String SUCCESS="success";
	public final static String FAILURE="failure";
	
	private final static Logger logger = Logger.getLogger(DocumentDaoImpl.class);
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Properties queryProps;

	/***
	 * @author Sanket.Navale
	 * Save and Update Document in DB
	 */
	@Override
	
	public String saveOrUpdateDocument(Document doc) {
		logger.info("[Start] SelfSign saveOrUpdateDocument");
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("saveOrUpdateDocumentSelfSign");

		Object[] args = new Object[] { doc.getSignType(), doc.getSubject(), doc.getMessage(), doc.getUpdatedOn(),doc.getId() };

		int out = jdbcTemplate.update(query, args);
		if (out != 0) {
			logger.info("document updated with id=" + doc.getId());
			logger.info("[End] SelfSign saveOrUpdateDocument");
			return SUCCESS;
		}
		logger.info("problem with document updated with id=" + doc.getId());
		return FAILURE;
		
	}
	
	/***
	 * @author Sanket.Navale
	 * Save Document Fields in DB
	 */
	@Override
	public String saveDocumentFields(final List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		int[] updateCnt = null;
		try {
			updateCnt = jdbcTemplate.batchUpdate(
					queryProps.getProperty("saveDocumentFieldsSelfSign"),
					new BatchPreparedStatementSetter() {
						public void setValues(PreparedStatement ps, int i) throws SQLException {
							ps.setInt(1, documentField.get(i).getUserId());
							ps.setInt(2, documentField.get(i).getDocId());
							ps.setInt(3, documentField.get(i).getPageNumber());
							ps.setInt(4, documentField.get(i).getPriority());
							ps.setFloat(5, documentField.get(i).getxPosition());
							ps.setFloat(6, documentField.get(i).getyPosition());
							ps.setFloat(7, documentField.get(i).getFieldHeight());
							ps.setFloat(8, documentField.get(i).getFieldWidth());
							ps.setString(9, documentField.get(i).getFieldValue());
							ps.setString(10, documentField.get(i).getFieldName());
							ps.setString(11, documentField.get(i).getFieldType());
							ps.setTimestamp(12, CommonUtils.currentDate());
						}

						public int getBatchSize() {
							return documentField.size();
						}
					});

		} catch (Exception e) {
			logger.info("Problem while updating document fields "+e.getMessage());
			e.printStackTrace();
		}
		if (updateCnt.length > 0) {
			logger.info("document field insertion success");
			return SUCCESS;
		}
		logger.info("document field insertion failure");
		return FAILURE;
	}
	
	/**
	 * @author Sanket.Navale
	 * Save document signer email in DB
	 * 
	 */
	@Override
	public String saveDocumentEmailData(DocumentEmail dEmail) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("saveDocumentEmailDataSelfSign");

		//JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		Object[] args = new Object[] { dEmail.getUserId(), dEmail.getDocumentId(), dEmail.getPriority(),
				dEmail.getStatus()};

		int out = jdbcTemplate.update(query, args);

		if (out != 0) {
			logger.info("document email saved with id=" + dEmail.getId());
			return SUCCESS;
		}
		logger.info("document email save failed with id=" + dEmail.getId());
		return FAILURE;
	}
	
	/***
	 * @author Sanket.Navale
	 * 
	 * Get Completed Document Data from DB 
	 * @UserId 
	 */
	@Override
	public List<JsonDocumentData> completedDocuments(int userId) {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("completedDocuments");
		
		String query1= queryProps.getProperty("completedDocumentsPriority");
		 List<JsonDocumentData> docList = new ArrayList<JsonDocumentData>();
		 
	        List<Map<String,Object>> jsonRows = jdbcTemplate.queryForList(query,new Object[] { userId });
 
	        for(Map<String,Object> jsonRow : jsonRows){
	        	JsonDocumentData doc = new JsonDocumentData();
	        	doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
	        	doc.setEnvelopeId(String.valueOf(jsonRow.get("envelopeId")));
	        	doc.setDocumentName(String.valueOf(jsonRow.get("documentName")));
	        	doc.setSubject(String.valueOf(jsonRow.get("subject")));
	        	doc.setMessage(String.valueOf(jsonRow.get("message")));
	        	doc.setSignerEmail(String.valueOf(jsonRow.get("signerEmail")));
	        	doc.setRequestedBy(String.valueOf(jsonRow.get("requestedBy")));
	        	doc.setSignedUser(String.valueOf(jsonRow.get("signedUser")));
	        	doc.setCompletedDate(String.valueOf(jsonRow.get("completedDate")==null?"":String.valueOf(jsonRow.get("completedDate"))));
	        	doc.setStatus(String.valueOf(jsonRow.get("status")));
	        	doc.setSignType(String.valueOf(jsonRow.get("signType")));
	        	
	        	docList.add(doc);
	        }
	        for(JsonDocumentData jd:docList){
	        	if(jd.getSignType().equalsIgnoreCase("G") || jd.getSignType().equalsIgnoreCase("R")){
	        		int docId=jd.getDocId();
	        		 List<String> signerNameList=new ArrayList<String>();
	        		 List<String> signerStatusList=new ArrayList<String>();  
	   	    	  	 List<String> priorityList=new ArrayList<String>();
	   	    	  	 List<String> emailCountList=new ArrayList<String>();  
	   	    	  	 List<String> emailIDList=new ArrayList<String>();   
	        		 List<Map<String,Object>> sRows = jdbcTemplate.queryForList(query1,new Object[] { docId });
	        		 int count=1;
	 	    	    for(Map<String,Object> sRow : sRows){
	 	    		   
	 	    	    	signerNameList.add(String.valueOf(sRow.get("signerName")));
	 	    	    	signerStatusList.add(String.valueOf(sRow.get("signerStatus")));
	 	    	    	
	 	    	    	
	 	    	    	String priority=String.valueOf(sRow.get("priority"));
		    	    	if(priority.equals("0")){
		    	    		count+=0;
		    	    	}
	 	    	    	
	 	    	    	priorityList.add(String.valueOf(count));
	 	    	    	count++;
	 	    	    	emailCountList.add((String.valueOf(sRow.get("emailCount"))));
	 	    	    	emailIDList.add((String.valueOf(sRow.get("signerEmailId"))));
	 	    	    
	 	    	   }
	        	  jd.setSignerName(StringUtils.join(signerNameList, ','));
	  	    	  jd.setSignerStatus(StringUtils.join(signerStatusList, ','));
	  	    	  jd.setPriority(StringUtils.join(priorityList, ','));
	  	    	  jd.setEmailCount(StringUtils.join(emailCountList, ','));
	  	    	  jd.setSignerEmailId(StringUtils.join(emailIDList, ','));
	        	}
	        }
	        
	        return docList;
		
	}

	@Override
	public List<JsonDocumentData> outForSignature(int userId) {
		// TODO Auto-generated method stub
		String sql =queryProps.getProperty("outForSignature");
		
		String sql1=queryProps.getProperty("outForSignaturePriority");
		 
		List<JsonDocumentData> docList = new ArrayList<JsonDocumentData>();
		 
	    List<Map<String,Object>> jsonRows = jdbcTemplate.queryForList(sql,new Object[] { userId });
	         
	        for(Map<String,Object> jsonRow : jsonRows){
	        	JsonDocumentData doc = new JsonDocumentData();
	        	doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
	        	doc.setEnvelopeId(String.valueOf(jsonRow.get("envelopeId")));
	        	doc.setDocumentName(String.valueOf(jsonRow.get("documentName")));
	        	doc.setSubject(String.valueOf(jsonRow.get("subject")));
	        	doc.setMessage(String.valueOf(jsonRow.get("message")));
	        	doc.setRequestedBy(String.valueOf(jsonRow.get("requestedBy")));
	        	doc.setUploadDate((String.valueOf(jsonRow.get("uploadDate"))));
	        /*	doc.setSignedUser(String.valueOf(jsonRow.get("signedUser")));
	        	doc.setCompletedDate(String.valueOf(jsonRow.get("completedDate")));*/
	        	doc.setStatus(String.valueOf(jsonRow.get("status")));
	        	doc.setSignType(String.valueOf(jsonRow.get("signType")));
	        	docList.add(doc);
	        
	        }
	        
	      for(JsonDocumentData jd:docList){
	    	  
	    	  int docId=jd.getDocId();
	    	  //System.out.println("docId: "+docId);
	    	  
	    	  List<Map<String,Object>> sRows = jdbcTemplate.queryForList(sql1,new Object[] { docId });
	    	  List<String> signerNameList=new ArrayList<String>();
	    	  List<String> signerStatusList=new ArrayList<String>();  
	    	  List<String> priorityList=new ArrayList<String>();
	    	  List<String> emailCountList=new ArrayList<String>();   
	    	  List<String> emailIDList=new ArrayList<String>(); 
	    	  int count=1;
	    	    for(Map<String,Object> sRow : sRows){
	    		   
	    	    	signerNameList.add(String.valueOf(sRow.get("signerName")));
	    	    	signerStatusList.add(String.valueOf(sRow.get("signerStatus")));
	    	    	
	    	    	String priority=String.valueOf(sRow.get("priority"));
	    	    	if(priority.equals("0")){
	    	    		count+=0;
	    	    	}
	    	    	
	    	    	priorityList.add(String.valueOf(count));
	    	    	count++;
	    	    	emailCountList.add((String.valueOf(sRow.get("emailCount"))));
	    	    	emailIDList.add((String.valueOf(sRow.get("signerEmailId"))));
	    	    
	    	   }
	    	  jd.setSignerName(StringUtils.join(signerNameList, ','));
	    	  jd.setSignerStatus(StringUtils.join(signerStatusList, ','));
	    	  jd.setPriority(StringUtils.join(priorityList, ','));
	    	  jd.setEmailCount(StringUtils.join(emailCountList, ','));
	    	  jd.setSignerEmailId(StringUtils.join(emailIDList, ','));
	      }
	        
	        return docList;
	}

	
	@Override
	public ApplicationDocument getDocument(int id) throws DaoException 
	{
		
		//logger.info(String.format("readDocument(id = %s,filename= %s)", id));
		String sql = queryProps.getProperty("getDocumentSelfSign");
		
		try{
		    		ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { id }, new ResultSetExtractor<ApplicationDocument>()
		    	    {
		    			public ApplicationDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
		    			{				
		    				if(rs.next())
		    				{
		    					ApplicationDocument doc = new ApplicationDocument();
		    					doc.setId(rs.getInt("id"));
		    		    		doc.setUserId(rs.getInt("user_id"));
		    		    		doc.setFileName(rs.getString("name"));
		    		    		doc.setOriginal(rs.getBinaryStream("original"));
		    		    		doc.setElectronic(rs.getBinaryStream("electronic"));
		    		    		doc.setDigital(rs.getBinaryStream("digital"));
		    		    		return doc;
		    		    	}
		    				return null;				
		    			}
		    		});		
		    		return document;
		    		
		 }catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public List<JsonDocumentData> getDocumentsHistory() {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("documentsHistory");
		
		String query1= queryProps.getProperty("documentsHistoryPriority");
		 List<JsonDocumentData> docList = new ArrayList<JsonDocumentData>();
		 
	        List<Map<String,Object>> jsonRows = jdbcTemplate.queryForList(query,new Object[] {});
 
	        for(Map<String,Object> jsonRow : jsonRows){
	        	JsonDocumentData doc = new JsonDocumentData();
	        	doc.setDocId(Integer.parseInt(String.valueOf(jsonRow.get("docId"))));
	        	doc.setEnvelopeId(String.valueOf(jsonRow.get("envelopeId")));
	        	doc.setDocumentName(String.valueOf(jsonRow.get("documentName")));
	        	doc.setSubject(String.valueOf(jsonRow.get("subject")));
	        	doc.setMessage(String.valueOf(jsonRow.get("message")));
	        	doc.setSignerEmail(String.valueOf(jsonRow.get("signerEmail")));
	        	doc.setRequestedBy(String.valueOf(jsonRow.get("requestedBy")));
	        	doc.setSignedUser(String.valueOf(jsonRow.get("signedUser")));
	        	doc.setCompletedDate(String.valueOf(jsonRow.get("completedDate")==null?"":String.valueOf(jsonRow.get("completedDate"))));
	        	doc.setStatus(String.valueOf(jsonRow.get("status")));
	        	doc.setSignType(String.valueOf(jsonRow.get("signType")));
	        	
	        	docList.add(doc);
	        }
	        for(JsonDocumentData jd:docList){
	        	if(jd.getSignType().equalsIgnoreCase("G") || jd.getSignType().equalsIgnoreCase("R")){
	        		int docId=jd.getDocId();
	        		 List<String> signerNameList=new ArrayList<String>();
	        		 List<String> signerStatusList=new ArrayList<String>();  
	   	    	  	 List<String> priorityList=new ArrayList<String>();
	   	    	  	 List<String> emailCountList=new ArrayList<String>();  
	   	    	  	 List<String> emailIDList=new ArrayList<String>();   
	        		 List<Map<String,Object>> sRows = jdbcTemplate.queryForList(query1,new Object[] { docId });
	        		 int count=1;
	 	    	    for(Map<String,Object> sRow : sRows){
	 	    		   
	 	    	    	signerNameList.add(String.valueOf(sRow.get("signerName")));
	 	    	    	signerStatusList.add(String.valueOf(sRow.get("signerStatus")));
	 	    	    	
	 	    	    	
	 	    	    	String priority=String.valueOf(sRow.get("priority"));
		    	    	if(priority.equals("0")){
		    	    		count+=0;
		    	    	}
	 	    	    	
	 	    	    	priorityList.add(String.valueOf(count));
	 	    	    	count++;
	 	    	    	emailCountList.add((String.valueOf(sRow.get("emailCount"))));
	 	    	    	emailIDList.add((String.valueOf(sRow.get("signerEmailId"))));
	 	    	    
	 	    	   }
	        	  jd.setSignerName(StringUtils.join(signerNameList, ','));
	  	    	  jd.setSignerStatus(StringUtils.join(signerStatusList, ','));
	  	    	  jd.setPriority(StringUtils.join(priorityList, ','));
	  	    	  jd.setEmailCount(StringUtils.join(emailCountList, ','));
	  	    	  jd.setSignerEmailId(StringUtils.join(emailIDList, ','));
	        	}
	        }
	        
	        return docList;
	}

	@Override
	public List<Audit> getWebserviceLogs() {
		// TODO Auto-generated method stub
		String query = queryProps.getProperty("webserviceLogs");
		
		List<Audit> aList = new ArrayList<Audit>();
		
		 List<Map<String,Object>> jsonRows = jdbcTemplate.queryForList(query,new Object[] {});
		 
	        for(Map<String,Object> jsonRow : jsonRows){
	        	Audit a = new Audit();
	        	a.setEmail(String.valueOf(jsonRow.get("email")));
	        	a.setMethodName(String.valueOf(jsonRow.get("methodName")));
	        	a.setIpAddress(String.valueOf(jsonRow.get("ip_address")));
	        	a.setResponseStatus(String.valueOf(jsonRow.get("status")));
	        	a.setCreated_date(String.valueOf(jsonRow.get("created_on")));
	        	a.setWebRequest(String.valueOf(jsonRow.get("webRequest")));
	        	a.setWebResponse(String.valueOf(jsonRow.get("webResponse")));
	        	
	        	aList.add(a);
	        }
		return aList;
	}



}
