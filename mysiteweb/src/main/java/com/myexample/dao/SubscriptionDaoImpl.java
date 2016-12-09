package com.myexample.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myexample.model.Registration;
import com.myexample.model.Signature;
import com.myexample.model.SubscriptionPlan;

@Repository("subscriptionDao")
@Transactional
public class SubscriptionDaoImpl implements SubscriptionDao {

	private static final Logger logger = Logger.getLogger(SubscriptionDaoImpl.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private Properties queryProps;
	
	String className = this.getClass().getSimpleName();
	
	@Override
	public List<SubscriptionPlan> getSubscriptionPlans() 
	{
		String classMethod = className+ ":  getSubscriptionPlans()" ;
		logger.info(String.format("Enter into "+classMethod));
		
		
		String sql = queryProps.getProperty("getSubscriptionPlans");
		List<SubscriptionPlan> subscritionPlan = jdbcTemplate.query(sql,new RowMapper<SubscriptionPlan>(){  
		    @Override  
		    public SubscriptionPlan mapRow(ResultSet rs, int rownumber) throws SQLException {  
		    	SubscriptionPlan sp = new SubscriptionPlan();  
		        sp.setPlanId(rs.getInt(1));  
		        sp.setCurrency(rs.getString(2));  
		        sp.setAmount(rs.getString(3));
		        sp.setPlanName(rs.getString(4));
		        sp.setNumberOfDays(rs.getString(5));
		        sp.setNumberOfDocuments(rs.getString(6));
		        sp.setStatus(rs.getInt(7));
		        sp.setContent(rs.getString(8));
		        return sp;  
		    }  
		    });
			
		logger.info("exit from "+classMethod);
		return subscritionPlan;
	}



	@Override
	public SubscriptionPlan getSubscrptionPlan(String product) 
	{
		String classMethod = className+ ":  getSubscrptionPlan()" ;
		logger.info(String.format("Enter into "+classMethod));
		
		String sql = queryProps.getProperty("getSubscriptionPlan");
		
		SubscriptionPlan subscriptionPlan = jdbcTemplate.query(sql, new Object[] { product }, new ResultSetExtractor<SubscriptionPlan>()
	    {
			public SubscriptionPlan extractData(ResultSet rs) throws SQLException,DataAccessException 
			{				
				SubscriptionPlan sp = new SubscriptionPlan();
				if(rs.next()){
					 sp.setPlanId(rs.getInt(1));  
				        sp.setCurrency(rs.getString(2));  
				        sp.setAmount(rs.getString(3));
				        sp.setPlanName(rs.getString(4));
				        sp.setNumberOfDays(rs.getString(5));
				        sp.setNumberOfDocuments(rs.getString(6));
				        sp.setStatus(rs.getInt(7));
				        sp.setContent(rs.getString(8));
		    		return sp;
		    		}
				return sp;				
			}
		});	
		
		
		logger.info("exit from "+classMethod);
		return subscriptionPlan;
	}

}
