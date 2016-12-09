package com.myexample.dao;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import com.myexample.model.ApplicationDocument;
import com.myexample.model.DocumentCount;
import com.myexample.model.DocumentField;
import com.myexample.model.DocumentSign;
import com.myexample.model.Registration;
import com.myexample.model.ResetPassword;
import com.myexample.model.RestDocument;
import com.myexample.model.Signature;
import com.myexample.model.User;


public interface ApplicatonDao {

	String insertDocument(int userid, String name, String envelopId, InputStream inputStream,int status, String type, String signType, String ipAddress) throws DaoException;

	ApplicationDocument readDocument(int id, String filename) throws DaoException;

	String createGroupSignDao(DocumentSign documentSign, String signatureid);

	String getTokenOfDocumentSignEmailDao(int documentId, String email);

	List<DocumentField> getApplicationDao(String documentName, String fileid, String signeremail) throws DaoException;

	boolean checkValidFileDao(String fileid, String fname, String token,String email) throws DaoException;

	Map<String, Object> saveAppDocumentFields(List<DocumentField> documentField,String signerEmail, String fileId, String token, String fName) throws DaoException;

	int saveModifiedDocumentDao(String fileId, InputStream modifiedFile, boolean digital);

	int deleteDocumentDao(int id);

	String changePasswordDao(String oldpassword, String newpassword,String email);

	boolean changePhotoDao(int loginuserid, String fileName);

	String forgotPasswordDao(String email, String token);

	List<Signature> getUserSignaturesDao(int id);

	int resetPasswordDao(ResetPassword resetPassword);

	DocumentCount getDocumentCountDao(int id) throws DaoException;

	String updateProfileDao(Registration registration);

	RestDocument getDocumentByEnvelopeId(String envelopeId) throws DaoException;

	int deletesignature(String signId);

	int saveSignature(int id, String dataURL);

	int deleteProfilePic(int id);

	String increaseReminderEmailCount(int count, int docId, String signerEmail);

	String checkValidResetPassword(ResetPassword resetPassword);

	List<User> getUnRegisteredUsers() throws DaoException;
	
}
