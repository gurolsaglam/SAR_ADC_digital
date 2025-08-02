/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP5
// Date      : Thu Aug  8 17:48:48 2024
/////////////////////////////////////////////////////////////


module top ( clk, rst, in, out3, out2, out1, out0 );
  input clk, rst, in;
  output out3, out2, out1, out0;
  wire   done, N105, N106, N107, N108, n1, n2, n4, n6, n8, n10, n11, n15, n16,
         n17, n18, n19, n20, n21, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35;

  DFFNRX1 out1_reg ( .D(N106), .CP(clk), .RST_N(rst), .Q(out1) );
  DFFNRX1 out0_reg ( .D(N107), .CP(clk), .RST_N(rst), .Q(out0) );
  DFFNRX1 done_reg ( .D(N108), .CP(clk), .RST_N(rst), .Q(done) );
  DFFNRX1 out2_reg ( .D(N105), .CP(clk), .RST_N(rst), .Q(out2) );
  DFFNRX1 out3_reg ( .D(n25), .CP(clk), .RST_N(rst), .Q_bar(out3) );
  NAND2X1 U3 ( .A1(rst), .A2(done), .Y(n8) );
  INVX1 U5 ( .A(out0), .Y(n21) );
  INVX1 U6 ( .A(out1), .Y(n1) );
  NOR2X1 U8 ( .A1(out2), .A2(n26), .Y(n6) );
  NAND2X1 U10 ( .A1(n2), .A2(out3), .Y(n4) );
  NAND2X1 U15 ( .A1(out0), .A2(n8), .Y(n19) );
  NAND2X1 U19 ( .A1(out1), .A2(n8), .Y(n20) );
  NAND2X1 U21 ( .A1(n10), .A2(out2), .Y(n11) );
  NAND2X1 U24 ( .A1(n15), .A2(out2), .Y(n18) );
  NAND2X1 U25 ( .A1(out1), .A2(n28), .Y(n17) );
  NAND2X1 U32 ( .A1(n21), .A2(n1), .Y(n26) );
  INVX1 U33 ( .A(n8), .Y(n27) );
  AND2X1 U34 ( .A1(n33), .A2(n19), .Y(n16) );
  INVX1 U35 ( .A(n16), .Y(n28) );
  INVX1 U36 ( .A(n19), .Y(N108) );
  INVX1 U37 ( .A(n20), .Y(n29) );
  NAND2X1 U38 ( .A1(n21), .A2(n29), .Y(n31) );
  NAND2X1 U39 ( .A1(in), .A2(N108), .Y(n30) );
  NAND2X1 U40 ( .A1(n31), .A2(n30), .Y(N107) );
  NAND2X1 U41 ( .A1(n17), .A2(n18), .Y(N106) );
  NOR2X1 U42 ( .A1(n27), .A2(n26), .Y(n15) );
  NAND2X1 U43 ( .A1(n8), .A2(n6), .Y(n32) );
  NAND2X1 U44 ( .A1(n32), .A2(n11), .Y(N105) );
  NAND2X1 U45 ( .A1(n8), .A2(in), .Y(n33) );
  NAND2X1 U46 ( .A1(n20), .A2(n16), .Y(n10) );
  NAND2X1 U47 ( .A1(n6), .A2(in), .Y(n34) );
  NAND2X1 U48 ( .A1(n34), .A2(n4), .Y(n35) );
  NOR2X1 U49 ( .A1(n27), .A2(n35), .Y(n25) );
  INVX1 U50 ( .A(n6), .Y(n2) );
endmodule

