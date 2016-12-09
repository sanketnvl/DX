package com.myexample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myexample.dao.SubscriptionDao;
import com.myexample.model.SubscriptionPlan;

@Service("subscriptionService")
public class SubscriptionServiceImpl implements SubscriptionService{

	@Autowired
	private SubscriptionDao subscriptionDao;

	@Override
	public List<SubscriptionPlan> getSubscriptionPlans() {
		
		return subscriptionDao.getSubscriptionPlans();
	}

	@Override
	public SubscriptionPlan getSubscrptionPlan(String product) {
		
		return subscriptionDao.getSubscrptionPlan(product);
	}
}
