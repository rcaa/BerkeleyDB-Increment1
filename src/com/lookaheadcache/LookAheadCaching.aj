package com.lookaheadcache;

import java.util.Map;

import com.sleepycat.je.cleaner.FileProcessor;
import com.sleepycat.je.cleaner.LNInfo;
import com.sleepycat.je.tree.TreeLocation;

import driver.AroundAdvice;
import driver.Driver;

public privileged aspect LookAheadCaching extends LookAheadCacheAbstract percflow(processFile(*))  {

	pointcut driver() : if(new Driver().isActivated("lookAheadCache"));
	
	pointcut processLN(Long fileNum, TreeLocation location, Long offset,
			LNInfo info, Map map, FileProcessor fp) 
		: LookAheadCacheAbstract.processLN(fileNum, location, offset,
					info, map, fp) 
					&& driver();

	void around() : adviceexecution() && within(com.lookaheadcache.LookAheadCacheAbstract) 
	 && driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}