package com.nio;

import java.io.File;
import com.sleepycat.je.dbi.EnvironmentImpl;
import driver.Driver;

public aspect NIOAspect extends NIOAbstract {
	
	pointcut driver() : if(new Driver().isActivated("nio"));
	
	pointcut fileManagerConstructor(EnvironmentImpl envImpl, File dbEnvHome,
			boolean readOnly) 
	: NIOAbstract.fileManagerConstructor(envImpl, dbEnvHome, readOnly) && driver();
}