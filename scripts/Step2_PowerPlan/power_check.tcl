#####################################################################################
# Description:  Innovus Power Check Script
#####################################################################################

puts "--> 2.6 Power Check Start."

verify_drc -limit 99999                                -report ../report/postPowerplan/verify_drc.rpt 
verifyConnectivity -net {VDD_MXU VSS_MXU} -error 99999 -report ../report/postPowerplan/verify_connectivity.rpt
verify_PG_short -net {VDD_MXU VSS_MXU}                 -report ../report/postPowerplan/verify_pgshort.rpt

# 检查timing并提取报告
timeDesign  -outDir ../report/postPowerplan -prePlace

exec ../scripts/General/extract_report.csh ../report/postPowerplan

puts "--> 2.6 Power Check Done."