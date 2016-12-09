package com.myexample.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.myexample.model.SubscriptionPlan;

@Component
public interface SubscriptionDao {

	List<SubscriptionPlan> getSubscriptionPlans();

	SubscriptionPlan getSubscrptionPlan(String product);

}
