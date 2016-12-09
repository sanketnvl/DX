package com.myexample.dao;

import java.io.InputStream;
import java.util.List;

import com.myexample.model.ApplicationDocument;
import com.myexample.model.ClientAuth;
import com.myexample.model.ClientUser;
import com.myexample.model.Document;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentWrapper;
import com.myexample.model.Registration;
import com.myexample.model.RestDocument;
import com.myexample.model.VerifyDetails;


public interface JerseyDao {

	public String addUserJersey(ClientUser clientUser) throws DaoException;

	public List<ClientUser> getAllClientUserDao(ClientAuth clientUserAuth) throws DaoException;

	public String addDocumentDao(DocumentWrapper documentWrapper) throws DaoException;

	public ClientUser getClientUserDao(int originatorId) throws DaoException;
	
	
	public List<DocumentField> getFieldData( String documentName) throws DaoException;
	
	public int[] saveDocumentFields(List<DocumentField> documentField) throws DaoException;
	
	public VerifyDetails updateDocument(String documentName) throws DaoException;

	public boolean readValidFileFromOriginator(int id, String token,String fname, String semail, String oemail) throws DaoException;

	public ApplicationDocument getDcoument(String documentId) throws DaoException;

	public int createDocument(int userId, String fileName,String envelopeId, InputStream inputStream, int status, String signType, String subject, String message) throws DaoException;

	public Registration getUser(String email) throws DaoException;

	public String modifyDocument(RestDocument documentWrapper, String token);

	public int modifyDocumentBlob(InputStream inputStream,String envelopeId, String blobField);

	public String isValidEnvelopeId(String envelopeId, String email);

	public boolean checkUserIsExist(String emailId)throws DaoException;
	
	public Registration getPassword(String emailId) throws DaoException;
	
	
}
