//Digital block for 3-bit SAR-ADC
//guerol.saglam@kit.edu
//the clock input here needs to be 4 times faster than the sampler block of the ADC (the block that comes before the comparator).
//
// inputs are clk, rst and in, outputs are out2, out1 and out0,
// the rest are internal signals.
//
// Truth Table (the design works with rising edge of clock):
// rst | in | done | out2 | out1 | out0 | out2Next | out1Next | out0Next | doneNext
//----------------------------------------------------------------------------------
//   0 |  x |    x |    x |    x |    x |        1 |        0 |        0 |        0
//   1 |  x |    1 |    x |    x |    x |        1 |        0 |        0 |        0
//----------------------------------------------------------------------------------
//   1 |  0 |    0 |    0 |    0 |    0 |        x |        x |        x |        x
//   1 |  0 |    0 |    0 |    0 |    1 |        0 |        0 |        0 |        1
//   1 |  0 |    0 |    0 |    1 |    0 |        0 |        0 |        1 |        0
//   1 |  0 |    0 |    0 |    1 |    1 |        0 |        1 |        0 |        1
//   1 |  0 |    0 |    1 |    0 |    0 |        0 |        1 |        0 |        0
//   1 |  0 |    0 |    1 |    0 |    1 |        1 |        0 |        0 |        1
//   1 |  0 |    0 |    1 |    1 |    0 |        1 |        0 |        1 |        0
//   1 |  0 |    0 |    1 |    1 |    1 |        1 |        1 |        0 |        1
//   1 |  1 |    0 |    0 |    0 |    0 |        x |        x |        x |        x
//   1 |  1 |    0 |    0 |    0 |    1 |        0 |        0 |        1 |        1
//   1 |  1 |    0 |    0 |    1 |    0 |        0 |        1 |        1 |        0
//   1 |  1 |    0 |    0 |    1 |    1 |        0 |        1 |        1 |        1
//   1 |  1 |    0 |    1 |    0 |    0 |        1 |        1 |        0 |        0
//   1 |  1 |    0 |    1 |    0 |    1 |        1 |        0 |        1 |        1
//   1 |  1 |    0 |    1 |    1 |    0 |        1 |        1 |        1 |        0
//   1 |  1 |    0 |    1 |    1 |    1 |        1 |        1 |        1 |        1
//

module top(clk, rst, in, out2, out1, out0);
input clk, rst;
input in;
output reg out2, out1, out0;

reg out2Next, out1Next, out0Next;
reg done, doneNext;

//the first 2 lines of the Truth Table. The Flip Flops are here.
always @(posedge clk or negedge rst) begin
	if (rst == 0) begin
		out2 <= 1;
		out1 <= 0;
		out0 <= 0;
		done <= 0;
	end else if ((rst == 1) && (done == 1)) begin
		out2 <= 1;
		out1 <= 0;
		out0 <= 0;
		done <= 0;
	end else begin
		out2 <= out2Next;
		out1 <= out1Next;
		out0 <= out0Next;
		done <= doneNext;
	end
end

always @(*) begin
	out2Next = out2;
	out1Next = out1;
	out0Next = out0;
	doneNext = done;
	case ({in, out2, out1, out0})
	4'b0000: {out2Next, out1Next, out0Next, doneNext} = 4'bxxxx;
	4'b0001: {out2Next, out1Next, out0Next, doneNext} = 4'b0001;
	4'b0010: {out2Next, out1Next, out0Next, doneNext} = 4'b0010;
	4'b0011: {out2Next, out1Next, out0Next, doneNext} = 4'b0101;
	4'b0100: {out2Next, out1Next, out0Next, doneNext} = 4'b0100;
	4'b0101: {out2Next, out1Next, out0Next, doneNext} = 4'b1001;
	4'b0110: {out2Next, out1Next, out0Next, doneNext} = 4'b1010;
	4'b0111: {out2Next, out1Next, out0Next, doneNext} = 4'b1101;
	4'b1000: {out2Next, out1Next, out0Next, doneNext} = 4'bxxxx;
	4'b1001: {out2Next, out1Next, out0Next, doneNext} = 4'b0011;
	4'b1010: {out2Next, out1Next, out0Next, doneNext} = 4'b0110;
	4'b1011: {out2Next, out1Next, out0Next, doneNext} = 4'b0111;
	4'b1100: {out2Next, out1Next, out0Next, doneNext} = 4'b1100;
	4'b1101: {out2Next, out1Next, out0Next, doneNext} = 4'b1011;
	4'b1110: {out2Next, out1Next, out0Next, doneNext} = 4'b1110;
	4'b1111: {out2Next, out1Next, out0Next, doneNext} = 4'b1111;
	endcase
end

endmodule
