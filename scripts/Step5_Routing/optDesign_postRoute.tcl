# 修DRV之前先检查一下确定要不要修
# 如果是时钟树ICG模块的Fanout,这里不会修的，不要浪费时间
report_constraint -drv_violation_type max_fanout -all_violators > max_fanout_vio.rpt
optDesign -postRoute -drv			-outDir ./report/optDesign_postRoute1_drv/	    -prefix optDesign_postRoute1_drv
saveDesign ./save/optDesign_postRoute1_drv.enc

optDesign -postRoute -incr		-outDir ./report/optDesign_postRoute3_incr/			-prefix optDesign_postRoute3_incr
saveDesign ./save/optDesign_postRoute2_incr.enc

optDesign -postRoute -hold		-outDir ./report/optDesign_postRoute4_hold/			-prefix optDesign_postRoute4_hold
timeDesign -postRoute -hold		-outDir ./report/optDesign_postRoute4_hold/hold/	-prefix optDesign_postRoute4_hold
saveDesign ./save/optDesign_postRoute3_hold.enc

