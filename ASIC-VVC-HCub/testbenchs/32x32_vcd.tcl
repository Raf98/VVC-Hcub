
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open 32x32.vcd -vcd
probe -all -depth all -database 32x32.vcd :ARCH_32x32
run
database -close 32x32.vcd

