package com.memorybudget;

import com.sleepycat.je.dbi.DbConfigManager;
import com.sleepycat.je.dbi.EnvironmentImpl;
import driver.Driver;

public privileged aspect WeaveMemoryBudget extends WeaveMemoryBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));

	pointcut logBufferBudgetConstructor(EnvironmentImpl env,
			DbConfigManager configManager) : WeaveMemoryBudgetAbstract.logBufferBudgetConstructor(env, configManager) && driver();
}