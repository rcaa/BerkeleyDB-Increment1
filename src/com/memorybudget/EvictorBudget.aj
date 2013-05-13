package com.memorybudget;

import com.evictor.Evictor;
import com.sleepycat.je.tree.IN;

import driver.Driver;

public privileged aspect EvictorBudget extends EvictorBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));
	
	pointcut isRunnable(Evictor evictor, String source) 
	 : EvictorBudgetAbstract.isRunnable(evictor, source) && driver();

	pointcut hook_getSize(IN renewedChild) 
	 : EvictorBudgetAbstract.hook_getSize(renewedChild) && driver();
}
