
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open DCT8_16x16.vcd -vcd
probe -all -depth all -database DCT8_16x16.vcd :DCT8_ARCH_16x16
run
database -close DCT8_16x16.vcd

