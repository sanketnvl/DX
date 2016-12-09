package com.myexample.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.myexample.model.ApplicationDocument;
import com.myexample.model.Audit;
import com.myexample.model.Document;
import com.myexample.model.DocumentEmail;
import com.myexample.model.DocumentField;
import com.myexample.model.JsonDocumentData;

@Component
public interface DocumentDao {
	
	public String saveOrUpdateDocument(Document doc);
	
	public String saveDocumentFields(List<DocumentField> documentField);
	
	public String saveDocumentEmailData(DocumentEmail dEmail);
	
	public List<JsonDocumentData> completedDocuments(int userId);
	
	public List<JsonDocumentData> outForSignature(int userId);
	
	ApplicationDocument getDocument(int id) throws DaoException;
	
	public List<JsonDocumentData> getDocumentsHistory();
	
	public List<Audit> getWebserviceLogs();
	
}
