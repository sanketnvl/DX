package com.myexample.model;

public class SubscriptionPlan {

	private int planId;
	private String currency;
	private String amount;
	private String planName;
	private String numberOfDays;
	private String numberOfDocuments;
	private int status;
	private String content;
	public int getPlanId() {
		return planId;
	}
	public void setPlanId(int planId) {
		this.planId = planId;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getNumberOfDays() {
		return numberOfDays;
	}
	public void setNumberOfDays(String numberOfDays) {
		this.numberOfDays = numberOfDays;
	}
	public String getNumberOfDocuments() {
		return numberOfDocuments;
	}
	public void setNumberOfDocuments(String numberOfDocuments) {
		this.numberOfDocuments = numberOfDocuments;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Override
	public String toString() {
		return "SubscriptionPlan [planId=" + planId + ", currency=" + currency + ", amount=" + amount + ", planName="
				+ planName + ", numberOfDays=" + numberOfDays + ", numberOfDocuments=" + numberOfDocuments + ", status="
				+ status + ", content=" + content + "]";
	}
	
	
	
	
}
