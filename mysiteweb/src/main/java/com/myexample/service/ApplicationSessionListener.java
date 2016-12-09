package com.myexample.service;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

public class ApplicationSessionListener implements HttpSessionListener {

private static int totalActiveSessions;

private static final Logger logger = Logger.getLogger(ApplicationSessionListener.class);
public static int getTotalActiveSession(){
	return totalActiveSessions;
 }

@Override	
public void sessionCreated(HttpSessionEvent event) {
	totalActiveSessions++;
	logger.info("sessionCreated - add one session into counter");
 }

@Override
public void sessionDestroyed(HttpSessionEvent event) {
   //write your logic
	totalActiveSessions--;
	logger.info("sessionDestroyed - deduct one session from counter");
  }
 }