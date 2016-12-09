package com.myexample.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myexample.dao.ApplicatonDao;
import com.myexample.dao.DaoException;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.DocumentCount;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentSign;
import com.myexample.model.Registration;
import com.myexample.model.ResetPassword;
import com.myexample.model.RestDocument;
import com.myexample.model.Signature;
import com.myexample.model.User;

@Service("applicationService")
public class ApplicationServiceImpl implements ApplicationService
{
	@Autowired
	ApplicatonDao applicationDao;
	@Override
	public String createDocument(int userid,String envelopId, String name, InputStream inputStream, int status,String type,String signType, String ipAddress) throws DaoException {
		
		return applicationDao.insertDocument(userid,envelopId, name,inputStream,status,type,signType,ipAddress);
	}
	@Override
	public ApplicationDocument readDocument(int id, String filename) throws DaoException {
		return applicationDao.readDocument(id, filename);
	}
	@Override
	public String createGroupSign(DocumentSign documentSign,String signatureid) {
	
		return applicationDao.createGroupSignDao(documentSign, signatureid);
	}
	@Override
	public String getTokenOfDocumentSignEmail(int documentId, String email) {
	
		return applicationDao.getTokenOfDocumentSignEmailDao(documentId,email);
	}

	@Override
	public List<DocumentField> getApplicationFieldData(String documentName,String fileid, String signeremail) throws DaoException {
		return applicationDao.getApplicationDao(documentName, fileid, signeremail);
	}
	@Override
	public boolean checkValidFile(String fileid, String fname, String token,String email) throws DaoException {
		
		return applicationDao.checkValidFileDao(fileid, fname,token,email);
	}
	@Override
	public Map<String, Object> saveAppDocumentFields(List<DocumentField> documentField,String signerEmail, String fileId, String token, String fName) throws DaoException {
		
		return applicationDao.saveAppDocumentFields(documentField, signerEmail,fileId,token,fName);
	}
	@Override
	public int saveModifiedDocument(String fileId, InputStream modifiedFile, boolean digital) {
		
		return applicationDao.saveModifiedDocumentDao(fileId,modifiedFile,digital);
	}
	@Override
	public int deleteDocument(int id) {
		
		return applicationDao.deleteDocumentDao(id);
	}
	@Override
	public String changePassword(String oldpassword, String newpassword,String email) {
		
		return applicationDao.changePasswordDao(oldpassword,newpassword,email);
	}
	@Override
	public boolean updatePhoto(int loginuserid, String fileName) {
		
		return applicationDao.changePhotoDao(loginuserid,fileName);
	}
	@Override
	public String forgotPasswordService(String email, String token) {
		
		return applicationDao.forgotPasswordDao(email,token);
	}
	@Override
	public List<Signature> getUserSignatures(int id) {
		
		return applicationDao.getUserSignaturesDao(id);
	}
	@Override
	public int resetPasswordService(ResetPassword resetPassword) {
		
		return applicationDao.resetPasswordDao(resetPassword);
	}
	@Override
	public DocumentCount getDocumentCount(int id) throws DaoException {
		return applicationDao.getDocumentCountDao(id);
	}
	@Override
	public String updateProfile(Registration registration) {
		return applicationDao.updateProfileDao(registration);
	}
	@Override
	public RestDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException {
	
		return applicationDao.getDocumentByEnvelopeId(envelopeId);
	}
	@Override
	public int deletesignature(String signId) {
		
		return applicationDao.deletesignature(signId);
	}
	@Override
	public int saveSignature(int id, String dataURL) {
		
		return applicationDao.saveSignature(id,dataURL);
	}
	@Override
	public int deleteProfilePic(int id) {
		
		return applicationDao.deleteProfilePic(id);
	}
	
	@Override
	public String increaseReminderEmailCount(int count, int docId,String signerEmail) {
		
		return applicationDao.increaseReminderEmailCount(count,docId,signerEmail);
	}
	@Override
	public String checkValidResetPassword(ResetPassword resetPassword) 
	{
		return applicationDao.checkValidResetPassword(resetPassword);
	}
	@Override
	public List<User> getUnRegisteredUsers() throws DaoException {
		
		return applicationDao.getUnRegisteredUsers();
	}

}
