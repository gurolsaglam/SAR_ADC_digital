//Digital block for 2-bit SAR-ADC
//guerol.saglam@kit.edu
//the clock input here needs to be 3 times faster than the sampler block of the ADC (the block that comes before the comparator).
//
// inputs are clk, rst and in, outputs are out1 and out0,
// the rest are internal signals.
//
// Truth Table (the design works with rising edge of clock):
// rst | in | done | out1 | out0 | out1Next | out0Next | doneNext
//----------------------------------------------------------------
//   0 |  x |    x |    x |    x |        1 |        0 |        0
//   1 |  x |    1 |    x |    x |        1 |        0 |        0
//----------------------------------------------------------------
//   1 |  0 |    0 |    0 |    0 |        x |        x |        x
//   1 |  0 |    0 |    0 |    1 |        0 |        0 |        1
//   1 |  0 |    0 |    1 |    0 |        0 |        1 |        0
//   1 |  0 |    0 |    1 |    1 |        1 |        0 |        1
//   1 |  1 |    0 |    0 |    0 |        x |        x |        x
//   1 |  1 |    0 |    0 |    1 |        0 |        1 |        1
//   1 |  1 |    0 |    1 |    0 |        1 |        1 |        0
//   1 |  1 |    0 |    1 |    1 |        1 |        1 |        1
//

module top(clk, rst, in, out1, out0);
input clk, rst;
input in;
output reg out1, out0;

reg out1Next, out0Next;
reg done, doneNext;

//the first 2 lines of the Truth Table. The Flip Flops are here.
always @(posedge clk or negedge rst) begin
	if (rst == 0) begin
		out1 <= 1;
		out0 <= 0;
		done <= 0;
	end else if ((rst == 1) && (done == 1)) begin
		out1 <= 1;
		out0 <= 0;
		done <= 0;
	end else begin
		out1 <= out1Next;
		out0 <= out0Next;
		done <= doneNext;
	end
end

always @(*) begin
	out1Next = out1;
	out0Next = out0;
	doneNext = done;
	case ({in, out1, out0})
	3'b000: {out1Next, out0Next, doneNext} = 3'bxxx;
	3'b001: {out1Next, out0Next, doneNext} = 3'b001;
	3'b010: {out1Next, out0Next, doneNext} = 3'b010;
	3'b011: {out1Next, out0Next, doneNext} = 3'b101;
	3'b100: {out1Next, out0Next, doneNext} = 3'bxxx;
	3'b101: {out1Next, out0Next, doneNext} = 3'b011;
	3'b110: {out1Next, out0Next, doneNext} = 3'b110;
	3'b111: {out1Next, out0Next, doneNext} = 3'b111;
	endcase
end

endmodule
