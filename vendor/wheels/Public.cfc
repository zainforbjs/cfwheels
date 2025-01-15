component output="false" displayName="Internal GUI" {

	/**
	 * Internal function.
	 */
	public struct function $init() {
		return this;
	}

	/*
	This is just a proof of concept
	*/
	function index() {
		include "/wheels/public/views/congratulations.cfm";
		return "";
	}
	function info() {
		include "/wheels/public/views/info.cfm";
		return "";
	}
	function routes() {
		include "/wheels/public/views/routes.cfm";
		return "";
	}
	function routetester(verb, path) {
		include "/wheels/public/helpers.cfm";
		include "/wheels/public/views/routetester.cfm";
		return "";
	}
	function routetesterprocess(verb, path) {
		include "views/routetesterprocess.cfm";
		return "";
	}
	function docs() {
		include "/wheels/public/helpers.cfm";
		include "/wheels/public/views/docs.cfm";
		return "";
	}
	function runner(){
		include "/wheels/public/views/runner.cfm";
		return "";
	}
	function packages() {
		include "/wheels/public/views/packages.cfm";
		return "";
	}
	function tests() {
		include "/wheels/public/views/tests.cfm";
		return "";
	}
	function migrator() {
		include "/wheels/public/views/migrator.cfm";
		return "";
	}
	function migratortemplates() {
		include "/wheels/public/views/templating.cfm";
		return "";
	}
	function migratortemplatescreate() {
		include "/wheels/public/migrator/templating.cfm";
		return "";
	}
	function migratorcommand() {
		include "/wheels/public/migrator/command.cfm";
		return "";
	}
	function migratorsql() {
		include "/wheels/public/migrator/sql.cfm";
		return "";
	}
	function cli() {
		include "/wheels/public/views/cli.cfm";
		return "";
	}
	function plugins() {
		include "/wheels/public/views/plugins.cfm";
		return "";
	}
	function pluginentry() {
		include "/wheels/public/views/pluginentry.cfm";
		return "";
	}
	function build() {
		setting requestTimeout=10000 showDebugOutput=false;
		zipPath = $buildReleaseZip();
		$header(name = "Content-disposition", value = "inline; filename=#GetFileFromPath(zipPath)#");
		$content(file = zipPath, type = "application/zip", deletefile = true);
		return "";
	}

	/*
		Check for legacy urls and params
		Example Strings to test against
		?controller=wheels&action=wheels&
			view=routes
			view=docs
			view=build
			view=migrate
			view=cli

			// Packages
			view=packages&type=core
			view=packages&type=app
			view=packages&type=[PLUGIN]

			// Test Runnner
			view=tests&type=core
			view=tests&type=app
			view=tests&type=[PLUGIN]
		*/
	function wheels() {
		local.action = StructKeyExists(request.wheels.params, "action") ? request.wheels.params.action : "";
		local.view = StructKeyExists(request.wheels.params, "view") ? request.wheels.params.view : "";
		local.type = StructKeyExists(request.wheels.params, "type") ? request.wheels.params.type : "";
		switch (local.view) {
			case "routes":
			case "docs":
			case "cli":
			case "tests":
			case "testbox":
				include "/wheels/public/views/#local.view#.cfm";
				break;
			case "packages":
				include "/wheels/public/views/packages.cfm";
				break;
			case "migrate":
				include "/wheels/public/views/migrator.cfm";
				break;
			default:
				include "/wheels/public/views/congratulations.cfm";
				break;
		}
		return "";
	}

}
