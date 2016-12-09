package com.myexample.utility;

import java.sql.Timestamp;
import java.util.Calendar;

public class DateManipulation {

	public Timestamp getMyDate()
	{
		java.util.Date date= new java.util.Date();
		java.sql.Timestamp ts = new Timestamp(date.getTime());
		Calendar cal = Calendar.getInstance();
		cal.setTime(ts);
		ts.setTime(cal.getTime().getTime());
		return ts;
	}
	
	public Timestamp getMyDate(int days)
	{
		java.util.Date date= new java.util.Date();
		java.sql.Timestamp ts = new Timestamp(date.getTime());
		Calendar cal = Calendar.getInstance();
		cal.setTime(ts);
		cal.add(Calendar.DATE, days);
		ts.setTime(cal.getTime().getTime());
		return ts;
	}
	
}
