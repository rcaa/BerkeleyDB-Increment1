package com.io;

import java.io.File;
import com.sleepycat.je.dbi.EnvironmentImpl;

import driver.Driver;

public aspect IO extends IOAbstract {

	pointcut driver() : if(new Driver().isActivated("io"));

	pointcut fileManagerConstructor(EnvironmentImpl envImpl, File dbEnvHome,
			boolean readOnly) 
	 : IOAbstract.fileManagerConstructor(envImpl, dbEnvHome, readOnly) 
	 	&& driver();
}