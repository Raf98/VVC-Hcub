
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open DST7_16x16.vcd -vcd
probe -all -depth all -database DST7_16x16.vcd :DST7_ARCH_16
run
database -close DST7_16x16.vcd

