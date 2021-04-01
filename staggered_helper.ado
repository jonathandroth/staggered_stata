capture program drop staggered_helper
program staggered_helper, eclass
	// Syntax with varnames and estimand to match staggered package
	syntax , i(varlist) y(varlist) g(varlist) t(varlist) estimand(name) estimator(name) [eventTimeStart(numlist int max=1)] [eventTimeEnd(numlist int max=1)]
	
	// Set eventTimeStart/End to 0 if not provided
	if "`eventTimeStart'" == "" local eventTimeStart = 0
	if "`eventTimeEnd'" == "" local eventTimeEnd = 0
	
	// Call the staggered helper
	call_staggered_rcall, i(`i') y(`y') g(`g') t(`t') estimand(`estimand') estimator(`estimator') eventTimeStart(`eventTimeStart') eventTimeEnd(`eventTimeEnd')
	matrix b = r(b)'
	matrix vcv_raw = r(vcv_raw)
	matrix vcv_neyman = r(vcv_neyman)
	matrix results = r(results)
	
	//create column names for the variables------
	
	//If estimand = eventstudy, label eventstudy0 eventstudy1, etc.
	if "`estimand'" == "eventstudy"{
		local eventtimelabels ""
		forvalues i=`eventTimeStart'/`eventTimeEnd'{
			local eventtimelabels "`eventtimelabels' 'eventTime`i''"
		}
		local varlabels "`eventtimelabels'"
	}
	else{
	//Otherwise, label the (scalar) output with the name of the estimand
		local varlabels "'`estimand''"
	}	

	//label the coefs and vcv
	matrix colnames b = `varlabels'
	matrix colnames vcv_raw = `varlabels'
	matrix rownames vcv_raw = `varlabels'
	matrix colnames vcv_neyman = `varlabels'
	matrix rownames vcv_neyman = `varlabels'
	
	//label and print the result dataframe with estimates and ses
	matrix rownames results = `varlabels'
	matrix colnames results = 'estimate' 'se' 'se_neyman'	
	matrix list results
	
	ereturn post b vcv_raw
	ereturn matrix V_neyman = vcv_neyman
end


// print(outDF); /// prints just resultsDF
// print(out); /// prints all three outputs of staggered
