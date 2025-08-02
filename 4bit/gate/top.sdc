###################################################################

# Created by write_sdc on Thu Aug  8 17:48:48 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_area 0
create_clock [get_ports clk]  -period 2.0e+07  -waveform {0 1.0e+07}
set_input_delay -clock clk  0  [get_ports clk]
set_input_delay -clock clk  0  [get_ports rst]
set_input_delay -clock clk  0  [get_ports in]
set_output_delay -clock clk  0  [get_ports out3]
set_output_delay -clock clk  0  [get_ports out2]
set_output_delay -clock clk  0  [get_ports out1]
set_output_delay -clock clk  0  [get_ports out0]
