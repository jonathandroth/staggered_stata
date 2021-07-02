
capture program drop staggered_cs
program staggered_cs, eclass
	// Syntax with varnames and estimand to match staggered package
	capture syntax , i(varlist) y(varlist) g(varlist) t(varlist) estimand(name) [neverTreatedValue(numlist max=1) eventTimeStart(numlist int max=1)] [eventTimeEnd(numlist int max=1)]
	
	if _rc capture syntax , i(varlist) y(varlist) g(varlist) t(varlist) estimand(name) [neverTreatedValue(string) eventTimeStart(numlist int max=1)] [eventTimeEnd(numlist int max=1)]
	
	// Set eventTimeStart/End to 0 if not provided
	if "`eventTimeStart'" == "" local eventTimeStart = 0
	if "`eventTimeEnd'" == "" local eventTimeEnd = 0
	
	// Set neverTreatedValue to 321.4567, warn if that value is used in g already
	if "`neverTreatedValue'" == ""  {
		qui count if `g' == 321.4567
		if (`r(N)' == 0) {
			local neverTreatedValue = 321.4567
		} 
		else {
			di as error "Please transform g to avoid using the value 321.4567"
		}
	}
	
	// Call the staggered helper
	staggered_helper, i(`i') y(`y') g(`g') t(`t') estimand(`estimand') estimator("CS") neverTreatedValue(`neverTreatedValue') eventTimeStart(`eventTimeStart') eventTimeEnd(`eventTimeEnd')
	
	
end
