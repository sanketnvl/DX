package com.myexample.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myexample.dao.DaoException;
import com.myexample.dao.RegistrationDao;
import com.myexample.model.Registration;

@Service("registerService")
public class RegisterServiceImpl implements RegisterService {

	@Autowired
	private RegistrationDao registrationDao;
	
	public int addRegistration(Registration registration) throws DaoException {
		
		return registrationDao.addRegistrationDao(registration);
	}

	public int verifyRegistration(String token, String email) throws DaoException {
		
		return registrationDao.verifyRegistrationDao(token,email);
	}


	public boolean checkValidFile(String fname, String token, String email) throws DaoException {
	
		return registrationDao.checkValidFileDao(fname,token,email);
	}

	@Override
	public Registration getUser(String userName) throws DaoException {
		
		return registrationDao.getUser(userName);
	}

	@Override
	public Registration loginCall(String email) throws DaoException {
		// TODO Auto-generated method stub
		return registrationDao.loginCall(email);
	}

}
