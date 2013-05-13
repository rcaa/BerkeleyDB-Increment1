package com.memorybudget;

import java.util.SortedMap;

import com.sleepycat.je.recovery.Checkpointer;

import driver.AroundAdvice;
import driver.Driver;

public privileged aspect CheckpointerBudget extends CheckpointerBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));

	pointcut hookr_doCheckpointInternal(Checkpointer cp, SortedMap dirtyMap) 
	 : CheckpointerBudgetAbstract.hookr_doCheckpointInternal(cp, dirtyMap) 
	 	&& driver();

	void around() : adviceexecution() &&  
			(within(com.memorybudget.CheckpointerBudgetAbstract) 
			|| within(com.memorybudget.CleanerBudgetAbstract) 
			|| within(com.memorybudget.CursorBudgetAbstract) 
			|| within(com.memorybudget.DINBINBudgetAbstract) 
			|| within(com.memorybudget.EvictorBudgetAbstract) 
			|| within(com.memorybudget.INBudgetAbstract) 
			|| within(com.memorybudget.INListBudgetAbstract) 
			|| within(com.memorybudget.LockBudgetAbstract) 
			|| within(com.memorybudget.LockManagerBudgetAbstract) 
			|| within(com.memorybudget.PreloaderBudgetAbstract) 
			|| within(com.memorybudget.TreeWalkerBudgetAbstract) 
			|| within(com.memorybudget.TxnBudgetAbstract) 
			|| within(com.memorybudget.WeaveMemoryBudgetAbstract)) 
			&& driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}