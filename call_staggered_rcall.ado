capture program drop call_staggered_rcall
program call_staggered_rcall, rclass
	// Syntax with varnames and estimand to match staggered package
	syntax , i(varlist) y(varlist) g(varlist) t(varlist) estimand(name) estimator(name) [eventTimeStart(numlist int max=1)] [eventTimeEnd(numlist int max=1)]
	
	//[eventTime(numlist int max=1)]
	
	//set eventTime to zero if not-specified
	if "`eventTimeStart'" == "" local eventTimeStart = 0
	if "`eventTimeEnd'" == "" local eventTimeEnd = 0
	
	//Check that rcall is installed
	capture findfile rcall.ado
	if _rc != 0 {
	 display as error "rcall package must be installed"
	 error 198
	}
	
	//run rcall_check to make sure that R is installed (v >=3.50) and rcall installed
	rcall_check,  rversion(3.50)

	//re-run rcall_check checking that the staggered package is installed
	 //if not, capture error and install the package
	capture rcall_check staggered>=1.0
	if _rc != 0{
		display "Installing devtools and staggered packages in R" 
		rcall vanilla: install.packages("devtools", repos="http://cran.us.r-project.org")
		rcall vanilla: devtools::install_github("jonathandroth/staggered@main")
	} 

	scalar str = "`estimand'"
	scalar estimator = "`estimator'"
	scalar eventTimeStart = "`eventTimeStart'"
	scalar eventTimeEnd = "`eventTimeEnd'"
	
	preserve
	// Reduce data to four necessary variables, rename to be
		// consistent with staggered notation
	qui keep `i' `y' `g' `t'
	
	qui rename `i' i
	qui rename `y' y
	qui rename `g' g
	qui rename `t' t
			
	if "`estimator'" == "efficient"{
	// Interactive mode in rcall
	rcall vanilla: 							///
		rm(); ///
		library(staggered); library(dplyr); ///
		data = data.frame(st.data());   ///
		out = staggered(df = data, estimand = st.scalar(str), eventTime = st.scalar(eventTimeStart):st.scalar(eventTimeEnd), return_full_vcv = T); ///
		outDF = data.frame(out[[1]]); /// out[1] = out$resultsDF
		vcv_raw = as.matrix(out[[2]]); /// out[2] = out$vcv
		vcv_neyman = as.matrix(out[[3]]); /// out[3] = out$vcv_neyman
		///results = as.matrix(unlist(ifelse(st.scalar(eventTimeStart)==st.scalar(eventTimeEnd), list(cbind(outDF[,1], outDF[,2] , outDF[,3] )), list(cbind(outDF[,1], outDF[,2] , outDF[,3], outDF[,4] )) ); ///
		results = as.matrix(cbind(outDF[,1], outDF[,2] , outDF[,3] )); ///
		b = as.matrix(cbind(outDF[,1])); ///
		rm(out); rm(data); rm(outDF);
	}
	
	if "`estimator'" == "CS"{
	// Interactive mode in rcall
	rcall vanilla: 							///
		rm(); ///
		library(staggered); library(dplyr); ///
		data = data.frame(st.data());   ///
		out = staggered_cs(df = data, estimand = st.scalar(str), eventTime = st.scalar(eventTimeStart):st.scalar(eventTimeEnd), return_full_vcv = T); ///
		outDF = data.frame(out[[1]]); /// out[1] = out$resultsDF
		vcv_raw = as.matrix(out[[2]]); /// out[2] = out$vcv
		vcv_neyman = as.matrix(out[[3]]); /// out[3] = out$vcv_neyman
		///results = as.matrix(unlist(ifelse(st.scalar(eventTimeStart)==st.scalar(eventTimeEnd), list(cbind(outDF[,1], outDF[,2] , outDF[,3] )), list(cbind(outDF[,1], outDF[,2] , outDF[,3], outDF[,4] )) ); ///
		results = as.matrix(cbind(outDF[,1], outDF[,2] , outDF[,3] )); ///
		b = as.matrix(cbind(outDF[,1])); ///
		rm(out); rm(data); rm(outDF);
	}
	
	if "`estimator'" == "SA"{
	// Interactive mode in rcall
	rcall vanilla: 							///
		rm(); ///
		library(staggered); library(dplyr); ///
		data = data.frame(st.data());   ///
		out = staggered_sa(df = data, estimand = st.scalar(str), eventTime = st.scalar(eventTimeStart):st.scalar(eventTimeEnd), return_full_vcv = T); ///
		outDF = data.frame(out[[1]]); /// out[1] = out$resultsDF
		vcv_raw = as.matrix(out[[2]]); /// out[2] = out$vcv
		vcv_neyman = as.matrix(out[[3]]); /// out[3] = out$vcv_neyman
		///results = as.matrix(unlist(ifelse(st.scalar(eventTimeStart)==st.scalar(eventTimeEnd), list(cbind(outDF[,1], outDF[,2] , outDF[,3] )), list(cbind(outDF[,1], outDF[,2] , outDF[,3], outDF[,4] )) ); ///
		results = as.matrix(cbind(outDF[,1], outDF[,2] , outDF[,3] )); ///
		b = as.matrix(cbind(outDF[,1])); ///
		rm(out); rm(data); rm(outDF);
	}

	// Pass results back to Stata
	return add
	restore
end


// print(outDF); /// prints just resultsDF
// print(out); /// prints all three outputs of staggered
