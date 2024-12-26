component output="false" {

	/**
	 * Initializes the component and integrates methods from Wheels.Global
	 */
	function init() {
		local.globalComponent = createObject("wheels.Global");
		$integrateFunctions(local.globalComponent);
		return this;
	}

	/**
	 * Dynamically mix methods from a given component into this component.
	 * Only public, non-inherited methods are added.
	 *
	 * @param componentInstance The component instance to integrate methods from.
	 */
	private function $integrateFunctions(required any componentInstance) {
			// Get metadata for the component
			local.methods = getMetaData(componentInstance);

			// Iterate over the functions in the component
			for (local.method in local.methods.functions) {
				local.functionName = local.method.name;
				local.excludeList = "get,controller";

				// Add only public, non-inherited methods excluding specific ones
				if (local.method.access == "public" && !listFindNoCase(local.excludeList, local.functionName)) {
					// Assign methods to `variables` and `this`
					variables[local.functionName] = componentInstance[local.functionName];
					this[local.functionName] = componentInstance[local.functionName];
				}
			}
	}

	include "/wheels/mapper/functions.cfm";

}
