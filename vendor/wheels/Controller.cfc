component output="false" displayName="Controller" extends="wheels.Global"{

	property name="Mixins" inject="id:Plugins";

	function init(){
		return this;
	}

	include "/wheels/controller/functions.cfm";
	include "/wheels/view/functions.cfm";
	if (
		IsDefined("application")
		&& StructKeyExists(application, "wheels")
		&& StructKeyExists(application.wheels, "viewPath")
	) {
		include "/wheels/tests/_assets/views/helpers.cfm";
	}

	function onDIcomplete(){
		Mixins.$initializeMixins(variables);
	}
}
