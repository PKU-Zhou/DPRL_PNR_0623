

setNanoRouteMode	\
	-drouteFixAntenna               true \
	-drouteUseMultiCutViaEffort     high \
    -routeDesignRouteClockNetsFirst true \
   	-routeInsertAntennaDiode        true \
    -routeReserveSpaceForMultiCut   true \
   	-routeWithLithoDriven           false \
	-routeWithTimingDriven          true
	# Via 改成 High 让制造良率高一点
	# 预备Via的绕线空间


# set the native RC extraction mode
# engine:               possible value: preRoute | postRoute, default: preRoute
# effortLevel:          possible value: low | medium | high | signoff, default: low
setExtractRCMode    -engine                 postRoute \
                    -effortLevel            medium

# run routing or postroute via or wire optimization using the NanoRoute router
# # if specified without any arguments, it runs global and detail routing
 
# route_opt_design = routeDesign + optDesign -hold -setup

# man IMPOPT-6080 AAE-SI Optimization
# for optDesign
# 建议打开
setAnalysisMode -analysisType onChipVariation
setAnalysisMode -cppr both

route_opt_design -setup -hold



timeDesign -postRoute -outDir       ../report/postRoute/ -prefix ${TopName}_postRoute
timeDesign -postRoute -hold -outDir ../report/postRoute/ -prefix ${TopName}_postRoute_hold
exec ../scripts/General/extract_report.csh ../report/postRoute


saveDesign ../backup/${TopName}_postRoute.enc

