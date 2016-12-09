package com.myexample.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.myexample.model.Registration;

@Component
public interface AdminDao  {

public List<Registration> getUserList();
	
	public List<Registration> getUserHistoty();
}
