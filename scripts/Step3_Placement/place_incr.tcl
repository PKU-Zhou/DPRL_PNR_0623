#####################################################################################
# Description:  Innovus Place Incremental Script
#####################################################################################

# 这一步是可选的，如果上一步的timing/drv等结果较好，可以跳过这一步

puts "--> 3.3 Place Incremental Start."

# 进行增量优化
place_opt_design -incremental -out_dir ../report/postPlace_incr -prefix ${TopName}_postPlace_incr

# 检查timing并提取报告
timeDesign -preCTS -outDir ../report/postPlace_incr -prefix ${TopName}_postPlace_incr
exec ../scripts/General/extract_report.csh ../report/postPlace_incr

# 保存设计
saveDesign ../backup/${TopName}_postPlace_incr.enc

puts "--> 3.3 Place Incremental Done."