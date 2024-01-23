#### Template Script for RTL->Gate-Level Flow (generated from RC RC14.20 - v14.20-p005_1) 

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################


set DESIGN  DST7_DCT8_32x32
set SYN_EFF medium
###set MAP_EFF medium
set MAP_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set _OUTPUTS_PATH outputs_32x32#${DATE}
set _REPORTS_PATH reports_32x32#${DATE}
set _LOG_PATH logs_32x32#${DATE}
##set ET_WORKDIR <ET work directory>
set_attribute lib_search_path {. /cadence/Library/NangateOpenCellLib_45nm/Front_End/Liberty/CCS/  /cadence/Library/NangateOpenCellLib_45nm/Back_End/lef/} /
set_attribute hdl_search_path { ../DST7_DCT8_32x32 } /
set_attribute lp_power_unit mW /
#set_attribute script_search_path {. <path>} /
##Uncomment and specify machine names to enable super-threading.
##set_attribute super_thread_servers {<machine names>} /

##Default undriven/unconnected setting is 'none'.  
##set_attribute hdl_unconnected_input_port_value 0 | 1 | x | none /
##set_attribute hdl_undriven_output_port_value   0 | 1 | x | none /
##set_attribute hdl_undriven_signal_value        0 | 1 | x | none /


##set_attribute wireload_mode <value> /
set_attribute information_level 7 /

###############################################################
## Library setup
###############################################################

set_attribute library {NangateOpenCellLibrary_typical_ccs.lib}


## PLE
set_attribute lef_library { NangateOpenCellLibrary.tech.lef NangateOpenCellLibrary.lef}    
## Provide either cap_table_file or the qrc_tech_file
#set_attribute cap_table_file <file> /
#set_attribute qrc_tech_file <file> /
##generates <signal>_reg[<bit_width>] format
#set_attribute hdl_array_naming_style %s\[%d\] /  

## Power root attributes
set_attribute lp_insert_clock_gating true /
#set_attribute lp_clock_gating_prefix <string> /
#set_attribute lp_power_analysis_effort <high> /
#set_attribute lp_power_unit mW /
#set_attribute lp_toggle_rate_unit /ns /
## The attribute has set to default value "medium"
## you can try setting it to high to explore MVT QoR for low power optimization
set_attribute leakage_power_effort medium /


####################################################################
## Load Design
####################################################################


puts "Reading HDLs..."

read_hdl -vhdl {MCUHcub_DST7_DCT8_32x32.vhd DST7_DCT8_32x32.vhd}

elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
timestat Elaboration



check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

puts "Setting uo constraints..."
read_sdc ../scripts/constraints.sdc


#set_attribute force_wireload <wireload name> "/designs/$DESIGN"

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}

puts "The number of exceptions is [llength [find /designs/$DESIGN -exception *]]"
report timing -lint


################################################################################
## Power Directives
################################################################################

set_attribute lp_power_analysis_effort medium


build_rtl_power_models -clean_up_netlist -design $DESIGN


# Builds  detailed power models for more accurate RTL power analysis.


set_attribute lp_default_probability 0.5 $DESIGN 
set_attribute lp_default_toggle_rate 0.2 $DESIGN 
#set_attribute lp_asserted_toggle_rate 0.01  [find [find / -design $DESIGN] -port IN*]  
#set_attribute lp_asserted_toggle_rate 0.0  [find [find / -design $DESIGN] -port TAM*]  
#set_attribute lp_asserted_toggle_rate 0.00156 [find [find / -design $DESIGN] -port TAM*] 


###################################################################################
## Define cost groups (clock-clock, clock-output, input-clock, input-output)
###################################################################################

## Uncomment to remove already existing costgroups before creating new ones.
## rm [find /designs/* -cost_group *]

if {[llength [all::all_seqs]] > 0} { 
  define_cost_group -name I2C -design $DESIGN
  define_cost_group -name C2O -design $DESIGN
  define_cost_group -name C2C -design $DESIGN
  path_group -from [all::all_seqs] -to [all::all_seqs] -group C2C -name C2C
  path_group -from [all::all_seqs] -to [all::all_outs] -group C2O -name C2O
  path_group -from [all::all_inps]  -to [all::all_seqs] -group I2C -name I2C
}

define_cost_group -name I2O -design $DESIGN
path_group -from [all::all_inps]  -to [all::all_outs] -group I2O -name I2O
foreach cg [find / -cost_group *] {
  report timing -cost_group [list $cg] >> $_REPORTS_PATH/${DESIGN}_pretim.rpt
}
#######################################################################################
## Leakage/Dynamic power/Clock Gating setup.
#######################################################################################

#write_saif  -computed $DESIGN > $_REPORTS_PATH/output1.saif

