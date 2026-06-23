TODO


# 1. (可选) 清除之前的 DRC 标记，保持视图干净
clearDrc

# 2. 配置 NanoRoute 的 ECO 模式
# 开启 ECO 绕线模式
setNanoRouteMode -route_with_eco true

# 开启深度搜索与修复，死磕顽固 DRC
setNanoRouteMode -route_detail_search_and_repair true

# 如果你想同时顺手修一下天线效应违例，可以打开这个 (看你的需求)
# setNanoRouteMode -route_antenna_diode_insertion true

# 关闭时序驱动绕线设置，专注于修复drc
setNanoRouteMode -route_with_timing_driven false
setNanoRouteMode -route_with_si_driven false
# 这个阶段时序以PT为准 不看Innovus的报告了

# 删除现有的RouteBlk
deleteRouteBlk -all
# 一开始就不用加RouteBlk

# 3. 执行 ECO 绕线 (更现代的专有命令，等同于配置好的 globalDetailRoute)
ecoRoute

timeDesign -postRoute -outDir ./report/fixDrc2/ -prefix fixDrc2
timeDesign -postRoute -hold -outDir ./report/fixDrc2/hold -prefix fixDrc2_hold

# 4. 重新验证 DRC
clearDrc
verify_drc -limit 99999 -report ./report/fixDrc2/verify_drc.rpt
verifyGeometry -report ./report/fixDrc2/verify_geometry.rpt


saveDesign ./save/fixDrc2.enc
