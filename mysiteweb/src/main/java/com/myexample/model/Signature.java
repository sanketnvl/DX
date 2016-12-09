package com.myexample.model;

public class Signature {

	private int id;
	private String sign;
	private String date;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Signature [id=" + id + ", sign=" + sign + ", date=" + date
				+ "]";
	}
	
	
}
