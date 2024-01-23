
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open 16x16.vcd -vcd
probe -all -depth all -database 16x16.vcd :ARCH_16x16
run
database -close 16x16.vcd

