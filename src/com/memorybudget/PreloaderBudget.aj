package com.memorybudget;

import com.sleepycat.je.PreloadConfig;
import com.sleepycat.je.dbi.DatabaseImpl;
import com.sleepycat.je.dbi.DatabaseImpl.PreloadProcessor;

import driver.Driver;

public privileged aspect PreloaderBudget extends PreloaderBudgetAbstract {
	
	pointcut driver() : if(new Driver().isActivated("memoryBudget"));
	
	pointcut preloadLSNTreeWalkerConstructor(DatabaseImpl db, PreloadProcessor pp, PreloadConfig config) 
	: PreloaderBudgetAbstract.preloadLSNTreeWalkerConstructor(db, pp, config) && driver();
}