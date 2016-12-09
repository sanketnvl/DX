package com.myexample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myexample.dao.AdminDao;
import com.myexample.model.Registration;

@Service("adminService")
public class AdminServiceImpl implements AdminService
{
	@Autowired
	private AdminDao adminDao;
	
	@Override
	public List<Registration> getUserList() {
		// TODO Auto-generated method stub
		return adminDao.getUserList();
	}

	@Override
	public List<Registration> getUserHistoty() {
		// TODO Auto-generated method stub
		return adminDao.getUserHistoty();
	}

}
