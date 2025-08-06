
create_clock -name clock_func  -period 5 -waveform {0 2.5}  [get_ports clock_func ]
# --- Clock uncertainty Berfore CTS  uncertainty = Jitter + Source Latency  + Network Latency 
set_clock_uncertainty -setup 0.03  [get_clocks clock_func]  ;  # Consider Skew + Jitter 
set_clock_uncertainty -hold  0.02  [get_clocks clock_func]  ;  # only Consider Skew   


set_input_delay  -clock clock_func -max 1  [remove_from_collection [all_inputs] [get_ports {clock_func}]]
set_input_delay  -clock clock_func -min 0  [remove_from_collection [all_inputs] [get_ports {clock_func}]]

set_dont_touch_network [get_clocks {clock_func}]

group_path -name "comp_paths" -to {clock_func}
set_app_var compile_ultra_ungroup_dw false
set_wire_load_model  -name ForQA

# set_max_area 0.0 
set_max_transition 0.5 [current_design]
set_max_transition 0.5 -data_path [get_clocks clock_func]

set_max_capacitance 4.0 [current_design]
set_max_fanout 6 $design 




set_driving_cell -lib_cell NBUFFX2 -pin Z [remove_from_collection [all_inputs] [get_ports {clock_func}]];

set_dont_use [get_lib_cells */AOI221X1]
#set_dont_use [get_lib_cells */OAI221X1]
set_dont_use [get_lib_cells */AOI221X2]
set_dont_use [get_lib_cells */NBUFFX4]




