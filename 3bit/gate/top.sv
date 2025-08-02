/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP5
// Date      : Thu Aug  8 17:21:10 2024
/////////////////////////////////////////////////////////////


module top ( clk, rst, in, out2, out1, out0 );
  input clk, rst, in;
  output out2, out1, out0;
  wire   done, N43, N44, N45, n1, n3, n5, n6, n8, n9, n10, n13, n15, n16, n17,
         n18, n19, n20, n21, n22;

  DFFNRX1 out1_reg ( .D(N43), .CP(clk), .RST_N(rst), .Q(out1) );
  DFFNRX1 out0_reg ( .D(N44), .CP(clk), .RST_N(rst), .Q(out0) );
  DFFNRX1 done_reg ( .D(N45), .CP(clk), .RST_N(rst), .Q(done) );
  DFFNRX1 out2_reg ( .D(n15), .CP(clk), .RST_N(rst), .Q_bar(out2) );
  NAND2X1 U3 ( .A1(rst), .A2(done), .Y(n8) );
  NOR2X1 U5 ( .A1(out0), .A2(out1), .Y(n1) );
  NAND2X1 U7 ( .A1(n17), .A2(out2), .Y(n3) );
  INVX1 U11 ( .A(out0), .Y(n13) );
  NAND2X1 U14 ( .A1(n5), .A2(out1), .Y(n6) );
  NAND2X1 U17 ( .A1(out0), .A2(n9), .Y(n10) );
  INVX1 U21 ( .A(n1), .Y(n16) );
  INVX1 U22 ( .A(n1), .Y(n17) );
  INVX1 U23 ( .A(n8), .Y(n22) );
  NOR2X1 U24 ( .A1(n13), .A2(n22), .Y(N45) );
  NAND2X1 U25 ( .A1(n8), .A2(n10), .Y(n18) );
  NOR2X1 U26 ( .A1(n1), .A2(n18), .Y(N44) );
  NAND2X1 U27 ( .A1(n6), .A2(n16), .Y(n19) );
  AND2X1 U28 ( .A1(n19), .A2(n8), .Y(N43) );
  INVX1 U29 ( .A(in), .Y(n9) );
  NAND2X1 U30 ( .A1(n13), .A2(n9), .Y(n5) );
  NAND2X1 U31 ( .A1(n1), .A2(in), .Y(n20) );
  NAND2X1 U32 ( .A1(n20), .A2(n3), .Y(n21) );
  NOR2X1 U33 ( .A1(n22), .A2(n21), .Y(n15) );
endmodule

