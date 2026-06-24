#####################################################################################
# Description:  Innovus Place Script
#####################################################################################

puts "--> 3.2 Place Start."


deleteTieHiLo -prefix "TIE"


place_opt_design

# 插入静态电平保护单元
setTieHiLoMode -cell "TIEHBWP7T30P140 TIELBWP7T30P140" -maxFanout 10 -maxDistance 20 -prefix "TIE"

addTieHiLo



# 检查timing并提取报告
timeDesign -preCTS -outDir ../report/postPlace -prefix ${TopName}_postPlace
exec ../scripts/General/extract_report.csh ../report/postPlace


# 保存设计
saveDesign ../backup/${TopName}_postPlace.enc

puts "--> 3.2 Place Done."