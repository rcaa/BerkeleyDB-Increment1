package com.incompressor;

import com.sleepycat.je.cleaner.UtilizationTracker;
import com.sleepycat.je.tree.IN;
import com.sleepycat.je.tree.Tree;

import driver.AroundAdvice;
import driver.Driver;

public privileged aspect PurgeRootAspect extends PurgeRootAbstract {

	pointcut driver() : if(new Driver().isActivated("iNCompressor"));

	pointcut hook_updateRoot(IN rootIN, UtilizationTracker tracker, Tree tree) 
	 : PurgeRootAbstract.hook_updateRoot(rootIN, tracker, tree) 
	 	&& driver();

	void around() : adviceexecution() && (within(com.incompressor.PurgeRootAbstract) 
			 || within(com.incompressor.INCompressorAbstract)) 
			 && driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}