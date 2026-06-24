optDesign -postCTS -drv -outDir ../report/postCTS_opt/ -prefix ${TopName}_postCTS_opt1_drv
saveDesign ../backup/${TopName}_postCTS_opt1_drv.enc

optDesign -postCTS -incr -outDir ../report/postCTS_opt/ -prefix ${TopName}_postCTS_opt2_incr
saveDesign ../backup/${TopName}_postCTS_opt2_incr.enc

optDesign -postCTS -hold -outDir ../report/postCTS_opt/ -prefix ${TopName}_postCTS_opt3_hold
timeDesign -postCTS -hold -outDir ../report/postCTS_opt/ -prefix ${TopName}_postCTS_opt3_hold
exec ../scripts/General/extract_report.csh ../report/postCTS_opt/

saveDesign ../backup/${TopName}_postCTS_opt3_hold.enc