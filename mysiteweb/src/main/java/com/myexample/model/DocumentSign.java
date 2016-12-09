package com.myexample.model;

import java.util.List;

public class DocumentSign {

	int id;
	int originatorId;
	int documentId;
	String documentName;
	String title;
	String message;
	String status;
	List<DocumentSignField> documentSignField;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOriginatorId() {
		return originatorId;
	}
	public void setOriginatorId(int originatorId) {
		this.originatorId = originatorId;
	}
	public int getDocumentId() {
		return documentId;
	}
	public void setDocumentId(int documentId) {
		this.documentId = documentId;
	}
	public String getDocumentName() {
		return documentName;
	}
	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public List<DocumentSignField> getDocumentSignField() {
		return documentSignField;
	}
	public void setDocumentSignField(List<DocumentSignField> documentSignField) {
		this.documentSignField = documentSignField;
	}
	@Override
	public String toString() {
		return "DocumentSign [id=" + id + ", originatorId=" + originatorId
				+ ", documentId=" + documentId + ", documentName="
				+ documentName + ", title=" + title + ", message=" + message
				+ ", status=" + status + ", documentSignField="
				+ documentSignField + "]";
	}
	

	
	
}
