{smcl}
{title:Title}
 
{phang}
{cmd:staggered} {hline 2} {bf:staggered} belongs to the {help staggered_stata} package. The {bf:staggered} function implements the efficient estimator in Roth & Sant'Anna (2020) for staggered rollout designs with random timing. The R package staggered is called via rcall. See the {browse "https://github.com/jonathandroth/staggered":staggered webpage} for more information.

{title:Syntax}

{p 8 17 2}
{cmd:staggered}, y({help varlist}) g({help varlist}) t({help varlist}) i({help varlist}) estimand({help name}) [neverTreatedValue({help numlist} or {help string}) eventTimeStart({help numlist}) eventTimeEnd({help numlist})]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt y}} The outcome variable.{p_end}
{synopt:{opt g}} The variable indicating the time at which units where first treated (g=infitnity denotes never treated).{p_end}
{synopt:{opt t}} The variable indicating the time period for the panel.{p_end}
{synopt:{opt estimand}} The estimand. Options are 'simple', 'cohort', 'calendar', 'eventstudy' for simple-weighted, calendar-weighted, and cohort-weighted averageas and event-study parameters. See Roth & Sant'Anna or the {browse "https://github.com/jonathandroth/staggered":staggered webpage} for additional details.{p_end}
{synopt:{opt eventTimeStart},{opt eventTimeEnd}} If estimand is 'eventstudy', the event-study parameters are returned for relative time eventTimeStart to eventTimeEnd, where 0 denotes the instantaneous effect. (Positive numbers are periods after treatment).{p_end}
{synopt:{opt neverTreatedValue}} If some units are never treated, this option can be used to indicate the value of g which marks these observations. This value can be either a number or a period, the latter indicating that never treated units are missing values of g. {p_end}

{synoptline}
{p2colreset}{...}
{p 4 6 2}


{title:Example(s)}

    Estimate the efficient estimator for an outcome y, with time variable t, first-treated variable g, and identifier i.
	
        {bf:. staggered, y("y") t("t") g("g") i("i") estimand("eventstudy") eventTimeStart(-5) eventTimeEnd(5)}
        {bf:. staggered, y("y") t("t") g("g") i("i") estimand("simple")}
	{bf:. staggered, y("y") t("t") g("g") i("i") estimand("simple") neverTreatedValue(72)} 
	{bf:. staggered, y("y") t("t") g("g") i("i") estimand("simple") neverTreatedValue(.)} 

{title:Authors}

{p 4 4 2}
{bf:Jonathan Roth, Pedro H.C. Sant'Anna, James Brand}       {break}

{hline}