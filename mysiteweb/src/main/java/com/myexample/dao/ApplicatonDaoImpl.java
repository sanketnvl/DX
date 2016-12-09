package com.myexample.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.naming.CommunicationException;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myexample.model.ApplicationDocument;
import com.myexample.model.DocumentCount;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentSign;
import com.myexample.model.DocumentSignField;
import com.myexample.model.Registration;
import com.myexample.model.ResetPassword;
import com.myexample.model.RestDocument;
import com.myexample.model.Signature;
import com.myexample.model.User;
import com.myexample.utility.ApplicationUtils;
import com.myexample.utility.CommonUtils;
import com.myexample.utility.GlobalFunctions;

@Repository("applicatonDao")
@Transactional
public class ApplicatonDaoImpl implements ApplicatonDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Properties queryProps;
	
	@Autowired
	private DataSource dataSource;

	private final static Logger logger = Logger.getLogger(RegistrationDaoImpl.class);
	String className = this.getClass().getSimpleName();
	
	@Override
	public String insertDocument(final int userid,final String envelopeId, final String filename, final InputStream inputStream,final int status, final String type,final String signType, final String ipAddress) throws DaoException 
	{
		String classMethod = className+ ":  insertDocument" ;
		logger.info(String.format("Enter into "+classMethod+"(userid = %s,filename= %s, inputStream = %s, status = %s, type = %s, signType = %s, ipAddress = %s)", userid, filename, inputStream, status, type, signType, ipAddress));
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try{
		
		final String sql = queryProps.getProperty("insertDocumentApp");
		
		final int length = inputStream.available();
			jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	            PreparedStatement pst =con.prepareStatement(sql, new String[] {"id"});
	            int index = 1;
	            pst.setInt(index++,userid);
	            pst.setString(index++, envelopeId);
	            pst.setString(index++,filename);
	            pst.setBinaryStream(index++,inputStream,length );
	            pst.setInt(index++, status);
	            pst.setString(index++, type);
	            pst.setString(index++, signType);
	            pst.setTimestamp(index++, CommonUtils.currentDate());
	            pst.setString(index++, ipAddress);
	            return pst;
	        }
	    },
	    keyHolder);
		logger.info("exit from "+classMethod);
		return  keyHolder.getKey().toString();
	
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
		
		
		
	}
	
	@Override
	public ApplicationDocument readDocument(int id, String filename) throws DaoException 
	{
		String classMethod = className+ ":  readDocument" ;
		logger.info(String.format("Enter into "+classMethod+"(id = %s,filename= %s)", id, filename));
		String sql = queryProps.getProperty("getReadDocumentApp");
		
		try{
		    		ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { id,filename }, new ResultSetExtractor<ApplicationDocument>()
		    	    {
		    			public ApplicationDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
		    			{				
		    				if(rs.next())
		    				{
		    					ApplicationDocument doc = new ApplicationDocument();
		    					doc.setId(rs.getInt("id"));
		    		    		doc.setUserId(rs.getInt("user_id"));
		    		    		doc.setEnvelopeId(rs.getString("envelopeid"));
		    		    		doc.setFileName(rs.getString("name"));
		    		    		doc.setOriginal(rs.getBinaryStream("original"));
		    		    		doc.setElectronic(rs.getBinaryStream("electronic"));
		    		    		doc.setDigital(rs.getBinaryStream("digital"));
		    		    		return doc;
		    		    	}
		    				return null;				
		    			}
		    		});
		    		logger.info("exit from "+classMethod);
		    		return document;
		    		
		 }catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public String createGroupSignDao(DocumentSign documentSign,String signatureid) 
	{
		String classMethod = className+ ":  createGroupSignDao" ;
		logger.info(String.format("Enter into "+classMethod+" (documentSign = %s)", documentSign));
		
		int status = 0;
		int signerId;
		String msg = "success";
		Set<Integer> uqiqueSignerId = new HashSet<Integer>();
		String documentSignInsertSql =queryProps.getProperty("documentSignInsert-SqlCreateGroupSign");
		String userSelectSql =queryProps.getProperty("userSelectSql-SqlCreateGroupSign");
		final String userInsertSql =queryProps.getProperty("userInsertSql-SqlCreateGroupSign");
		String documentSignFieldInsertSql = queryProps.getProperty("documentSignFieldInsertSql-SqlCreateGroupSign");
		String documentSignEmailInsertSql = queryProps.getProperty("documentSignEmailInsertSql-SqlCreateGroupSign");
		
		if(documentSign != null)
		{
			try{
				
			
				//start insert document_sign
				status = jdbcTemplate.update(documentSignInsertSql,documentSign.getTitle(),documentSign.getMessage(),documentSign.getDocumentId());
				if(status ==1)
				{
					for(final DocumentSignField documentSignField: documentSign.getDocumentSignField())
					{	
						KeyHolder keyHolder = new GeneratedKeyHolder();
						List<Integer> ids = jdbcTemplate.queryForList(userSelectSql, Integer.class,documentSignField.getSignerEmail()); 
					    if (!ids.isEmpty()) {
					    	signerId = ids.get(0);
					    }else{
					    	
					    	jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
					            PreparedStatement pst =con.prepareStatement(userInsertSql, new String[] {"id"});
					            int index = 1;
					            pst.setString(index++,documentSignField.getSignerName());
					            pst.setString(index++,documentSignField.getSignerEmail());
					            pst.setInt(index++, 0);
					            pst.setInt(index++, 0);
					            pst.setTimestamp(index++, CommonUtils.currentDate());
					            return pst;
					        }
					    },
					    keyHolder);
						
					    	signerId = Integer.parseInt(keyHolder.getKey().toString());
					    	
					    }
					    
					    //start insert document_sign_field
					    if(signerId != 0)
					    {
					    	if(documentSignField.getPriority().equals("0") && documentSignField.getFieldtype().equals("image") && !signatureid.isEmpty())
					    	{
					    		jdbcTemplate.update(documentSignFieldInsertSql,signerId,documentSign.getDocumentId(),documentSignField.getPageNumber(),documentSignField.getPriority(),documentSignField.getLeft().replaceAll("px", ""),documentSignField.getTop().replaceAll("px", ""),documentSignField.getHeight(),documentSignField.getWidth(),signatureid,documentSignField.getFieldName(),documentSignField.getFieldtype(),CommonUtils.currentDate());
				    		}else if(documentSignField.getPriority().equals("0") && documentSignField.getFieldtype().equals("image") && signatureid.isEmpty())
					    	{
					    		int signId = insertSign(documentSign.getOriginatorId(),documentSignField.getFieldValue());
					    		jdbcTemplate.update(documentSignFieldInsertSql,signerId,documentSign.getDocumentId(),documentSignField.getPageNumber(),documentSignField.getPriority(),documentSignField.getLeft().replaceAll("px", ""),documentSignField.getTop().replaceAll("px", ""),documentSignField.getHeight(),documentSignField.getWidth(),String.valueOf(signId),documentSignField.getFieldName(),documentSignField.getFieldtype(),CommonUtils.currentDate());
				    		}
					    	else
					    	{
				    			jdbcTemplate.update(documentSignFieldInsertSql,signerId,documentSign.getDocumentId(),documentSignField.getPageNumber(),documentSignField.getPriority(),documentSignField.getLeft().replaceAll("px", ""),documentSignField.getTop().replaceAll("px", ""),documentSignField.getHeight(),documentSignField.getWidth(),documentSignField.getFieldValue(),documentSignField.getFieldName(),documentSignField.getFieldtype(),CommonUtils.currentDate());
				    		}
					    	
					    	
					    	//start insert document_sign_email
					    	if(uqiqueSignerId.add(signerId))
					    	{	
					    		int mailCount = 0;
					    		int signstatus =0;
					    		if(documentSignField.getPriority().equals("0")){
					    			signstatus = 1;
					    		}
					    		if(documentSignField.getPriority().equals("1"))
					    		{
					    			mailCount = 1;
					    		}
					    		
					    		jdbcTemplate.update(documentSignEmailInsertSql,signerId,documentSign.getDocumentId(),documentSignField.getPriority(),mailCount,new GlobalFunctions().uniqueToken(),signstatus,CommonUtils.currentDate());
					    	}
					    	//end insert document_sign_email
					    }
					    //end insert document_sign_field
					}
				}
			//end insert document_sign
			}catch(Exception e){
				msg = e.getMessage();
			}
		}else{
			msg = "error";
		}
		logger.info("exit from "+classMethod);
		return msg;
	}

	
	@Override
	public String getTokenOfDocumentSignEmailDao(int documentId, String email) 
	{
		String classMethod = className+ ":  getTokenOfDocumentSignEmailDao" ;
		logger.info(String.format("Enter into "+classMethod+"(documentId = %s, email = %s)", documentId,email));
		String token = null;
		String sql = queryProps.getProperty("getTokenOfDocumentSignEmail");
		try{
			token = jdbcTemplate.queryForObject(sql, String.class, documentId,email);
		}catch(Exception e){
			logger.error("Error while getting token of document_sign_email: "+e);
		}
		
		logger.info("exit from "+classMethod);
		return token;
	}

	@Override
	public List<DocumentField> getApplicationDao(String documentName,String fileid, String signeremail) throws DaoException 
	{
		String classMethod = className+ ":  getApplicationDao" ;
		logger.info(String.format("Enter into "+classMethod+"(documentName=%s,fileid = %s, signeremail = %s)", documentName,fileid,signeremail));
		
		//String query_partyId = "select f.id,f.form_field_name,f.form_field_type,f.pageno,f.y_position,f.x_position,f.height,f.width from tb_document_details as doc INNER JOIN documents_fields As f  on doc.id=f.document_id where document_name =?";
		String sql = queryProps.getProperty("getApplicationApp");     
		List<DocumentField> dfList = new ArrayList<DocumentField>();
		try{ 
        List<Map<String,Object>> dfRows = jdbcTemplate.queryForList(sql,new Object[]{signeremail,fileid});
         
        for(Map<String,Object> df : dfRows){
        	DocumentField fields = new DocumentField();
        	
        	fields.setId((Integer.parseInt((String.valueOf(df.get("id"))))));
        	fields.setFieldName(String.valueOf(df.get("field_name")));
        	if(df.get("field_value") != null || df.get("field_value") != ""){
        		fields.setFieldValue(String.valueOf(df.get("field_value")));
        	}
        	fields.setFieldType(String.valueOf(df.get("field_type")));
        	fields.setPageNumber(Integer.parseInt((String.valueOf(df.get("page_number")))));
        	fields.setFieldWidth(Float.parseFloat((String.valueOf(df.get("width")))));
        	fields.setFieldHeight(Float.parseFloat((String.valueOf(df.get("height")))));
        	fields.setxPosition(Float.parseFloat((String.valueOf(df.get("position_left")))));
        	fields.setyPosition(Float.parseFloat((String.valueOf(df.get("position_top")))));
        	dfList.add(fields);

        }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		logger.info("exit from "+classMethod);
        return dfList;
	
	}

	@Override
	public boolean checkValidFileDao(String fileid, String fname, String token,String email) throws DaoException 
	{
		String classMethod = className+ ":  checkValidFileDao" ;
		logger.info(String.format("Enter into "+classMethod+"(fileid = %s, fname = %s, token = %s, email = %s)", fileid,fname,token,email));
		boolean flag = false;
		//String sql = "select tsd.id from tb_signing_details tsd JOIN tb_client_user tcu1 ON tcu1.id=tsd.originator_id JOIN tb_client_user tcu2  ON tcu2.id=tsd.signer_id JOIN tb_document_details tdd ON tdd.id=tsd.document_id WHERE tdd.document_name = ? and tcu1.email = ? and tcu2.email = ? and tsd.token = ? and tsd.status = ?";
		String sql = queryProps.getProperty("checkValidFileApp");
		List<Integer> ids = null;
		try{
		ids = jdbcTemplate.queryForList(sql, Integer.class, email,fileid,token);
		if(ids.get(0) > 0)
		{
			flag = true;
		}
		}catch(Exception e){
			flag = false;
			throw new DaoException(e.getMessage());
		}
		logger.info("exit from "+classMethod);
		return flag;
	}

	@Override
	public Map<String, Object> saveAppDocumentFields(final List<DocumentField> documentField, String signerEmail, String fileId, String token, String fName) throws DaoException 
	{
		String classMethod = className+ ":  saveAppDocumentFields" ;
		logger.info(String.format("Enter into "+classMethod+"(documentField = %s,signerEmail= %s, fileId = %s, token = %s )", documentField,signerEmail,fileId,token));
		int priority = 0;
		List<Integer> priorityList = null;
		List<String> originator = null;
		List<String> nextSigner = null;
		Map<String, Object> users = new HashMap<String,Object>();
		String checkValidSql = queryProps.getProperty("checkValidSql-saveAppDocumentFields");
		String updateDocumentSignEmailSql = queryProps.getProperty("updateDocumentSignEmailSql-saveAppDocumentFields");
		String OriginatorSql = queryProps.getProperty("OriginatorSql-saveAppDocumentFields");
		String nextSignerSql = queryProps.getProperty("nextSignerSql-saveAppDocumentFields");
		String documentSignSql = queryProps.getProperty("documentSignSql-saveAppDocumentFields");
		try{ 
				//check valid parameters for update status of document_sign_email
				priorityList = jdbcTemplate.queryForList(checkValidSql,Integer.class, signerEmail, fileId,token,0);
				priority = priorityList.get(0);
				if(priority > 0)
				{
						jdbcTemplate.batchUpdate(queryProps.getProperty("batchupdate-saveAppDocumentFields"),new BatchPreparedStatementSetter() {
		                    public void setValues(PreparedStatement ps, int i) throws SQLException {
		                    	ps.setString(1,documentField.get(i).getFieldValue());
		                        ps.setInt(2,documentField.get(i).getId());
		                    }
		                    public int getBatchSize() {
		                        return documentField.size();
		                    }
		               });
					
					
					
					//get signer details
					users.put("signer",getSigner(signerEmail));

					
					//get originator details
					originator = jdbcTemplate.queryForList(OriginatorSql,String.class,fileId);
					users.put("originator", originator.isEmpty() ? null: getUser(originator.get(0)));

					
					//get next signer details
					nextSigner = jdbcTemplate.queryForList(nextSignerSql,String.class,fileId,priority+1);
					users.put("nextSigner", nextSigner.isEmpty() ? null: getSigner(nextSigner.get(0)));
					users.put("priority", priority);
					
					//get document_sign details
					DocumentSign documentSign = jdbcTemplate.query(documentSignSql, new Object[] { fileId }, new ResultSetExtractor<DocumentSign>()
					{
								public DocumentSign extractData(ResultSet rs) throws SQLException,DataAccessException 
								{				
									if(rs.next()){
										DocumentSign ds = new DocumentSign();
							    		ds.setTitle(rs.getString(1));
							    		ds.setMessage(rs.getString(2));
							    		return ds;
							    		}
									return null;				
								}
					});		
					users.put("documentSign", documentSign);
					
					//get document
					ApplicationDocument document = readDocument(Integer.parseInt(fileId),fName);
					users.put("document", document);
					
					jdbcTemplate.update(updateDocumentSignEmailSql,1,token);
				}
						
				
		
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		logger.info("exit from "+classMethod);
		return users;
		
	}

	@Override
	public int saveModifiedDocumentDao(String fileId, InputStream modifiedFile, boolean digital) 
	{
		String classMethod = className+ ":  saveModifiedDocumentDao" ;
		logger.info(String.format("Enter into "+classMethod+"(fileId = %s, modifiedFile = %s, digital = %s)", fileId,modifiedFile,digital));
		String sql =queryProps.getProperty("saveModifiedDocumentElectronicApp");
		if(digital){
			sql = queryProps.getProperty("saveModifiedDocumentDigitalApp");
		}
		PreparedStatement ps = null;
		Connection con = null;
		int out=0;
		try{
		//int i = jdbcTemplate.update(sql, modifiedFile, fileId);
		int length;
		
			length = modifiedFile.available();
			con = dataSource.getConnection();
			ps = con.prepareStatement(sql);
			ps.setBinaryStream(1, modifiedFile,length);
			ps.setInt(2, Integer.parseInt(fileId));
			out = ps.executeUpdate();
			if(out !=0){
				System.out.println("Document updated with id="+fileId);
			}else
				System.out.println("No Document found with id="+fileId);
			
		}catch(SQLException | IOException e){
			e.printStackTrace();
		}finally{
			try {
				ps.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		logger.info("exit from "+classMethod);
		return out;
	}

	

	public Registration getUser(String userName) throws DaoException 
	{
		String classMethod = className+ ":  getUser" ;
		logger.info(String.format("Enter into "+classMethod+"(userName = %s)", userName));	    
		String sql =queryProps.getProperty("getUserApp");
	    
		try{
	    Registration user = jdbcTemplate.query(sql, new Object[] { userName }, new ResultSetExtractor<Registration>()
	    {
			public Registration extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				Registration r = new Registration();
				if(rs.next()){
		    		r.setId(rs.getInt("id"));
		    		r.setFirstName(rs.getString("firstname"));
		    		r.setLastname(rs.getString("lastname"));
		    		r.setPhoto(rs.getString("photo"));
		    		r.setEmail(rs.getString("email"));
		    		r.setPhone(rs.getString("phone"));
		    		r.setCountry(rs.getString("country"));
		    		r.setState(rs.getString("state"));
		    		r.setPincode(rs.getString("pincode"));
		    		r.setPassword(rs.getString("password"));
		    		r.setCompanyName(rs.getString("company_name"));
		    		r.setJobTitle(rs.getString("job_title"));
		    		r.setClientId(rs.getString("client_id"));
		    		r.setClientSecret(rs.getString("client_secret"));
		    		r.setEmail_verification_token(rs.getString("email_verification_token"));
		    		r.setUser_type(rs.getInt("user_type"));
		    		
		    		r.setStatus(rs.getInt("status"));
		    		r.setRole(rs.getString("role"));
		    		r.setIsCompany(rs.getString("is_company"));
		    		r.setDate(rs.getDate("created_on"));
		    		r.setUpdatedOn(rs.getDate("updated_on"));
		    		return r;
		    		}
				return r;				
			}
		});	
	    logger.info("exit from "+classMethod);
		return (Registration) user;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}

	public Registration getSigner(String userName) throws DaoException 
	{
		String classMethod = className+ ":  getUser" ;
		logger.info(String.format("Enter into "+classMethod+"(userName = %s)", userName));	    
		String sql = queryProps.getProperty("getSignerApp");
	    
		try{
	    Registration user = jdbcTemplate.query(sql, new Object[] { userName }, new ResultSetExtractor<Registration>()
	    {
			public Registration extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				Registration r = new Registration();
				if(rs.next()){
		    		r.setId(rs.getInt("id"));
		    		r.setFirstName(rs.getString("name"));
		    		r.setEmail(rs.getString("email"));
		    		r.setUser_type(rs.getInt("user_type"));
		    		r.setStatus(rs.getInt("status"));
		    		r.setDate(rs.getDate("created_on"));
		    		r.setUpdatedOn(rs.getDate("updated_on"));
		    		return r;
		    		}
				return r;				
			}
		});	
	    logger.info("exit from "+classMethod);
		return (Registration) user;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}
	
	
	@Override
	public int deleteDocumentDao(int id) {
		
		return jdbcTemplate.update(queryProps.getProperty("deleteDocumentApp"), id);
	}

	@Override
	public String changePasswordDao(String oldpassword, String newpassword,String email) 
	{
		String classMethod = className+ ":  changePasswordDao" ;
		logger.info(String.format("Enter into "+classMethod+"(oldpasword = %s ,newpassword = %s, email = %s)", oldpassword, newpassword, email));
		String status = "";
		BCryptPasswordEncoder encrypt =new BCryptPasswordEncoder();
		Registration user;
		try {
			user = getUser(email);
			if(encrypt.matches(oldpassword, user.getPassword()))
			{
				String sql =queryProps.getProperty("changePasswordApp");
				List<Integer> ids = jdbcTemplate.queryForList(sql,Integer.class,email);
				if(ids.get(0)> 0 ){
					
					jdbcTemplate.update(queryProps.getProperty("updateChangePasswordApp"), newpassword, ids.get(0));
					status = "success";
				}else{
					status = "error";
				}
			}else{
				status = "error";
			}
		} catch (DaoException e) {
			logger.error("Error while getting user detail: "+e);
			e.printStackTrace();
		}
		
		
		
		 logger.info("exit from "+classMethod);
		return status;
	}

	@Override
	public boolean changePhotoDao(int loginuserid, String fileName) 
	{
		String classMethod = className+ ":  changePhotoDao" ;
		logger.info(String.format("Enter into "+classMethod+"(loginuserid = %s ,fileName = %s)", loginuserid, fileName));
		boolean status = false;
		if(jdbcTemplate.update(queryProps.getProperty("changePhotoApp"),fileName,loginuserid) == 1){
			status = true;
		}
		logger.info("exit from "+classMethod);	
		return status;
	}

	@Override
	public String forgotPasswordDao(String email, String token) 
	{
		String classMethod = className+ ":  forgotPasswordDao" ;
		logger.info(String.format("Enter into "+classMethod+"(email = %s ,token = %s)", email, token));
		String status = "error";
		String sql = queryProps.getProperty("forgotPasswordApp");
		List<Integer> ids = jdbcTemplate.queryForList(sql,Integer.class,email);
		if(ids.size() !=0 && ids.get(0)> 0 ){
			jdbcTemplate.update(queryProps.getProperty("addForgotPasswordApp"), ids.get(0), token,0,CommonUtils.currentDate());
			status = Integer.toString(ids.get(0));
		}else{
			status = "error";
		}
		logger.info("exit from "+classMethod);
		return status;
	}

	@Override
	public List<Signature> getUserSignaturesDao(int id) 
	{
		String classMethod = className+ ":  getUserSignaturesDao" ;
		logger.info(String.format("enter into "+classMethod+"(id = %s)", id));
		//List<Signature> signatures = new ArrayList<Signature>();
		String sql = "select id,signature_data,created_date from signature where user_id= "+id+" order by created_date desc ";
		//signatures = jdbcTemplate.queryForList(sql,Signature.class,id);
		
		List<Signature> signatures =  jdbcTemplate.query(sql,new RowMapper<Signature>(){  
		    @Override  
		    public Signature mapRow(ResultSet rs, int rownumber) throws SQLException {  
		    	Signature e=new Signature();  
		        e.setId(rs.getInt(1));  
		        e.setSign(rs.getString(2));  
		        e.setDate(rs.getString(3));  
		        return e;  
		    }  
		    });  
		  
		
		
		logger.info("exit from "+classMethod);
		return signatures;
	}

	@Override
	public int resetPasswordDao(ResetPassword resetPassword) 
	{
		String 	password = ApplicationUtils.encryptPassword(resetPassword.getPassword());
		String classMethod = className+ ":  resetPasswordDao" ;
		logger.info(String.format("enter into "+classMethod+"(resetPassword = %s)", password));
		String sql = queryProps.getProperty("resetPasswordUserApp");
		String sql1 = queryProps.getProperty("resetPasswordUserForgotApp");
		int status = jdbcTemplate.update(sql,password,resetPassword.getUserid(),resetPassword.getToken());
		
		int status1 = jdbcTemplate.update(sql1,resetPassword.getUserid(),resetPassword.getToken());
		
		logger.info("exit from "+classMethod);
		return status;
	}	


	public DocumentCount getDocumentCountDao(int userId) throws DaoException 
	{
		String classMethod = className+ ":  getDocumentCountDao" ;
		logger.info(String.format("enter into "+classMethod+"(userId = %s)", userId));
		String sql = queryProps.getProperty("documentCountApp");
		
		try{
			DocumentCount user = jdbcTemplate.query(sql, new Object[] { userId }, new ResultSetExtractor<DocumentCount>()
		    {
				public DocumentCount extractData(ResultSet rs) throws SQLException,DataAccessException 
				{				
					DocumentCount r = new DocumentCount();
					if(rs.next()){
			    		
			    		r.setTotal(rs.getInt("total"));
			    		r.setComplete(rs.getInt("complete"));
			    		r.setUncomplete(rs.getInt("incomplete"));

			    		return r;
			    		}
					return r;				
				}
			});	
		    logger.info("exit from "+classMethod);
			return user;
			
			}catch(Exception e ){
				throw new DaoException(e.getMessage());
			}

	}

	@Override
	public String updateProfileDao(Registration registration) 
	{
		String classMethod = className+ ":  updateProfileDao" ;
		logger.info(String.format("enter into "+classMethod+"(registration = %s)", registration));
		
		String sql = queryProps.getProperty("updateProfileApp");
		
		int status = jdbcTemplate.update(sql,registration.getFirstName(),registration.getLastname(),registration.getPhone(), registration.getCountry(), registration.getState(), registration.getPincode(),registration.getId());

		logger.info("exit from "+classMethod);
		return ""+status;
	}

	@Override
	public RestDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException 
	{
		String classMethod = className+ ":  getDocumentByEnvelopeId" ;
		logger.info(String.format("Enter into "+classMethod+"(envelopeId = %s)", envelopeId));	    
		String sql = queryProps.getProperty("getDocumentByEnvelopeId");
	    
		try{
			RestDocument restDocument = jdbcTemplate.query(sql, new Object[] { envelopeId }, new ResultSetExtractor<RestDocument>()
	    {
			public RestDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				RestDocument r = new RestDocument();
				if(rs.next()){
		    		r.setId(rs.getInt("id"));
		    		r.setDocumentName(rs.getString("name"));		    		
		    		return r;
		    		}
				return r;				
			}
		});	
	    logger.info("exit from "+classMethod);
		return (RestDocument) restDocument;
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
	}

	@Override
	public int deletesignature(String signId) 
	{
		
		return jdbcTemplate.update(queryProps.getProperty("deleteSignatureApp"),signId);
	}

	
	public int insertSign(final int userId, final String sign)
	{
		int signerId;
		String selectSql = queryProps.getProperty("getInsertSignApp");
		KeyHolder keyHolder = new GeneratedKeyHolder();
		 logger.info("sign "+sign);
		List<Integer> ids = jdbcTemplate.queryForList(selectSql,Integer.class, userId,sign);
		if(ids.size()>0){
				signerId = ids.get(0);
		}else{
				final String insertSql = queryProps.getProperty("addInsertSignApp");
				jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
		            PreparedStatement pst =con.prepareStatement(insertSql, new String[] {"id"});
		            int index = 1;
		            pst.setString(index++,userId+"");
		            pst.setString(index++,sign);
		            pst.setTimestamp(index++,CommonUtils.currentDate());
		            return pst;
		        }
		    },
		    keyHolder);
			signerId = Integer.parseInt(keyHolder.getKey().toString());
		}
    	
		return signerId;
	}
	
	@Override
	public int saveSignature(int id, String dataURL) 
	{
		
		return insertSign(id,dataURL);
	}

	@Override
	public int deleteProfilePic(int id) 
	{
		String sql = queryProps.getProperty("deleteProfilePicApp");
		int status = jdbcTemplate.update(sql,id);
		return status;
	}
	
	

	@Override
	public String increaseReminderEmailCount(int count, int docId,String signerEmail) 
	{
		String sql = queryProps.getProperty("increaseReminderEmailCount");
		//String sql = "update document_sign_email dse join signer s ON dse.signer_id = s.id set dse.sent_email_count= ? where dse.document_id = ? and s.email = ? ";
		int status = jdbcTemplate.update(sql,count,docId,signerEmail);
		return status+"";
	}

	@Override
	public String checkValidResetPassword(ResetPassword resetPassword) 
	{
		String flag = "0";
		String checkValidResetPassword = queryProps.getProperty("checkValidResetPassword");
		List<Integer> ids = jdbcTemplate.queryForList(checkValidResetPassword,Integer.class, resetPassword.getUserid(),resetPassword.getToken());
		if(ids.size()>0){
				flag = "1";
		}
		return flag;
	}

	@Override
	public List<User> getUnRegisteredUsers() throws DaoException 
	{
		logger.info(String.format("getUnRegisteredUsers()"));
		
		String query = queryProps.getProperty("getUnRegisteredUsers");
		     
		List<User> usersList = new ArrayList<User>();
		try{ 
        List<Map<String,Object>> dfRows = jdbcTemplate.queryForList(query);
         
        for(Map<String,Object> df : dfRows){
        	User user = new User();
        	user.setName(((String.valueOf(df.get("name")))));
        	user.setEmail(String.valueOf(df.get("email")));
        	
        	usersList.add(user);
        }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		
		return usersList;
	}
}
