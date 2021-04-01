
capture program drop staggered_sa
program staggered_sa, eclass
	// Syntax with varnames and estimand to match staggered package
	syntax , i(varlist) y(varlist) g(varlist) t(varlist) estimand(name) [eventTimeStart(numlist int max=1)] [eventTimeEnd(numlist int max=1)]
	
	// Set eventTimeStart/End to 0 if not provided
	if "`eventTimeStart'" == "" local eventTimeStart = 0
	if "`eventTimeEnd'" == "" local eventTimeEnd = 0
	
	// Call the staggered helper
	staggered_helper, i(`i') y(`y') g(`g') t(`t') estimand(`estimand') estimator("SA") eventTimeStart(`eventTimeStart') eventTimeEnd(`eventTimeEnd')
	
	
end
