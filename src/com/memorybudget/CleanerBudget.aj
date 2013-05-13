package com.memorybudget;

import com.sleepycat.je.cleaner.FileProcessor;
import com.sleepycat.je.cleaner.PackedOffsets;
import com.sleepycat.je.cleaner.UtilizationProfile;
import com.sleepycat.je.cleaner.UtilizationTracker;

import driver.Driver;

public privileged aspect CleanerBudget extends CleanerBudgetAbstract {

	pointcut driver() : if(new Driver().isActivated("memoryBudget"));
	
	pointcut hookr_processFileInternal(FileProcessor cp,
			PackedOffsets obsoleteOffsets, long readBufferSize,
			int lookAheadCacheSize) : CleanerBudgetAbstract.hookr_processFileInternal(cp,
					obsoleteOffsets, readBufferSize, lookAheadCacheSize) 
					&& driver();

	pointcut lookAheadCacheConstructor(int lookAheadCacheSize) 
	 : CleanerBudgetAbstract.lookAheadCacheConstructor(lookAheadCacheSize) 
	 	&& driver();

	pointcut populateCache(UtilizationProfile up) : CleanerBudgetAbstract.populateCache(up) 
		&& driver();

	pointcut evictMemory(UtilizationTracker ut) : CleanerBudgetAbstract.evictMemory(ut) 
		&& driver();
}
