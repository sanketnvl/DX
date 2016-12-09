package com.myexample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myexample.dao.DaoException;
import com.myexample.dao.DocumentDao;
import com.myexample.model.ApplicationDocument;
import com.myexample.model.Audit;
import com.myexample.model.Document;
import com.myexample.model.DocumentEmail;
import com.myexample.model.DocumentField;
import com.myexample.model.JsonDocumentData;

@Service("documentService")
public class DocumentServiceImpl implements DocumentService{


	@Autowired
	private DocumentDao documentDao;
	
	@Override
	public String saveOrUpdateDocument(Document doc) {
		// TODO Auto-generated method stub
		return documentDao.saveOrUpdateDocument(doc);
	}

	@Override
	public String saveDocumentFields(List<DocumentField> documentField) {
		// TODO Auto-generated method stub
		return documentDao.saveDocumentFields(documentField);
	}

	@Override
	public String saveDocumentEmailData(DocumentEmail dEmail) {
		// TODO Auto-generated method stub
		return documentDao.saveDocumentEmailData(dEmail);
	}

	@Override
	public List<JsonDocumentData> completedDocuments(int userId) {
		// TODO Auto-generated method stub
		return documentDao.completedDocuments(userId);
	}

	@Override
	public List<JsonDocumentData> outForSignature(int userId) {
		// TODO Auto-generated method stub
		return documentDao.outForSignature(userId);
	}

	@Override
	public ApplicationDocument getDocument(int id) throws DaoException {
		// TODO Auto-generated method stub
		return documentDao.getDocument(id);
	}

	@Override
	public List<JsonDocumentData> getDocumentsHistory() {
		// TODO Auto-generated method stub
		return documentDao.getDocumentsHistory();
	}

	@Override
	public List<Audit> getWebserviceLogs() {
		// TODO Auto-generated method stub
		return documentDao.getWebserviceLogs();
	}

	
	
	
}
