package com.environmentlock;

import com.sleepycat.je.cleaner.Cleaner;

import driver.AroundAdvice;
import driver.Driver;

public privileged aspect EnvironmentLock extends EnvironmentLockAbstract {

	pointcut driver() : if(new Driver().isActivated("environmentlock"));

	pointcut hook_lockEnvironment(Cleaner c) : EnvironmentLockAbstract.hook_lockEnvironment(c) 
		&& driver();

	void around() : adviceexecution() && within(com.environmentlock.EnvironmentLockAbstract) 
	&& driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}