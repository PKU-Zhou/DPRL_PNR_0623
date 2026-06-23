TODO


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


set TopName dcim_wrapper
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

timeDesign -postRoute -outDir ./report/postRoute/ -prefix postRoute
timeDesign -postRoute -hold -outDir ./report/postRoute/hold/ -prefix postRoute
saveDesign ./save/route_opt_design.enc

# route_opt_design 应该是自带-hold -setup优化的，如果使用了routeDesign才需要手动加优化
# optDesign -postRoute -setup -hold	-outDir ./report/optDesign_postRoute1_setup_hold/	-prefix optDesign_postRoute1_setup_hold
# saveDesign ./save/optDesign_postRoute0_setup_hold.enc

# 修DRV之前先检查一下确定要不要修
# 如果是时钟树ICG模块的Fanout,这里不会修的，不要浪费时间
# report_constraint -drv_violation_type max_fanout -all_violators > max_fanout_vio.rpt
# optDesign -postRoute -drv			-outDir ./report/optDesign_postRoute1_drv/			-prefix optDesign_postRoute1_drv
# saveDesign ./save/optDesign_postRoute1_drv.enc

# optDesign -postRoute -incr		-outDir ./report/optDesign_postRoute3_incr/			-prefix optDesign_postRoute3_incr
# saveDesign ./save/optDesign_postRoute2_incr.enc

# optDesign -postRoute -hold		-outDir ./report/optDesign_postRoute4_hold/			-prefix optDesign_postRoute4_hold
# timeDesign -postRoute -hold		-outDir ./report/optDesign_postRoute4_hold/hold/	-prefix optDesign_postRoute4_hold
# saveDesign ./save/optDesign_postRoute3_hold.ecn

