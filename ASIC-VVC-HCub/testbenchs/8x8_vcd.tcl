
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open 8x8.vcd -vcd
probe -all -depth all -database 8x8.vcd :ARCH_8x8
run
database -close 8x8.vcd

