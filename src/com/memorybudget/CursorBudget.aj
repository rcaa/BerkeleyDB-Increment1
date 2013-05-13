package com.memorybudget;

import com.sleepycat.je.tree.BIN;
import com.sleepycat.je.tree.LN;

import driver.Driver;

public privileged aspect CursorBudget extends CleanerBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));
	
	pointcut hook_lnDeleteOrhook_lnModify(BIN targetBin, LN ln) 
	 : CursorBudgetAbstract.hook_lnDeleteOrhook_lnModify(targetBin, ln) && driver();
}