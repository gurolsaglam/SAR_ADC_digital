//Digital block for 4-bit SAR-ADC
//guerol.saglam@kit.edu
//the clock input here needs to be 5 times faster than the sampler block of the ADC (the block that comes before the comparator).
//
// inputs are clk, rst and in, outputs are out3, out2, out1 and out0,
// the rest are internal signals.
//
// Truth Table (the design works with rising edge of clock):
// rst | in | done | out3 | out2 | out1 | out0 | out3Next | out2Next | out1Next | out0Next | doneNext
//----------------------------------------------------------------------------------------------------
//   0 |  x |    x |    x |    x |    x |    x |        1 |        0 |        0 |        0 |        0
//   1 |  x |    1 |    x |    x |    x |    x |        1 |        0 |        0 |        0 |        0
//----------------------------------------------------------------------------------------------------
//   1 |  0 |    0 |    0 |    0 |    0 |    0 |        x |        x |        x |        x |        x
//   1 |  0 |    0 |    0 |    0 |    0 |    1 |        0 |        0 |        0 |        0 |        1
//   1 |  0 |    0 |    0 |    0 |    1 |    0 |        0 |        0 |        0 |        1 |        0
//   1 |  0 |    0 |    0 |    0 |    1 |    1 |        0 |        0 |        1 |        0 |        1
//   1 |  0 |    0 |    0 |    1 |    0 |    0 |        0 |        0 |        1 |        0 |        0
//   1 |  0 |    0 |    0 |    1 |    0 |    1 |        0 |        1 |        0 |        0 |        1
//   1 |  0 |    0 |    0 |    1 |    1 |    0 |        0 |        1 |        0 |        1 |        0
//   1 |  0 |    0 |    0 |    1 |    1 |    1 |        0 |        1 |        1 |        0 |        1
//   1 |  0 |    0 |    1 |    0 |    0 |    0 |        0 |        1 |        0 |        0 |        0
//   1 |  0 |    0 |    1 |    0 |    0 |    1 |        1 |        0 |        0 |        0 |        1
//   1 |  0 |    0 |    1 |    0 |    1 |    0 |        1 |        0 |        0 |        1 |        0
//   1 |  0 |    0 |    1 |    0 |    1 |    1 |        1 |        0 |        1 |        0 |        1
//   1 |  0 |    0 |    1 |    1 |    0 |    0 |        1 |        0 |        1 |        0 |        0
//   1 |  0 |    0 |    1 |    1 |    0 |    1 |        1 |        1 |        0 |        0 |        1
//   1 |  0 |    0 |    1 |    1 |    1 |    0 |        1 |        1 |        0 |        1 |        0
//   1 |  0 |    0 |    1 |    1 |    1 |    1 |        1 |        1 |        1 |        0 |        1
//   1 |  1 |    0 |    0 |    0 |    0 |    0 |        x |        x |        x |        x |        x
//   1 |  1 |    0 |    0 |    0 |    0 |    1 |        0 |        0 |        0 |        1 |        1
//   1 |  1 |    0 |    0 |    0 |    1 |    0 |        0 |        0 |        1 |        1 |        0
//   1 |  1 |    0 |    0 |    0 |    1 |    1 |        0 |        0 |        1 |        1 |        1
//   1 |  1 |    0 |    0 |    1 |    0 |    0 |        0 |        1 |        1 |        0 |        0
//   1 |  1 |    0 |    0 |    1 |    0 |    1 |        0 |        1 |        0 |        1 |        1
//   1 |  1 |    0 |    0 |    1 |    1 |    0 |        0 |        1 |        1 |        1 |        0
//   1 |  1 |    0 |    0 |    1 |    1 |    1 |        0 |        1 |        1 |        1 |        1
//   1 |  1 |    0 |    1 |    0 |    0 |    0 |        1 |        1 |        0 |        0 |        0
//   1 |  1 |    0 |    1 |    0 |    0 |    1 |        1 |        0 |        0 |        1 |        1
//   1 |  1 |    0 |    1 |    0 |    1 |    0 |        1 |        0 |        1 |        1 |        0
//   1 |  1 |    0 |    1 |    0 |    1 |    1 |        1 |        0 |        1 |        1 |        1
//   1 |  1 |    0 |    1 |    1 |    0 |    0 |        1 |        1 |        1 |        0 |        0
//   1 |  1 |    0 |    1 |    1 |    0 |    1 |        1 |        1 |        0 |        1 |        1
//   1 |  1 |    0 |    1 |    1 |    1 |    0 |        1 |        1 |        1 |        1 |        0
//   1 |  1 |    0 |    1 |    1 |    1 |    1 |        1 |        1 |        1 |        1 |        1
//

module top(clk, rst, in, out3, out2, out1, out0);
input clk, rst;
input in;
output reg out3, out2, out1, out0;

reg out3Next, out2Next, out1Next, out0Next;
reg done, doneNext;

//the first 2 lines of the Truth Table. The Flip Flops are here.
always @(posedge clk or negedge rst) begin
	if (rst == 0) begin
		out3 <= 1;
		out2 <= 0;
		out1 <= 0;
		out0 <= 0;
		done <= 0;
	end else if ((rst == 1) && (done == 1)) begin
		out3 <= 1;
		out2 <= 0;
		out1 <= 0;
		out0 <= 0;
		done <= 0;
	end else begin
		out3 <= out3Next;
		out2 <= out2Next;
		out1 <= out1Next;
		out0 <= out0Next;
		done <= doneNext;
	end
end

always @(*) begin
	out3Next = out3;
	out2Next = out2;
	out1Next = out1;
	out0Next = out0;
	doneNext = done;
	case ({in, out3, out2, out1, out0})
	5'b00000: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'bxxxxx;
	5'b00001: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00001;
	5'b00010: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00010;
	5'b00011: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00101;
	5'b00100: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00100;
	5'b00101: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01001;
	5'b00110: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01010;
	5'b00111: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01101;
	5'b01000: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01000;
	5'b01001: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10001;
	5'b01010: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10010;
	5'b01011: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10101;
	5'b01100: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10100;
	5'b01101: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11001;
	5'b01110: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11010;
	5'b01111: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11101;
	5'b10000: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'bxxxxx;
	5'b10001: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00011;
	5'b10010: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00110;
	5'b10011: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b00111;	
	5'b10100: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01100;
	5'b10101: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01011;
	5'b10110: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01110;
	5'b10111: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b01111;
	5'b11000: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11000;
	5'b11001: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10011;
	5'b11010: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10110;
	5'b11011: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b10111;
	5'b11100: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11100;
	5'b11101: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11011;
	5'b11110: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11110;
	5'b11111: {out3Next, out2Next, out1Next, out0Next, doneNext} = 5'b11111;
	endcase
end

endmodule
