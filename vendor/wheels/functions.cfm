<cfscript>
    // This file is included from Application.cfc in the root folder.
    
    // Put variables we just need internally inside a wheels struct.
	this.wheels = {};
	this.wheels.rootPath = GetDirectoryFromPath(GetBaseTemplatePath());

	this.name = createUUID();
	// Give this application a unique name by taking the path to the root and hashing it.
	// this.name = Hash(this.wheels.rootPath);

	this.bufferOutput = true;

	// Set up the application paths.
	this.appDir     = expandPath("app/");
	this.vendorDir  = expandPath("vendor/");
	this.wheelsDir  = this.vendorDir & "wheels/";
	this.wireboxDir = this.vendorDir & "wirebox/";
	this.testboxDir = this.vendorDir & "testbox/";

	// Set up the mappings for the application.
	this.mappings["/app"]     = this.appDir;
	this.mappings["/vendor"]  = this.vendorDir;
	this.mappings["/wheels"]  = this.wheelsDir;
	this.mappings["/wirebox"] = this.wireboxDir;
	this.mappings["/testbox"] = this.testboxDir;
	this.mappings["/tests"] = expandPath("tests/");
  
	// We turn on "sessionManagement" by default since the Flash uses it.
	this.sessionManagement = true;

	// If a plugin has a jar or class file, automatically add the mapping to this.javasettings.
	this.wheels.pluginDir = this.appDir & "plugins";
	this.wheels.pluginFolders = DirectoryList(
		this.wheels.pluginDir,
		"true",
		"path",
		"*.class|*.jar|*.java"
	);

	for (this.wheels.folder in this.wheels.pluginFolders) {
		if (!StructKeyExists(this, "javaSettings")) {
			this.javaSettings = {};
		}
		if (!StructKeyExists(this.javaSettings, "LoadPaths")) {
			this.javaSettings.LoadPaths = [];
		}
		this.wheels.pluginPath = GetDirectoryFromPath(this.wheels.folder);
		if (!ArrayFind(this.javaSettings.LoadPaths, this.wheels.pluginPath)) {
			ArrayAppend(this.javaSettings.LoadPaths, this.wheels.pluginPath);
		}
	}

	// Put environment vars into env struct
	if ( !structKeyExists(this,"env") ) {
		this.env = {};
		envFilePath = this.appDir & ".env";
		if (fileExists(envFilePath)) {
			envStruct = {};

			envFile = fileRead(envFilePath);
			if (isJSON(envFile)) {
				envStruct = deserializeJSON(envFile);
			}
			else { // assume it is a .properties file
				properties = createObject('java', 'java.util.Properties').init();
				properties.load(CreateObject('java', 'java.io.FileInputStream').init(envFilePath));
				envStruct = properties;
			}

			// Append to env struct
			for (key in envStruct) {
				this.env["#key#"] = envStruct[key];
			}
		}
	}
    
    // Include developer's app config so they can set their own variables in this scope (or override "sessionManagement").
    // Include Wheels controller and global functions.
    // Include Wheels event functions (which in turn includes the developer's event files).
    include "/app/config/app.cfm";
    include "controller/appfunctions.cfm";
    include "global/appfunctions.cfm";
    include "events/onapplicationend.cfm";
    include "events/onapplicationstart.cfm";
    include "events/onerror.cfm";
    include "events/onabort.cfm";
    include "events/onmissingtemplate.cfm";
    include "events/onsessionend.cfm";
    include "events/onsessionstart.cfm";
    include "events/onrequest.cfm";
    include "events/onrequestend.cfm";
    include "events/onrequeststart.cfm";
	
</cfscript>