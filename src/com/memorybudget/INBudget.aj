package com.memorybudget;

import com.sleepycat.je.tree.IN;

import driver.Driver;

public privileged aspect INBudget extends INBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));

	pointcut monitorEntryMemorySizeChanges(int idx) : INBudgetAbstract.monitorEntryMemorySizeChanges(idx) && driver();

	pointcut setEntry(IN in, int idx) : INBudgetAbstract.setEntry(in, idx) && driver();

	pointcut monitorOverheadSizeChanges() : INBudgetAbstract.monitorOverheadSizeChanges() && driver();

	pointcut hookr_splitInternal_work2(IN in) : INBudgetAbstract.hookr_splitInternal_work2(in) && driver();

	pointcut trackProvisionalObsolete(IN in, IN child, long obsoleteLsn1,
			long obsoleteLsn2) : INBudgetAbstract.trackProvisionalObsolete(in, child, obsoleteLsn1,
					obsoleteLsn2) && driver();

	pointcut flushProvisionalObsolete(IN in) : INBudgetAbstract.flushProvisionalObsolete(in) && driver();
}