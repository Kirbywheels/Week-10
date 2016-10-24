// ==========================================================================

// Minimal Working Example - Dependent Sample T-Test Plot

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:/Users/`c(username)'/Desktop"
}

// ==========================================================================

// download data from UCLA ATS
use http://www.ats.ucla.edu/stat/stata/notes/hsb2, clear

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// dependent sample t-test
ttest read==write

// store value of t
local t = round(r(t),.001)

// store value of p
local p = round(r(p),.001)

// store mean, standard deviation, and n for read
local meanRead = r(mu_1)
local sdRead = r(sd_1)
local nRead = r(N_1)

// store mean, standard deviation, and n for write
local meanWrite = r(mu_2)
local sdWrite = r(sd_2)
local nWrite = r(N_2)

// ==========================================================================

// clear loaded dataset
clear

// create simple dataset for summary data
set obs 2

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create variables
generate cat = .
generate mean = .
generate sd = .
generate n = .

// add summary data for read
replace cat = 0 in 1
replace mean = `meanRead' in 1
replace sd = `sdRead' in 1
replace n = `nRead' in 1

// add summary data for write
replace cat = 1 in 2
replace mean = `meanWrite' in 2
replace sd = `sdWrite' in 2
replace n = `nWrite' in 2

// calculate standard error
generate se = sd/sqrt(n)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// simple serrbar example
serrbar mean se cat, scale(1.96) ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235")

graph export fig3a.png, as(png) width(1000) height(750) replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// complex serrbar example
serrbar mean se cat, scale(1.96) ///
	yscale(r(49.9 55.1)) ylabel(50(1)55, grid) ///
	ytitle("Mean Section Score") ///
	xscale(r(-.2 1.2)) ///
	xlabel(0 "Reading" 1 "Writing") xtitle("Test Section") ///
	scheme(s2mono) ///
	graphregion(color("235 235 235")) ///
	plotregion(color("255 255 255")) ///
	bgcolor("235 235 235") ///
	title("Dependent Sample T-Test: Standardized Testing") ///
	subtitle("Reading and Writing Sections") ///
	note("Results: {it:t} = `t', {it:p} = `p'") ///
	caption("Produced by Christopher Prener, Ph.D.; Data via UCLA ATS")

graph export fig3b.png, as(png) width(1000) height(750) replace

// ==========================================================================

exit
