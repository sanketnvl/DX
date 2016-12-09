package com.myexample.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myexample.model.Registration;

@Repository("adminDao")
@Transactional
public class AdminDaoImpl implements AdminDao{

	public final static String SUCCESS="success";
	public final static String FAILURE="failure";
	
	private final static Logger logger = Logger.getLogger(AdminDaoImpl.class);
	String className = this.getClass().getSimpleName();
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Properties queryProps;
	
	
	@Override
	public List<Registration> getUserList() {
		// TODO Auto-generated method stub
		String classMethod = className + ":  view";
		logger.info(String.format("Enter into " + classMethod + "()"));
		String query = queryProps.getProperty("getUserList");

		List<Registration> userList = new ArrayList<Registration>();
		
		List<Map<String,Object>> jsonRows = jdbcTemplate.queryForList(query,new Object[] {});
		 
        for(Map<String,Object> jsonRow : jsonRows){
        	Registration r = new Registration();
        	
        	r.setFirstName(String.valueOf(jsonRow.get("firstName")));
        	r.setLastname(String.valueOf(jsonRow.get("lastName")));
        	r.setEmail(String.valueOf(jsonRow.get("email")));
        	r.setRole(String.valueOf(jsonRow.get("role")));
        	r.setStatus(Integer.parseInt(String.valueOf(jsonRow.get("status"))));
        	r.setCreatedOn(String.valueOf(jsonRow.get("createdOn")));
        	userList.add(r);
        }
        
    	logger.info("exit from " + classMethod);
		return userList;
	}

	@Override
	public List<Registration> getUserHistoty() {
		// TODO Auto-generated method stub
		return null;
	}

}
