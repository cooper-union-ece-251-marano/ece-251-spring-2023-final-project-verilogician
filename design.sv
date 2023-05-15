`timescale 1ns / 1ps


module b_clkGen
  #(
    // parameter length = 500,
    parameter period = 50
  )
  (
    output reg clk
  );

  initial clk = 1'b0;

  always #(period/2) clk = ~clk;

  // initial #length $finish;
endmodule

module halfAdder
  #(parameter delay = 0)
  (
    input A,
    input B,
    output S,
    output C
  );

  xor #delay (S, A, B);
  and #delay (C, A, B);
endmodule

module fullAdder
  #(parameter delay = 0)
  (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
  );

  wire S1, C1, C2;

  halfAdder #(.delay(delay)) halfAdder_0(.A(A), .B(B), .S(S1), .C(C1));
  halfAdder #(.delay(delay)) halfAdder_1(.A(Cin), .B(S1), .S(S), .C(C2));
  
  or  #delay (Cout, C1, C2);
endmodule

module halfAdder_param
  #(
    parameter size = 32,
    parameter delay = 0
  )
  (
    input[size-1:0] A,
    input[size-1:0] B,
    output reg[size-1:0] C,
    output reg[size-1:0] S
  );

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      halfAdder #(.delay(delay)) halfAdder(.A(A[i]), .B(B[i]), .C(C[i]), .S(S[i]));
    end
  endgenerate
endmodule

module fullAdder_param
  #(
    parameter size = 32,
    parameter delay = 0
  )
  (
    input[size-1:0] A,
    input[size-1:0] B,
    input[size-1:0] Cin,
    output reg[size-1:0] Cout,
    output reg[size-1:0] S
  );

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      fullAdder #(.delay(delay)) fullAdder(.A(A[i]), .B(B[i]), .Cin(Cin[i]), .Cout(Cout[i]), .S(S[i]));
    end
  endgenerate
endmodule

module mux2
  #(parameter delay = 0)
  (
    input A,
    input B,
    input S,
    output Q
  );

  wire Snot, tmp[1:0];

  not #delay (Snot, S);
  and #delay (tmp[0], A, Snot);
  and #delay (tmp[1], B, S);
  or #delay (Q, tmp[0], tmp[1]);
endmodule

module mux2_param
  #(
    parameter size = 32,
    parameter delay = 0
  )
  (
    input[size-1:0] D0,
    input[size-1:0] D1,

    input S,
    output reg[size-1:0] Q
  );

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      mux2 #(.delay(delay)) mux2(.A(D0[i]), .B(D1[i]), .S(S), .Q(Q[i]));
    end
  endgenerate
endmodule

module mux_param
  #(
    parameter width = 32,
    parameter delay = 0,
    parameter length = 32
  )
  (
    input[width-1:0] D[length-1:0],
    input[$clog2(length)-1:0] S,
    output reg[width-1:0] Q
  );

  wire[width-1:0] tmp[length*2-2:0];

  assign Q = tmp[0];

  genvar i;
  generate
    for (i = 0; i < length; i = i + 1) begin
      assign tmp[i+length-1] = D[i];
    end
    for (i = 0; i < length - 1; i = i + 1) begin
      mux2_param #(.size(width), .delay(delay)) mux2_param(.D0(tmp[i*2+1]), .D1(tmp[i*2+2]), .S(S[$clog2(length)-1-$clog2((i+3)>>1)]), .Q(tmp[i]));
    end
  endgenerate
endmodule

module demux2
  #(parameter delay = 0)
  (
    input D,
    input S,
    output Y0,
    output Y1
  );

  not #delay (Snot, S);
  and #delay (Y0, D, Snot);
  and #delay (Y1, D, S);
endmodule

module demux2_param
  #(
    parameter size = 32,
    parameter delay = 0
  )
  (
    input[size-1:0] D,
    input S,
    output reg[size-1:0] Y0,
    output reg[size-1:0] Y1
  );

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      demux2 #(.delay(delay)) demux2(.D(D[i]), .S(S), .Y0(Y0[i]), .Y1(Y1[i]));
    end
  endgenerate
endmodule

module demux_param
  #(
    parameter width = 32,
    parameter delay = 0,
    parameter length = 32
  )
  (
    output[width-1:0] Y[length-1:0],
    input[$clog2(length)-1:0] S,
    input reg[width-1:0] D
  );

  wire[width-1:0] tmp[length*2-2:0];

  assign tmp[0] = D;

  genvar i;
  generate
    for (i = 0; i < length; i = i + 1) begin
      assign Y[i] = tmp[i+length-1];
    end
    for (i = 0; i < length - 1; i = i + 1) begin
      demux2_param #(.size(width), .delay(delay)) demux2_param(.Y0(tmp[i*2+1]), .Y1(tmp[i*2+2]), .S(S[$clog2(length)-1-$clog2((i+3)>>1)]), .D(tmp[i]));
    end
  endgenerate
endmodule

module dff
  #(parameter delay = 0)
  (
    input clk,
    input D,
    output Q,
    output Qnot
  );
  
  wire Dnot, ND1, ND2;

  not #delay (Dnot, D);
  nand #delay (ND1, D, clk);
  nand #delay (ND2, Dnot, clk);
  nand #delay (Q, ND1, Qnot);
  nand #delay (Qnot, Q, ND2);
  
endmodule

module reg_param
  #(
    parameter size = 32,
    parameter delay = 0
  )
  (
    input clk,
    input[size-1:0] D,
    output[size-1:0] Q
  );

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      dff #(.delay(delay)) dff(.clk(clk), .D(D[i]), .Q(Q[i]));
    end
  endgenerate
endmodule

/*
//wip
module biDshift
  #(
    parameter size = 32,
    parameter delay = 0
  )

  //input left or right
  //input clk
  //output Q: 32bits parallel output
  //input D: bit going into the shift reg (can be used for sign extension)
  //synchronous reset

  (
    input clk,
    input dir,
    input Rnot,
    input Lnot,
    input[size-1:0] D,
    input A,
    output[size-1:0] Q
  );

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      dff #(.delay(delay)) dff(.clk(clk), .Rnot(Rnot), .D(D[i]), .Q(Q[i]));
    end
  endgenerate
endmodule
// */

module regFile_param
  #(
    parameter width = 32,
    parameter length = 32,
    parameter delay = 0
  )
  (
    input[width-1:0] D,
    input[$clog2(length)-1:0] RS1,
    input[$clog2(length)-1:0] RS2,
    input[$clog2(length)-1:0] WS,

    input clk,
    output[width-1:0] Q1,
    output[width-1:0] Q2
  );

  wire tmp0[length-1:0];
  wire tmp1[length-1:0];
  wire[width-1:0] tmp2[0:length-1];

  demux_param #(.width(1), .delay(delay), .length(length)) decoder(.Y(tmp0), .S(WS), .D(1'b1));

  genvar i;
  generate
    for (i = 0; i < length; i = i + 1) begin
      and #delay (tmp1[i], tmp0[i], clk);
      reg_param #(.size(width), .delay(delay)) reg_param(.clk(tmp1[i]), .D(D), .Q(tmp2[i]));
    end
  endgenerate

  mux_param #(.width(width), .delay(delay), .length(length)) mux_param_0(.D(tmp2), .S(RS1), .Q(Q1));
  mux_param #(.width(width), .delay(delay), .length(length)) mux_param_1(.D(tmp2), .S(RS2), .Q(Q2));
endmodule

module comparator
  #(parameter delay = 0)
  (
    input A,
    input B,
    input Lin,
    input Gin,
    output L,
    output E,
    output G
  );

  wire Anot, Bnot;
  wire GinNot, LinNot;
  wire tmpL0, tmpG0, tmpL1, tmpG1;

  not #delay (Anot, A);
  not #delay (Bnot, B);
  not #delay (Ginot, Gin);
  not #delay (Linot, Lin);

  and #delay (tmpL0, Anot, B);
  and #delay (tmpG0, Bnot, A);

  or #delay (tmpL1, tmpL0, Lin);
  or #delay (tmpG1, tmpG0, Gin);

  and #delay (L, Ginot, tmpL1);
  and #delay (G, Linot, tmpG1);

  nor #delay (E, L, G);
endmodule

module comparator_param
  #(
    parameter size = 32,
    parameter delay = 0
  )
  (
    input[size-1:0] A,
    input[size-1:0] B,
    input Lin,
    input Gin,
    output L,
    output E,
    output G
  );

  wire[size:0] tmpL, tmpG;

  assign tmpL[size] = Lin;
  assign tmpG[size] = Gin;
  assign L = tmpL[0];
  assign G = tmpG[0];

  genvar i;
  generate
    for (i = 0; i < size; i = i + 1) begin
      comparator #(.delay(delay)) comparator(.A(A[i]), .B(B[i]), .Lin(tmpL[i+1]), .Gin(tmpG[i+1]), .L(tmpL[i]), .G(tmpG[i]));
    end
  endgenerate

  nor #delay (E, L, G);
endmodule

module mips_regFile
  #(
    parameter delay = 0,
    parameter width = 8,
    parameter length = 128
  )
  (
    input[7:0] D,
    input[6:0] RS1,
    input[6:0] RS2,
    input[6:0] WS,

    input clk,
    output[7:0] Q1,
    output[7:0] Q2
  );

  regFile_param #(.width(width), .length(length), .delay(delay)) regen(.clk(clk), .D(D), .Q1(Q1), .Q2(Q2), .RS1(RS1), .RS2(RS2), .WS(WS));
endmodule

module b_program_counter
  #(
    parameter width = 12
  )
  (
    input clk,
    input jump,
    input [width-1:0] imm,
    output reg [width-1:0] pc
  );

  initial begin
    pc = 0;
  end

  always @(posedge clk) begin
      if (jump) begin
        pc = imm;
      end
      else begin
        pc = pc + 1;
      end
  end
endmodule

module b_sign_extend
  #(
    parameter iw = 12,
    parameter ow = 32
  )
  (
    input [iw-1:0] in, 
    output [ow-1:0] out
  );
    assign out = {{(ow-iw){in[iw-1]}}, in};
endmodule

module b_memory
  #(
    parameter addrSize = 12,
    parameter width = 32
  )
  (
    input[addrSize-1:0] address,
    input[width-1:0] in,
    input clk,
    output[width-1:0] out
  );

  reg [width-1:0] mem[0:2**addrSize-1];

  assign out = mem[address];

  always @(posedge clk) begin
    mem[address] <= in;
  end

  initial begin
    $readmemb("fib.exe", mem);
  end
endmodule

module b_computer;
  reg[31:0] regIn;
  wire[31:0] signExtImm, rsOut, rtOut, curIns, memOut;
  reg pcSel, memSel, regSel, pcNext, regWrite, pcJump, getIns, memWrite;
  wire[4:0] opcode, rd, rs, rt, regAddr;
  reg[4:0] ra;
  wire[11:0] jumpAddr, memAddr, pcOut;
  wire[11:0] imm;
  wire clk;
  reg[11:0] pcAddr;

  assign pcAddr = rtOut[11:0] + imm;

  b_clkGen #(.period(50)) clkGen(.clk(clk));

  b_sign_extend #(.iw(12), .ow(32)) signExt(.in(imm), .out(signExtImm));

  mux2_param #(.size(12), .delay(0)) pcMux(.D0(imm), .D1(rsOut[11:0]), .S(pcSel), .Q(jumpAddr));
  b_program_counter #(.width(12)) program_counter(.clk(pcNext), .jump(pcJump), .imm(jumpAddr), .pc(pcOut));

  mux2_param #(.size(5), .delay(0)) regMux(.D0(rd), .D1(ra), .S(regSel), .Q(regAddr));
  regFile_param #(.width(32), .length(32), .delay(0)) regFile(.clk(regWrite), .D(regIn), .Q1(rsOut), .Q2(rtOut), .RS1(rs), .RS2(rt), .WS(regAddr));

  b_separator separator(.word(curIns), .opcode(opcode), .rd(rd), .rs(rs), .rt(rt), .imm(imm));


  mux2_param #(.size(12), .delay(0)) memMux(.D0(pcOut), .D1(rtOut[11:0] + imm), .S(memSel), .Q(memAddr));
  b_memory #(.addrSize(12), .width(32)) memory(.address(memAddr), .in(rsOut), .clk(memWrite), .out(memOut));

  reg_param instruction_memory(.clk(getIns), .D(memOut), .Q(curIns));

  initial begin
    pcSel = 0;
    memSel = 0;
    regWrite = 0;
    getIns = 0;
    pcNext = 0;

    regSel = 1;
    ra = 30;
    regIn = 4095;
    #5;
    regWrite = 1;
    #5;
    regWrite = 0;
    #5;
    ra = 0;
    regIn = 0;
    #5;
    regWrite = 1;
    #5;
    regWrite = 0;
    #5;
    regSel = 0;

    getIns = 1;
    #5;
    getIns = 0;
    #5;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, opcode, rd, rs, rt, rsOut, rtOut, memOut, pcOut);
  end

  always @(posedge clk) begin
    getIns = 1;
    #5;
    getIns = 0;
  end

  always @(negedge getIns) begin
    //add
    if (opcode == 0) begin
      regIn = rsOut + rtOut + signExtImm;
      #5;
      regWrite = 1;
      #5;
      regWrite = 0;
      #5;
      pcNext = 1;
      #5;
      pcNext = 0;
      #5;
    end
    //bne
    else if (opcode == 3) begin
      if (rsOut != rtOut) begin
        pcSel = 0;
        #5;
        pcJump = 1;
        #5;
        pcNext = 1;
        #5;
        pcNext = 0;
        #5;
        pcJump = 0;
        #5;
      end
      else begin
        pcNext = 1;
        #5;
        pcNext = 0;
        #5;
      end
    end
    //j
    else if (opcode == 4) begin
      if (rs == 0) begin
        pcSel = 0;
        #5;
        pcJump = 1;
        #5;
        pcNext = 1;
        #5;
        pcNext = 0;
        #5;
        pcJump = 0;
        #5;
      end
      else begin
        pcSel = 1;
        #5;
        pcJump = 1;
        #5;
        pcNext = 1;
        #5;
        pcNext = 0;
        #5;
        pcJump = 0;
        #5;  
      end
    end
    //jal
    else if (opcode == 5) begin
      regIn = pcOut + 1;
      #5;
      regWrite = 1;
      #5;
      regWrite = 0;
      #5;
      pcSel = 0;
      #5;
      pcJump = 1;
      #5;
      pcNext = 1;
      #5;
      pcNext = 0;
      #5;
      pcJump = 0;
      #5;
    end
    //lw
    else if (opcode == 6) begin
      memSel = 1;
      #5;
      regIn = memOut;
      #5;
      regWrite = 1;
      #5;
      regWrite = 0;
      #5;
      memSel = 0;
      #5;
      pcNext = 1;
      #5;
      pcNext = 0;
      #5;
    end
    //sw
    else if (opcode == 7) begin
      memSel = 1;
      #5;
      memWrite = 1;
      #5;
      memWrite = 0;
      #5;
      memSel = 0;
      #5;
      pcNext = 1;
      #5;
      pcNext = 0;
      #5;
    end
    //prt
    else if (opcode == 8) begin
      $display("The Fibonacci is: %d", rsOut);
      $finish;
    end
    else begin
      pcNext = 1;
      #5;
      pcNext = 0;
      #5;
    end
  end
endmodule

module b_separator
(
  input [31:0] word,
  output [4:0] opcode,
  output [4:0] rd,
  output [4:0] rs,
  output [4:0] rt,
  output [11:0] imm
);

  assign opcode = word >> 27;
  assign rd = word >> 22;
  assign rs = word >> 17;
  assign rt = word >> 12;
  assign imm = word[11:0];
endmodule
