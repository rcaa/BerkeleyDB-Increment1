package com.evictor;

import com.sleepycat.je.recovery.Checkpointer;

import driver.AroundAdvice;
import driver.Driver;

public privileged aspect WeaveEvictor extends WeaveEvictorAbstract {

	pointcut driver() : if(new Driver().isActivated("evictor"));
	
	pointcut hook_checkpointStart(Checkpointer cp) 
	 : WeaveEvictorAbstract.hook_checkpointStart(cp) 
	 	&& driver();
	
	void around() : adviceexecution() && within(com.evictor.WeaveEvictorAbstract) 
	&& driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}