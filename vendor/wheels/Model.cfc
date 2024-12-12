component output="false" displayName="Model" extends="wheels.Global"{

	property name="Mixins" inject="id:Plugins";

	function init(){
		super.init();
		return this;
	}

	include "/wheels/model/functions.cfm";

	function onDIcomplete(){
		Mixins.$initializeMixins(variables);
	}
}
