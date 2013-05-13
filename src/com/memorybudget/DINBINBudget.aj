package com.memorybudget;

import com.sleepycat.je.tree.ChildReference;
import com.sleepycat.je.tree.DIN;
import com.sleepycat.je.tree.IN;

import driver.Driver;

public privileged aspect DINBINBudget extends DINBINBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));

	pointcut updateDupCountLNOrupdateDupCountLNRefAndNullTarget(DIN din) 
	 : DINBINBudgetAbstract.updateDupCountLNOrupdateDupCountLNRefAndNullTarget(din) && driver();

	pointcut fetchTarget(IN in, ChildReference cr) : DINBINBudgetAbstract.fetchTarget(in, cr) && driver();
}