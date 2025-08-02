/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP5
// Date      : Thu Aug  8 17:20:44 2024
/////////////////////////////////////////////////////////////


module top ( clk, rst, in, out1, out0 );
  input clk, rst, in;
  output out1, out0;
  wire   done, N17, N18, n1, n5, n6, n7, n8, n9, n10;

  DFFNRX1 done_reg ( .D(N18), .CP(clk), .RST_N(rst), .Q(done) );
  DFFNRX1 out0_reg ( .D(N17), .CP(clk), .RST_N(rst), .Q(out0) );
  DFFNRX1 out1_reg ( .D(n7), .CP(clk), .RST_N(rst), .Q_bar(out1) );
  AND2X1 U3 ( .A1(rst), .A2(done), .Y(n6) );
  INVX1 U4 ( .A(out0), .Y(n5) );
  NAND2X1 U6 ( .A1(out0), .A2(out1), .Y(n1) );
  NOR2X1 U12 ( .A1(n6), .A2(n5), .Y(N18) );
  NOR2X1 U13 ( .A1(in), .A2(n5), .Y(n8) );
  NOR2X1 U14 ( .A1(n6), .A2(n8), .Y(N17) );
  NAND2X1 U15 ( .A1(n5), .A2(in), .Y(n9) );
  NAND2X1 U16 ( .A1(n9), .A2(n1), .Y(n10) );
  NOR2X1 U17 ( .A1(n6), .A2(n10), .Y(n7) );
endmodule

