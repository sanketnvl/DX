package com.myexample.service;

import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myexample.dao.DaoException;
import com.myexample.dao.JerseyDao;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.ClientAuth;
import com.myexample.model.ClientUser;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentWrapper;
import com.myexample.model.Registration;
import com.myexample.model.RestDocument;
import com.myexample.model.VerifyDetails;

@Service("jerseyService")
public class JerseyServiceImpl implements JerseyService {

	@Autowired
	private JerseyDao jerseyDao;
	
	public String addUserJersey(ClientUser clientUser) throws DaoException {
		
		return jerseyDao.addUserJersey(clientUser);
	}

	public List<ClientUser> getAllClientUserService(ClientAuth clientUserAuth) throws DaoException 
	{
		return jerseyDao.getAllClientUserDao(clientUserAuth);
	}

	public String addDocumentService(DocumentWrapper documentWrapper) throws DaoException {
		
		return jerseyDao.addDocumentDao(documentWrapper);
	}

	public ClientUser getClientUser(int originatorId) throws DaoException {
		
		return jerseyDao.getClientUserDao(originatorId);
	}


	@Override
	public List<DocumentField> getFieldData(String documentName) throws DaoException {
		return jerseyDao.getFieldData(documentName);
	}

	@Override
	public int[] saveDocumentFields(List<DocumentField> documentField) throws DaoException {
		return jerseyDao.saveDocumentFields(documentField);
	}

	@Override
	public VerifyDetails updateDocument(String documentName) throws DaoException {
		return jerseyDao.updateDocument(documentName);
	}

	@Override
	public boolean readValidFileFromOriginator(int id, String token,String fname, String semail, String oemail) throws DaoException 
	{	
		return jerseyDao.readValidFileFromOriginator(id,token,fname,semail,oemail);
	}

	@Override
	public ApplicationDocument getDocument(String documentId) throws DaoException {
		
		return jerseyDao.getDcoument(documentId);
	}

	@Override
	public int createDocument(int userId, String envelopeId,String fileName,InputStream inputStream, int status, String signType, String subject, String message) throws DaoException {
	
		return jerseyDao.createDocument(userId, envelopeId, fileName, inputStream, status, signType, subject, message);
	}

	@Override
	public Registration getUser(String email) throws DaoException {
		
		return jerseyDao.getUser(email);
	}

	@Override
	public String modifyDocument(RestDocument documentWrapper, String token) {
		
		return jerseyDao.modifyDocument(documentWrapper, token);
	}

	@Override
	public int modifyDocumentBlob(InputStream inputStream,String envelopeId, String blobField) 
	{
		
		return jerseyDao.modifyDocumentBlob(inputStream, envelopeId, blobField);
	}

	@Override
	public String isValidEnvelopeId(String envelopeId, String email) 
	{
		
		return jerseyDao.isValidEnvelopeId(envelopeId, email);
	}

	@Override
	public boolean checkUserIsExist(String emailId)throws DaoException {
		// TODO Auto-generated method stub
		return jerseyDao.checkUserIsExist(emailId);
	}

	@Override
	public Registration getPassword(String emailId) throws DaoException {
		// TODO Auto-generated method stub
		return jerseyDao.getPassword(emailId);
	}

	
	


}
