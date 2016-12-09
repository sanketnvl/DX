package com.myexample.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myexample.model.SubscriptionPlan;
import com.myexample.service.SubscriptionService;

@Controller
 class SubscriptionController {
	
	@Autowired
	private SubscriptionService subscriptionService;
	
	@RequestMapping(value="/pricing", method = RequestMethod.GET)
	public ModelAndView pricing()
	{
		List<SubscriptionPlan> plans = subscriptionService.getSubscriptionPlans();
		Map<String,List<SubscriptionPlan>> map = new HashMap<String,List<SubscriptionPlan>>();
		map.put("plans", plans);
		return new ModelAndView("pricing",map);
	}
	
	@RequestMapping("/cart")
	public ModelAndView cart(@RequestParam("product") String product)
	{
		SubscriptionPlan subscriptionPlan = subscriptionService.getSubscrptionPlan(product);
		Map<String, SubscriptionPlan> map = new HashMap<String,SubscriptionPlan>();
		map.put("subscriptionPlan", subscriptionPlan);
		return new ModelAndView("cart",map);
	}
	
}