#set_attribute lp_clock_gating_cell [find /lib* -libcell <cg_libcell_name>] "/designs/$DESIGN"
#set_attribute max_leakage_power 0.0 "/designs/$DESIGN"
#set_attribute lp_power_optimization_weight <value from 0 to 1> "/designs/$DESIGN"
#set_attribute max_dynamic_power <number> "/designs/$DESIGN"
## read_tcf <TCF file name>
## read_saif <SAIF file name>

puts "Generating .vcd file..."

shell irun -64 -v93 -top worklib.DST7_DCT8_32x32_TB ../DST7_DCT8_32x32/*.vhd ../testbenchs/DST7_DCT8_32x32_TB.vhd -input ../testbenchs/32x32_vcd.tcl -access +rw  > $_REPORTS_PATH/irun_32x32.log

puts "Reading .vcd file..."
#set_attribute find_takes_multiple_names  true
read_vcd -static -vcd_module DST7_DCT8_32x32 -module $DESIGN 32x32.vcd

#build_rtl_power_models -clean_up_netlist -design $DESIGN

puts "Ending .vcd file..."

#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_attribute optimize_merge_flops false /
##set_attribute optimize_merge_latches false /
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 



####################################################################################################
## Synthesizing to generic 
####################################################################################################


synthesize -to_generic -eff $SYN_EFF
puts "Runtime & Memory after 'synthesize -to_generic'"
timestat GENERIC
report datapath > $_REPORTS_PATH/${DESIGN}_datapath_generic.rpt
generate_reports -outdir $_REPORTS_PATH -tag generic
summary_table -outdir $_REPORTS_PATH

report area > $_REPORTS_PATH/${DESIGN}_area.rpt
report datapath > $_REPORTS_PATH/${DESIGN}_datapath_incr.rpt
report power > $_REPORTS_PATH/RC_power.log
report timing > $_REPORTS_PATH/RC_timing.log

write_saif  -computed $DESIGN > $_REPORTS_PATH/output_32x32.saif 


#### Build RTL power models
##build_rtl_power_models -design $DESIGN -clean_up_netlist [-clock_gating_logic] [-relative <hierarchical instance>]
#report power -rtl


####################################################################################################
## Synthesizing to gates
####################################################################################################

synthesize -to_mapped -eff $MAP_EFF -no_incr
puts "Runtime & Memory after 'synthesize -to_map -no_incr'"
timestat MAPPED
report datapath > $_REPORTS_PATH/${DESIGN}_datapath_map.rpt

foreach cg [find / -cost_group *] {
  report timing -cost_group [list $cg] > $_REPORTS_PATH/${DESIGN}_[basename $cg]_post_map.rpt
}
generate_reports -outdir $_REPORTS_PATH -tag map
summary_table -outdir $_REPORTS_PATH



##Intermediate netlist for LEC verification..
write_hdl -lec > ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v
write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

## ungroup -threshold <value>

#######################################################################################################
## Incremental Synthesis
#######################################################################################################

## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_attribute remove_assigns true /
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_attribute use_tiehilo_for_const <none|duplicate|unique> /

synthesize -to_mapped -eff high -incr
generate_reports -outdir $_REPORTS_PATH -tag incremental
summary_table -outdir $_REPORTS_PATH

puts "Runtime & Memory after incremental synthesis"
timestat INCREMENTAL

foreach cg [find / -cost_group *] {
  report timing -cost_group [list $cg] > $_REPORTS_PATH/${DESIGN}_[basename $cg]_post_incr.rpt
}


###################################################
## Spatial mode optimization
###################################################

## Uncomment to enable spatial mode optimization
##synthesize -to_mapped -spatial


######################################################################################################
## write Encounter file set (verilog, SDC, config, etc.)
######################################################################################################


##write_encounter design -basename <path & base filename> -lef <lef_file(s)>

report clock_gating > $_REPORTS_PATH/${DESIGN}_clockgating.rpt
report power -depth 0 > $_REPORTS_PATH/${DESIGN}_power.rpt
report gates -power > $_REPORTS_PATH/${DESIGN}_gates_power.rpt

##report qor > $_REPORTS_PATH/${DESIGN}_qor.rpt
report area > $_REPORTS_PATH/${DESIGN}_area.rpt
report datapath > $_REPORTS_PATH/${DESIGN}_datapath_incr.rpt
report messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
write_design -basename ${_OUTPUTS_PATH}/${DESIGN}_m
## write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
## write_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc


#################################
### write_do_lec
#################################


write_do_lec -golden_design ${_OUTPUTS_PATH}/${DESIGN}_intermediate.v -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
##write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do

puts "Final Runtime & Memory."
timestat FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

file copy [get_attr stdout_log /] ${_LOG_PATH}/.

#############################################################################
## Reports & Results
#############################################################################

report area -depth 3
report gates -power
report power -depth 2
report qor

##quit
