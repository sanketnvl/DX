package com.myexample.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

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
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myexample.model.ApplicationDocument;
import com.myexample.model.ClientAuth;
import com.myexample.model.ClientUser;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentSignField;
import com.myexample.model.DocumentWrapper;
import com.myexample.model.Registration;
import com.myexample.model.RestDocument;
import com.myexample.model.RestDocumentField;
import com.myexample.model.VerifyDetails;
import com.myexample.utility.CommonUtils;
import com.myexample.utility.DateManipulation;
import com.myexample.utility.GlobalFunctions;

@Repository("jerseyDao")
@Transactional
public class JerseyDaoImpl implements JerseyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	String className = this.getClass().getSimpleName();
	

	@Autowired
	private Properties queryProps;
	
	@Autowired
	private DataSource dataSource;
	
	
	private final static Logger logger = Logger.getLogger(JerseyDaoImpl.class);
/*	public JdbcTemplate getJdbcTemplate() {
	    return jdbcTemplate;
	}
	
	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
	    this.jdbcTemplate = jdbcTemplate;
	}*/
	
	public String addUserJersey(ClientUser clientUser) throws DaoException
	{
		logger.info(String.format("addUserJersey(ClientUser = %s)", clientUser));
		String sql = queryProps.getProperty("getStatusUserJersey");
		String msg;
		
		try{
		    List<Integer> status = jdbcTemplate.queryForList(sql, Integer.class,  clientUser.getClient().getClientId(), clientUser.getClient().getClientEmail(), clientUser.getClient().getClientPassword()); 
		    if (status.isEmpty()) {
		        msg = "Client Authenticaton Invalid.";
		        logger.error(msg);
		    } 
		    else if(status.get(0) == 1 ) 
		    {
		    	
		    	List<Integer> ids = jdbcTemplate.queryForList(queryProps.getProperty("getIdUserJersey"), Integer.class,clientUser.getEmail());
		    	
		    	if(ids.isEmpty()){
		    		jdbcTemplate.update(queryProps.getProperty("addUserJersey"),clientUser.getClient().getClientId(),clientUser.getEmail(),clientUser.getPassword(),"token",1,new DateManipulation().getMyDate());
		    		msg =  "User added successfully.";
		    	}
		    	else
		    	{
		    		msg =  "User already exist.";
		    	}
		    
		    }
		    else{
		    	msg = "Client not verified, Please verify your account";
		    }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		
		return msg;
	}

	public List<ClientUser> getAllClientUserDao(ClientAuth clientAuth) throws DaoException
	{
		logger.error(String.format("clientAuth = %s", clientAuth));
		String sql = queryProps.getProperty("getAllClientUser");
		String msg;
		List<ClientUser> clientUser = null;
		try{
		    List<Integer> status = jdbcTemplate.queryForList(sql, Integer.class,  clientAuth.getClientId(), clientAuth.getClientEmail(), clientAuth.getClientPassword()); 
		    if (status.isEmpty()) {
		        msg = "Client Authenticaton Invalid.";
		    }else{
		    	
		    	clientUser = jdbcTemplate.query("select * from tb_client_user where client_id = "+clientAuth.getClientId(),new RowMapper<ClientUser>(){  
					public ClientUser mapRow(ResultSet rs, int count)throws SQLException {
						ClientUser clientUser = new ClientUser();
						clientUser.setId(rs.getInt(1));
						clientUser.setEmail(rs.getString(3));
						clientUser.setPassword(rs.getString(4));
						clientUser.setToken(rs.getString(5));
						clientUser.setStatus(rs.getInt(6));
						clientUser.setDateTime(rs.getDate(7));
						
					
						return clientUser;
					}  
		    	    }); 
		    	
		    	
		    }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
			return clientUser;
	}

	public String addDocumentDao(DocumentWrapper documentWrapper) throws DaoException
	{ 
		logger.info(String.format("documentWrapper = %s", documentWrapper));
		
		
		String sql = queryProps.getProperty("getStatusDocumentWebservice");
		String msg=null;
		String uniqueID = new GlobalFunctions().uniqueToken();
		
		try{
		List<Integer> status = jdbcTemplate.queryForList(sql, Integer.class, documentWrapper.getClientAuth().getClientId(),documentWrapper.getClientAuth().getClientEmail(),documentWrapper.getClientAuth().getClientPassword() ); 
	    if (status.isEmpty()) 
	    {
	        msg = "Client Authenticaton Invalid.";
	    }
	    else
	    {
	    	
	    	List<Integer> ids = jdbcTemplate.queryForList(queryProps.getProperty("getIdDocumentWebservice"), Integer.class,documentWrapper.getSigningDetails().getOriginatorId(),documentWrapper.getSigningDetails().getSignerId(), documentWrapper.getClientAuth().getClientId());
	    	
	    	if(!ids.isEmpty())
	    	{
	    		 long documentId = this.saveDocument(documentWrapper);
	    		if(documentId != 0)
	    		{
	    			for(DocumentField df : documentWrapper.getDocument().getDocumentFields())
		    		 {
		    			 jdbcTemplate.update(queryProps.getProperty("insertDocumentFieldsWebservice"),documentId,df.getFieldType(),df.getPageNumber(),df.getxPosition(),df.getyPosition(),df.getFieldHeight(),df.getFieldWidth(),df.getFieldName());
		    		 }
		    		 
		    		 jdbcTemplate.update(queryProps.getProperty("insertDocumentSignWebservice"),documentWrapper.getClientAuth().getClientId(),documentWrapper.getSigningDetails().getOriginatorId(),documentWrapper.getSigningDetails().getSignerId(),documentId,documentWrapper.getSigningDetails().getSigningOrder(),uniqueID,0,new DateManipulation().getMyDate(),new DateManipulation().getMyDate());
		    		
		    		msg =  "1";
	    		}else{
	    			msg =  "Problem in document id generation.";
	    		}
	    		 
	    	}
	    	else
	    	{
	    		msg =  "Originator or Signer may not exist.";
	    	}
	    }
		}catch(Exception e){
			throw new DaoException(e);
		}
		return msg;
	}
	
	

	public long saveDocument(final DocumentWrapper documentWrapper) throws DaoException
	{
		logger.info(String.format("saveDocument(documentWrapper = %s )", documentWrapper));
		KeyHolder keyHolder = new GeneratedKeyHolder();
		final String query_doc = queryProps.getProperty("saveDocumentWebservice");

		try{
		jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	    	            PreparedStatement pst =con.prepareStatement(query_doc, new String[] {"id"});
	    	            int index = 1;
	                    pst.setLong(index++,documentWrapper.getSigningDetails().getClientId());
	                    pst.setLong(index++,documentWrapper.getSigningDetails().getOriginatorId());
	                    pst.setString(index++, documentWrapper.getDocument().getDocumentName());
	                    pst.setString(index++, documentWrapper.getDocument().getDocumentOriginalName());
	                    pst.setLong(index++, 1);
	                    pst.setTimestamp(index++, new DateManipulation().getMyDate());
	                    pst.setTimestamp(index++, new DateManipulation().getMyDate());
	                    return pst;
	    	        }
	    	    },
	    	    keyHolder);
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		return (Long) keyHolder.getKey();
	
	}

	public ClientUser getClientUserDao(int originatorId) throws DaoException
	{
		  logger.info(String.format("getClientUserDao(originatorId = %s)", originatorId));
		    
		  String sql = queryProps.getProperty("getClientUserWebservice");
		  ClientUser clientUser;
		  
		  try{
			clientUser = jdbcTemplate.query(sql, new Object[] { originatorId }, new ResultSetExtractor<ClientUser>()
		    {
				public ClientUser extractData(ResultSet rs) throws SQLException,DataAccessException 
				{				
					if(rs.next()){
						ClientUser cu = new ClientUser();
						cu.setId(rs.getInt(1));
						cu.setEmail(rs.getString(3));
						cu.setPassword(rs.getString(4));
						cu.setToken(rs.getString(5));
						cu.setStatus(rs.getInt(6));
						cu.setDateTime(rs.getDate(7));
						return cu;
			    		}
					return null;				
				}
			});
		  }catch(Exception e){
			  throw new DaoException(e.getMessage());
		  }
			return (ClientUser) clientUser;
		
	}	
	
	

	@Override
	public List<DocumentField> getFieldData(String documentName) throws DaoException
	{
		logger.info(String.format("getFieldData(documentName=%s)", documentName));
		
		String query_partyId = queryProps.getProperty("getFieldDataWebservice");
		     
		List<DocumentField> dfList = new ArrayList<DocumentField>();
		try{ 
        List<Map<String,Object>> dfRows = jdbcTemplate.queryForList(query_partyId,new Object[]{documentName});
         
        for(Map<String,Object> df : dfRows){
        	DocumentField fields = new DocumentField();
        	
        	fields.setId((Integer.parseInt((String.valueOf(df.get("id"))))));
        	fields.setFieldName(String.valueOf(df.get("form_field_name")));
        	fields.setFieldType(String.valueOf(df.get("form_field_type")));
        	fields.setPageNumber(Integer.parseInt((String.valueOf(df.get("pageno")))));
        	fields.setFieldWidth(Float.parseFloat((String.valueOf(df.get("width")))));
        	fields.setFieldHeight(Float.parseFloat((String.valueOf(df.get("height")))));
        	fields.setxPosition(Float.parseFloat((String.valueOf(df.get("x_position")))));
        	fields.setyPosition(Float.parseFloat((String.valueOf(df.get("y_position")))));
        	dfList.add(fields);
        }
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
        return dfList;
	}

	@Override
	public int[] saveDocumentFields(final List<DocumentField> documentField) throws DaoException
	{
		logger.info(String.format("saveDocumentFields(documentField = %s )", documentField));
		int[] updateCnt;
		try{
		updateCnt = jdbcTemplate.batchUpdate(
				queryProps.getProperty("saveDocumentFieldsWebservice"),
                new BatchPreparedStatementSetter() {
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                    	ps.setString(1,documentField.get(i).getFieldValue());
                        ps.setInt(2,documentField.get(i).getId());
                    }
                    public int getBatchSize() {
                        return documentField.size();
                    }
                });
		
		}catch(Exception e){
			throw new DaoException(e.getMessage());
		}
		
		return updateCnt;
		
	}

	@Override
    public VerifyDetails updateDocument(final String documentName) throws DaoException
	{
		

		logger.info(String.format("saveDocument(fname = %s)", documentName));

		List<Integer> ids = null;
		String sql = queryProps.getProperty("updateDocumentIdWebservice");
		String sqlOfverifyDetails = queryProps.getProperty("updateDocumentAllWebservice");
		VerifyDetails verifyDetails = null;
		try{
		     ids = jdbcTemplate.queryForList(sql, Integer.class, documentName,0);
		
		    if (!ids.isEmpty()) 
		    {
		    	jdbcTemplate.update(queryProps.getProperty("updateDocumentSignWebservice"), ids.get(0));
		    	
		    	
		    	 verifyDetails = jdbcTemplate.query(sqlOfverifyDetails, new Object[] { ids.get(0) }, new ResultSetExtractor<VerifyDetails>()
				    {
						public VerifyDetails extractData(ResultSet rs) throws SQLException,DataAccessException 
						{				
							if(rs.next()){
								VerifyDetails cu = new VerifyDetails();
								cu.setId(rs.getInt(1));
								cu.setFileName(rs.getString(2));
								cu.setOriginator(rs.getString(3));
								cu.setSigner(rs.getString(4));
								cu.setToken(rs.getString(5));
								return cu;
					    		}
							return null;				
						}
					});
				 
		    	
		    }
		    
		}catch(Exception e){
			logger.error(e.getMessage());
			throw new DaoException(e.getMessage());
		} 
		    
		return verifyDetails;
			

	}

	@Override
	public boolean readValidFileFromOriginator(int id, String token,String fname, String semail, String oemail) throws DaoException
	{
		logger.info(String.format("readValidFileFromOriginator(id = %s, token = %s, fname=%s, semail = %s, oemail = %s)", id,token,fname,semail,oemail));
		boolean flag = false;
		String sql = queryProps.getProperty("readValidFileFromOriginator");
		List<Integer> ids = null;
		try{
		ids = jdbcTemplate.queryForList(sql, Integer.class, fname,oemail,semail,token,1);
		if(ids.get(0) != null && ids.get(0).equals(id))
		{
			flag = true;
		}
		}catch(Exception e){
			flag = false;
			throw new DaoException(e.getMessage());
		}
		return flag;
	}

	@Override
	public ApplicationDocument getDcoument(String documentId) throws DaoException 
	{
		String classMethod = className+ ":  getDcoument" ;
		logger.info(String.format("Enter into "+classMethod+"(envelopeid= %s)", documentId));
		String sql = queryProps.getProperty("getDcoumentWebservice");
		
		try{
		    		ApplicationDocument document = jdbcTemplate.query(sql, new Object[] { documentId, }, new ResultSetExtractor<ApplicationDocument>()
		    	    {
		    			public ApplicationDocument extractData(ResultSet rs) throws SQLException,DataAccessException 
		    			{				
		    				if(rs.next())
		    				{
		    					ApplicationDocument doc = new ApplicationDocument();
		    					doc.setOriginal(rs.getBinaryStream("original"));
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
	public int createDocument(final int userId, final String envelopeId,  final String fileName,final InputStream inputStream, final int status, final String signType, final String subject, final String message) throws DaoException 
	{
		String classMethod = className+ ":  createDocument" ;
		logger.info(String.format("Enter into "+classMethod+"(userId = %s,envelopeId = %s, fileName= %s, inputStream = %s, status = %s, signType = %s, subject = %s, message = %s)", userId,envelopeId, fileName, inputStream, status, signType, subject, message));
		
		int flag = 0;
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		try{
		final int length = inputStream.available();
		final String sql = queryProps.getProperty("createDocumentWebservice");
		
		
			jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
	            PreparedStatement pst =con.prepareStatement(sql, new String[] {"id"});
	            int index = 1;
	            pst.setInt(index++,userId);
	            pst.setString(index++, envelopeId);
	            pst.setString(index++,fileName);
	            pst.setBinaryStream(index++,inputStream,length );
	            pst.setInt(index++, status);
	            pst.setString(index++, signType);
	            pst.setString(index++, subject);
	            pst.setString(index++, message);
	            pst.setString(index++, signType);
	            pst.setTimestamp(index++, CommonUtils.currentDate());
	            return pst;
	        }
	    },
	    keyHolder);
		
		logger.info("exit from "+classMethod);
		flag =  keyHolder.getKey().intValue();
	
		
		/*String sql1 = "update document set digital = ? where id = ? ";
		int status1 = jdbcTemplate.update(sql1, inputStream, flag);*/
		
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}
		
		
		
		
		
		
		
		
		/*try{
			
		final String sql = "INSERT INTO document(user_id,envelopeid,name,original,electronic,digital,status,file_type,sign_type) VALUES(?,?,?,?,?,?,?,?,?)";
		
		flag = jdbcTemplate.update(sql,new Object[]{userId, envelopeId, fileName, inputStream,inputStream,inputStream, status, signType, signType});
	
				
		
		}catch(Exception e ){
			throw new DaoException(e.getMessage());
		}*/
		return flag;
		
		
		
	}

	@Override
	public Registration getUser(String userName) throws DaoException 
	{
		String classMethod = className+ ":  getUser" ;
		logger.info(String.format("Enter into "+classMethod+"(userName = %s)", userName));	    
		String sql = queryProps.getProperty("getUserAllDetails");
	    
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

	
	@Override
	public String modifyDocument(final RestDocument document,String token) 
	{
		String classMethod = className+ ":  modifyDocument" ;
		logger.info(String.format("Enter into "+classMethod+" (document = %s)", document));
		
		int status = 0;
		int signerId;
		String msg = "";

		Set<Integer> uqiqueSignerId = new HashSet<Integer>();
		String userSelectSql =queryProps.getProperty("modifyDocumentIdWebservice");
		final String userInsertSql =queryProps.getProperty("modifyDocumentInsertWebservice");
		String documentSignFieldInsertSql = queryProps.getProperty("modifyDocumentSignFieldWebservice");
		String documentSignEmailInsertSql = queryProps.getProperty("modifyDocumentSignEmailWebservice");
		
		int documentId = getDocumentId(document.getEnvelopeId());
		
		if(document != null && documentId > 0)
		{
			try{
				
			
				//start insert document_sign
				
				//start getting id of signer
				KeyHolder keyHolder = new GeneratedKeyHolder();
				List<Integer> ids = jdbcTemplate.queryForList(userSelectSql, Integer.class,document.getSignerEmail()); 
			    if (!ids.isEmpty()) {
			    	signerId = ids.get(0);
			    }else{
			    	String signerEmail = document.getSignerEmail();
			    	int index = signerEmail.indexOf('@');
			    	final String signerName = signerEmail.substring(0,index);
			    	
			    	jdbcTemplate.update(new PreparedStatementCreator() {public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
			            PreparedStatement pst =con.prepareStatement(userInsertSql, new String[] {"id"});
			            int index = 1;
			            pst.setString(index++,signerName);
			            pst.setString(index++,document.getSignerEmail());
			            pst.setInt(index++, 0);
			            pst.setInt(index++, 0);
			            pst.setTimestamp(index++, CommonUtils.currentDate());
			            return pst;
			        }
			    },
			    keyHolder);
				
			    	signerId =  Integer.parseInt(keyHolder.getKey().toString());
			    	
			    }
			  //end getting id of signer
			    
					for(final RestDocumentField documentSignField: document.getDocumentFields())
					{	
						
					    
					    //start insert document_sign_field
					    if(signerId != 0)
					    {
					    	int priority = 1;
					    	jdbcTemplate.update(documentSignFieldInsertSql,signerId,documentId,documentSignField.getPageNumber(),priority,documentSignField.getxPosition(),documentSignField.getyPosition(),documentSignField.getFieldHeight(),documentSignField.getFieldWidth(),documentSignField.getFieldValue(),documentSignField.getFieldName(),documentSignField.getFieldType(),CommonUtils.currentDate());
					    	
					    	//start insert document_sign_email
					    	if(uqiqueSignerId.add(signerId))
					    	{	
					    		int mailCount = 0;
					    		int signstatus =0;
					    		/*if(documentSignField.getPriority().equals("0")){
					    			signstatus = 1;
					    		}
					    		if(documentSignField.getPriority().equals("1"))
					    		{
					    			mailCount = 1;
					    		}*/
					    		
					    		jdbcTemplate.update(documentSignEmailInsertSql,signerId,documentId,priority,mailCount,token,signstatus,CommonUtils.currentDate());
					    		msg = "success";
					    	}
					    	//end insert document_sign_email
					    }
					    //end insert document_sign_field
					}
			
			//end insert document_sign
			}catch(Exception e){
				msg = ""+e;
			}
		}else{
			msg = "Error: Document cant be empty.";
		}
		logger.info("exit from "+classMethod);
		return msg;
	}

	public int getDocumentId(String envelopeId)
	{
		int documentId = 0;
 		String sql = queryProps.getProperty("getDocumentIdWebservice");
		List<Integer> ids = jdbcTemplate.queryForList(sql, Integer.class,envelopeId); 
	    if (!ids.isEmpty()) {
	    	documentId = ids.get(0);
	    }
		return documentId;
	}

	@Override
	public int modifyDocumentBlob( InputStream inputStream, String envelopeId, String blobField) 
	{
	    final String sql = "update document set "+ blobField +" = ?,upload_date=? where envelopeid = ? ";
	    PreparedStatement ps = null;
		Connection con = null;
		int out=0;
		try{
			int length;
		    length = inputStream.available();
		    con = dataSource.getConnection();
			ps = con.prepareStatement(sql);
			ps.setBinaryStream(1, inputStream,length);
		    ps.setTimestamp(2, CommonUtils.currentDate());
	        ps.setString(3, envelopeId);
			out = ps.executeUpdate();
			if(out !=0){
				System.out.println("Document updated with id="+envelopeId);
			}else
				System.out.println("No Document found with id="+envelopeId);
			
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
		
		return out;
	}

	@Override
	public String isValidEnvelopeId(String envelopeId, String email) 
	{
		String sql = queryProps.getProperty("isValidEnvelopeId");
		String msg="error";
		try{
			List<Integer> eId = jdbcTemplate.queryForList(sql, Integer.class, email, envelopeId ); 
		    if (eId.isEmpty()) 
		    {
		        msg = "Invalid envelopeId.";
		    }else{
		    	jdbcTemplate.update(queryProps.getProperty("deleteisValidEnvelopeId"),envelopeId);
		    	msg = "success";
		    }
			
		}catch(Exception e){
			msg = "Error while checking envelopeId: "+e;
		}
		return msg;
	}

	@Override
	public boolean checkUserIsExist(String emailId) throws DaoException{
		// TODO Auto-generated method stub  r
		String sql = queryProps.getProperty("checkUserIsExist");
		try{
		List<String> status = jdbcTemplate.queryForList(sql, String.class, emailId);
		 if(status.isEmpty()){
			 return false;
		 }else{
			 return true;
		}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public Registration getPassword(String emailId) throws DaoException {
		
		String sql = queryProps.getProperty("getPasswordApp");
		
		Registration reg = jdbcTemplate.query(sql, new Object[] { emailId }, new ResultSetExtractor<Registration>()
	    {
			public Registration extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				if(rs.next())
				{
					Registration r = new Registration();
					r.setId(rs.getInt("id"));
					r.setPassword(rs.getString("password"));
					r.setStatus(rs.getInt("status"));
					return r;
		    	}
				return null;				
			}
		});
		return reg;
	  }
	
}
