package com.myexample.service;

import org.springframework.stereotype.Component;

import com.myexample.dao.DaoException;
import com.myexample.model.Registration;

@Component
public interface RegisterService {

	public int addRegistration(Registration registration) throws DaoException ;

	public int verifyRegistration(String token, String email) throws DaoException;

	public boolean checkValidFile(String fname, String token, String email) throws DaoException;

	public Registration getUser(String userName) throws DaoException;
	
	public Registration loginCall(String email) throws DaoException;
}
