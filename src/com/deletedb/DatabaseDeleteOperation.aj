package com.deletedb;

//DELETE DATABASE FEATURE

import com.sleepycat.je.cleaner.Cleaner;
import com.sleepycat.je.dbi.DatabaseImpl;
import com.sleepycat.je.tree.IN;
import driver.AroundAdvice;
import driver.Driver;

public privileged aspect DatabaseDeleteOperation extends DatabaseDeleteOperationAbstract {

	pointcut driver() : if(new Driver().isActivated("deleteDB"));

	pointcut hook_checkDeletedDb(DatabaseImpl db, Cleaner cleaner) 
	 : DatabaseDeleteOperationAbstract.hook_checkDeletedDb(db, cleaner) 
	 	&& driver();

	pointcut hook_isDbGone(DatabaseImpl db) : DatabaseDeleteOperationAbstract.hook_isDbGone(db) 
		&& driver();

	pointcut hook_getDbExistsEnvironment(DatabaseImpl database) 
	 : DatabaseDeleteOperationAbstract.hook_getDbExistsEnvironment(database) 
	 	&& driver();

	pointcut hook_checkDeletedEvictor(DatabaseImpl db, IN in) 
	 : DatabaseDeleteOperationAbstract.hook_checkDeletedEvictor(db, in) 
	 	&& driver();

	pointcut hook_getDbExistsINCompressor(DatabaseImpl database) 
	 : DatabaseDeleteOperationAbstract.hook_getDbExistsINCompressor(database) 
	 	&& driver();

	void around() : adviceexecution() && (within(com.deletedb.DatabaseDeleteOperationAbstract) 
	 || within(com.deletedb.TxnDeleteSupportAbstract)) && driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}