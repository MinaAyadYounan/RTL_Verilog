###################################################################

# Created by write_sdc on Wed Aug  6 04:03:42 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_wire_load_model -name ForQA -library saed90nm_max
set_max_transition 0.5 [current_design]
set_max_capacitance 4 [current_design]
set_max_fanout 3 [current_design]
set_driving_cell -lib_cell NBUFFX2 -pin Z [get_ports rst]
set_driving_cell -lib_cell NBUFFX2 -pin Z [get_ports scan_clk]
set_driving_cell -lib_cell NBUFFX2 -pin Z [get_ports scan_rst]
set_driving_cell -lib_cell NBUFFX2 -pin Z [get_ports Test_Mode]
set_case_analysis 1 [get_ports Test_Mode]
create_clock [get_ports clock_func]  -period 5  -waveform {0 2.5}
set_clock_uncertainty -setup 0.03  [get_clocks clock_func]
set_clock_uncertainty -hold 0.02  [get_clocks clock_func]
set_max_transition 0.5 -data_path [get_clocks clock_func]
create_clock [get_ports scan_clk]  -period 100  -waveform {0 50}
group_path -name comp_paths  -to [get_clocks clock_func]
set_input_delay -clock clock_func  -max 1  [get_ports scan_clk]
set_input_delay -clock clock_func  -min 0  [get_ports scan_clk]
set_input_delay -clock clock_func  -max 1  [get_ports rst]
set_input_delay -clock clock_func  -min 0  [get_ports rst]
set_input_delay -clock clock_func  -max 1  [get_ports scan_rst]
set_input_delay -clock clock_func  -min 0  [get_ports scan_rst]
set_input_delay -clock clock_func  -max 1  [get_ports Test_Mode]
set_input_delay -clock clock_func  -min 0  [get_ports Test_Mode]
set_clock_groups  -physically_exclusive -name scan_clk_1  -group [get_clocks   \
scan_clk] -group [get_clocks clock_func]
