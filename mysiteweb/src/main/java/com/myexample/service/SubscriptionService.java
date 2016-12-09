package com.myexample.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.myexample.model.SubscriptionPlan;

@Component
public interface SubscriptionService {

	List<SubscriptionPlan> getSubscriptionPlans();

	SubscriptionPlan getSubscrptionPlan(String product);

}
