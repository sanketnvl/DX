package com.myexample.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

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

@Component
public interface ApplicationService {

	public String createDocument(int i, String name, String fileName, InputStream inputStream, int j, String string, String signtype, String ipAddress) throws DaoException;

	public ApplicationDocument readDocument(int i, String fname) throws DaoException;

	public String createGroupSign(DocumentSign documentSign, String signatureid);

	public String getTokenOfDocumentSignEmail(int documentId, String email);

	public List<DocumentField> getApplicationFieldData(String documentName, String fileid, String signeremail) throws DaoException;

	public boolean checkValidFile(String fileid, String fname, String token,String email) throws DaoException;

	public Map<String, Object> saveAppDocumentFields(List<DocumentField> documentField,String signerEmail, String fileId, String token, String fname) throws DaoException;

	public int saveModifiedDocument(String fileId, InputStream modifiedFile, boolean digital);

	public int deleteDocument(int id);

	public String changePassword(String oldpassword, String newpassword,String email);

	public boolean updatePhoto(int loginuserid, String fileName);

	public String forgotPasswordService(String email, String token);

	public List<Signature> getUserSignatures(int id);

	public int resetPasswordService(ResetPassword resetPassword);

	public DocumentCount getDocumentCount(int id) throws DaoException;

	public String updateProfile(Registration registration);

	public RestDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException;

	public int deletesignature(String signId);

	public int saveSignature(int id, String dataURL);

	public int deleteProfilePic(int id);
	
	public String increaseReminderEmailCount(int i, int docId,String signerEmail);

	public String checkValidResetPassword(ResetPassword resetPassword);

	public List<User> getUnRegisteredUsers() throws DaoException;
}
