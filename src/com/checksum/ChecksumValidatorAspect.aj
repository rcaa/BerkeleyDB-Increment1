package com.checksum;

import java.io.RandomAccessFile;

import com.sleepycat.je.dbi.EnvironmentImpl;
import com.sleepycat.je.log.FileManager;
import com.sleepycat.je.log.FileReader;

import driver.AroundAdvice;
import driver.Driver;

public privileged aspect ChecksumValidatorAspect extends ChecksumAbstract {

	pointcut driver() : if(new Driver().isActivated("checksum"));

	pointcut fileReaderConstructor(FileReader fileReader, EnvironmentImpl env) 
	 : ChecksumAbstract.fileReaderConstructor(fileReader, env) 
	  && driver();

	pointcut addPrevOffset(int entrySize) : ChecksumAbstract.addPrevOffset(entrySize) 
	 && driver();

	pointcut readNextEntry() : ChecksumAbstract.readNextEntry() 
	 && driver();

	pointcut readAndValidateFileHeader(RandomAccessFile newFile,
			String fileName, FileManager fm) 
	 : ChecksumAbstract.readAndValidateFileHeader(newFile, fileName, fm) 
	  && driver();

	void around() : adviceexecution() && within(com.checksum.ChecksumAbstract) 
	 && driver() && !@annotation(AroundAdvice) {
		proceed();
	}
}