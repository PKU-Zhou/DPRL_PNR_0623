# 修复DRC的脚本

# 修复DRC 不是一个 用脚本一键运行就可以完成的步骤，
# 极其依赖人的交互式操作
# 该脚本只提供常见命令
# 不要直接运行！！！
# 不要直接运行！！！
# 不要直接运行！！！




# 开始之前，先看一眼DRC报告
verify_drc -limit 99999 -report ./report/Route/verify_drc.rpt


# 这个阶段时序以PT为准 不看Innovus的报告了

# Step1. 工具全局自动修drc
# 执行 ECO 绕线 (更现代的专有命令，等同于配置好的 globalDetailRoute)
ecoRoute -fix_drc

# Step2. 手动删除DRC报错net，再ecoRoute，此时不能加-fix_drc
ecoRoute

# Step3. 手动删除DRC报错net，手动增加RouteBlk，再ecoRoute，此时不能加-fix_drc
# 删除之前加上去的RouteBlk
deleteRouteBlk -all
ecoRoute

# 重新验证 DRC
clearDrc
verify_drc -limit 99999 -report ../report/postRoute/verify_drc.rpt


# 保存设计
saveDesign ../backup/${TopName}_fixDrc.enc
