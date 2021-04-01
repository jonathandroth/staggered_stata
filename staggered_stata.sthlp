{smcl}
{it:v. 1.0.0}


{title:staggered_stata}

{p 4 4 2}
{title:Description}

{bf:staggered_stata} is a program for estimating treatment effects in settings with staggered rollouts. It implements three estimators, the efficient estimator under random timing proposed in Roth & Sant'Anna (2021), via the {help staggered} command; the generalized difference-in-differences estimator (using not-yet-treated units as the control) in Callaway & Sant'Anna (2020) via the {help staggered_cs} command; and the generalized difference-in-differences estimator (using last-to-be-treated or never-treated units as the control) in Sun & Abraham (2020) via the {help staggered_sa} command.
{space 1}You can read more about the package on the {browse "https://github.com/jonathandroth/staggered":staggered webpage}.
