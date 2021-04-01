{smcl}
{title:Title}
 
{phang}
{cmd:staggered} {hline 2} {bf:staggered} belongs to {help staggered_stata} package. It implements the efficient estimator in Roth & Sant'Anna (2020) for staggered rollout designs with random timing. The R package staggered is called via rcall. See the {browse "https://github.com/jonathandroth/staggered":staggered webpage} for more information.


{title:Example(s)}

    Estimate the efficient estimator
	
        {bf:. staggered, y("y") t("t") g("g") i("i") estimand("eventstudy") eventTimeStart(-5) eventTimeEnd(5)}
        {bf:. staggered, y("y") t("t") g("g") i("i") estimand("simple")}


{title:Authors}

{p 4 4 2}
{bf:Jonathan Roth, Pedro H.C. Sant'Anna, James Brand}       {break}

{hline}