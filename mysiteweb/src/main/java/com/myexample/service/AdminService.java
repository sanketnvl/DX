package com.myexample.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.myexample.model.Registration;


@Component
public interface AdminService {
	
	public List<Registration> getUserList();
	
	public List<Registration> getUserHistoty();
	
}
