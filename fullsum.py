import sys
import os

# Function to find and extract information from area report file
def extract_area_info(folder_path, time):
    area_file_path = os.path.join(folder_path, "reports", "top_"+time+"000000.0ns.area.rpt")
    
    if os.path.exists(area_file_path):
        with open(area_file_path, 'r') as area_file:
            for line in area_file:
                if "Total cell area:" in line:
                    total_area = float(line.split(":")[-1].strip())
                    total_area = total_area / (10**6) #convert to mm2
                    print(f"Total area: {total_area} mm2")
                    break

# Function to find and extract power information from power report file
def extract_power_info(folder_path, time):
    power_file_path = os.path.join(folder_path, "reports", "top_"+time+"000000.0ns.power.rpt")
    
    if os.path.exists(power_file_path):
        power_values = []
        with open(power_file_path, 'r') as power_file:
            for line in power_file:
                if "Total  " in line:
                    values = line.split()
                    power_values.extend([f"{value} {unit}" for value, unit in zip(values[1::2], values[2::2])])
                    break
        
        if power_values:
            print(", ".join(power_values))

# Function to find and extract information from area report file
def extract_time_info(folder_path, time):
    time_file_path = os.path.join(folder_path, "reports", "top_"+time+"000000.0ns.timing.rpt")
    
    if os.path.exists(time_file_path):
        with open(time_file_path, 'r') as time_file:
            for line in time_file:
                if "slack" in line:
                    if "VIOLATED" in line:
                        needed_time = (float(line.split(")")[-1].strip()))*(-1)
                        needed_time = needed_time / (10**6) #convert to ms
                        print("Timing is not met, you should at least increase time by "+ str(needed_time) + "ms")
                    else:
                        extra_time = float(line.split(")")[-1].strip())
                        extra_time = extra_time / (10**6) #convert to ms
                        print("Timing is met, you can decrease time by "+ str(extra_time) + "ms")
                    break

# Define a function to parse the Verilog file and extract instantiated gate information within a module
def find_instantiated_gates(verilog_file):
    instantiated_gates = {}
    inside_module = False
    
    with open(verilog_file, 'r') as file:
        for line in file:
            if line.startswith("module"):
                inside_module = True
            elif line.startswith("endmodule"):
                inside_module = False
            elif inside_module and line.strip() and not line.startswith("//") and not line.startswith("`"):
                gate_name = line.split()[0]
                if gate_name in ["input", "output", "wire", "reg"]:
                    continue
                elif gate_name[0] == "n":
                    continue
                elif gate_name not in instantiated_gates:
                    instantiated_gates[gate_name] = 1
                else:
                    instantiated_gates[gate_name] += 1
    return instantiated_gates


# Main function to orchestrate the process
def main(args):
    folder_path = args[0]
    time = args[1]
    # enter the folder that you want to get a summary of, time should be in ms.
    
    extract_area_info(folder_path, time)
    print("Internal Power, Switching Power, Leakage Power, Total Power")
    extract_power_info(folder_path, time)
    
    extract_time_info(folder_path, time)
    
    print("")
    print("")
    
    # Provide the path to the synthesized Verilog file
    verilog_file_path = "./"+args[0]+"/gate/top.sv"

    # Call the function to find instantiated gates within the module
    instantiated_gates_count = find_instantiated_gates(verilog_file_path)

    # Display the number of each instantiated gate within the module
    for gate, count in instantiated_gates_count.items():
        print(f"Number of {gate} gates instantiated: {count}")

# Run the main function
if __name__ == "__main__":
    main(sys.argv[1:])

