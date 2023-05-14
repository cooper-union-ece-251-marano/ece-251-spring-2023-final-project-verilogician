`timescale 1ns / 1ps
`include "design.sv" 
/*
module mux2_param_tb;
  parameter size = 32;
  parameter delay = 0;
  reg[size-1:0] D[0:1];

  reg S;
  wire[size-1:0] Q;
  
  mux2_param #(.size(size), .delay(delay)) uut(.D(D), .S(S), .Q(Q));
          
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, D[0], D[1], S, Q);
    $display("A   B   S   Q");
    $monitor("%d; %d; %d; %d;", D[0], D[1], S, Q);
  end
  
  initial begin
    D[0] = 5245;
    D[1] = 2266236;
    S = 1'b0;
    #50;
    S = 1'b1;
    #50;
  end
endmodule
// */

/*
module mux_param_tb;
  parameter width = 8;
  parameter length = 128;
  parameter delay = 0;
  reg[width-1:0] D[0:length-1];
  reg[$clog2(length)-1:0] S;
  wire[width-1:0] Q;
  integer i;
  
  mux_param #(.width(width), .delay(delay), .length(length)) uut(.D(D), .S(S), .Q(Q));

  b_clkGen #(.length(200)) clk();

  
  initial begin
    $dumpfile("dump.vcd");
    // $dumpvars(0, mux_param_tb);

    $dumpvars(1, S, Q);
    for(i = 0; i < length; i = i + 1) begin
      $dumpvars(1, D[i]);
    end
  end


  initial begin
    D[0] = 1;
    D[1] = 2;
    D[2] = 3;
    D[3] = 4;
    D[4] = 5;
    D[5] = 6;
    D[6] = 7;
    D[7] = 8;
    D[8] = 9;
    D[9] = 10;
    D[10] = 11;
    D[11] = 12;
    D[12] = 13;
    D[13] = 14;
    D[14] = 25728;
    D[15] = 56538;
    D[16] = 3567756;
    D[17] = 3453267;
    D[18] = 4562275;
    D[19] = 3567863457;
    D[20] = 56385624;
    D[21] = 452624572;
    D[22] = 4563474562;
    D[23] = 682453;
    D[24] = 272456245;
    D[25] = 2457563456;
    D[26] = 245216;
    D[27] = 275284656;
    D[28] = 24582566;
    D[29] = 3673566282;
    D[30] = 245256;
    D[31] = 28657456745;
    S = 5'b00000;
    S = #10 5'b00001;
    S = #10 5'b00010;
    S = #10 5'b00011;
    S = #10 5'b00100;
    S = #10 5'b00101;
    S = #10 5'b00110;    
    S = #10 5'b00111;
    S = #10 5'b01000;
    S = #10 5'b01001;    
    S = #10 5'b01010;
    S = #10 5'b01011;
    S = #10 5'b01100;
    S = #10 5'b01101;    
    S = #10 5'b01110;
    S = #10 5'b01111;
    S = #10 5'b10000;
    S = #10 5'b10001;
    S = #10 5'b10010;
    S = #10 5'b10011;
    S = #10 5'b10100;
    S = #10 5'b10101;
    S = #10 5'b10110;    
    S = #10 5'b10111;
    S = #10 5'b11000;
    S = #10 5'b11001;    
    S = #10 5'b11010;
    S = #10 5'b11011;
    S = #10 5'b11100;
    S = #10 5'b11101;    
    S = #10 5'b11110;
    S = #10 5'b11111;
  end
endmodule
// */

/*
module demux2_param_tb;
  parameter size = 32;
  parameter delay = 0;
  reg[size-1:0] D;

  reg S;
  wire[size-1:0] Y[1:0];
  
  demux2_param #(.size(size), .delay(delay)) uut(.D(D), .S(S), .Y0(Y[0]), .Y1(Y[1]));

  b_clkGen #(.length(150)) clk();

          
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, D, S, Y[0], Y[1]);
  end
  
  initial begin
    D = 5245;
    S = #50 1'b0;
    S = #50 1'b1;
  end
endmodule
// */

/*
module demux_param_tb;
  parameter width = 8;
  parameter length = 32;
  parameter delay = 0;
  wire[width-1:0] Y[0:length-1];
  reg[$clog2(length)-1:0] S;
  reg[width-1:0] D;
  integer i;
  
  demux_param #(.width(width), .delay(delay), .length(length)) uut(.Y(Y), .S(S), .D(D));

  b_clkGen #(.length(200)) clk();
  
  initial begin
    $dumpfile("dump.vcd");
    // $dumpvars(0, mux_param_tb);

    $dumpvars(1, S, D);
    for(i = 0; i < length; i = i + 1) begin
      $dumpvars(1, Y[i]);
    end
  end

  initial begin
    D = 1;
    S = 5'b00000;
    S = #10 5'b00001;
    S = #10 5'b00010;
    S = #10 5'b00011;
    S = #10 5'b00100;
    S = #10 5'b00101;
    S = #10 5'b00110;    
    S = #10 5'b00111;
    S = #10 5'b01000;
    S = #10 5'b01001;    
    S = #10 5'b01010;
    S = #10 5'b01011;
    S = #10 5'b01100;
    S = #10 5'b01101;    
    S = #10 5'b01110;
    S = #10 5'b01111;
    S = #10 5'b10000;
    S = #10 5'b10001;
    S = #10 5'b10010;
    S = #10 5'b10011;
    S = #10 5'b10100;
    S = #10 5'b10101;
    S = #10 5'b10110;    
    S = #10 5'b10111;
    S = #10 5'b11000;
    S = #10 5'b11001;    
    S = #10 5'b11010;
    S = #10 5'b11011;
    S = #10 5'b11100;
    S = #10 5'b11101;    
    S = #10 5'b11110;
    S = #10 5'b11111;
  end
endmodule
// */

/*
module dff_tb;
  parameter delay = 0;

  //change below
  reg write;
  reg in;
  wire out;
  dff uut(.clk(write), .D(in), .Q(out));
  b_clkGen #(.period(10), .length(600)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");

    //change this
    $dumpvars(1, write, in, out);
  end
  
  initial begin

    //change this
    #50;
    in = 0;
    #10;
    write = 1;
    #5;
    write = 0;
    #50;
    in = 1;
    #10;
    write = 1;
    #5;
    write = 0;
  end
endmodule
// */

/*
module regFile_param_tb;
  parameter width = 8;
  parameter length = 128;
  parameter delay = 0;
  integer i;
  reg[width-1:0] D;
  reg clk;
  reg[$clog2(length)-1:0] RS1, RS2, WS;
  wire[width-1:0] Q1, Q2;
  
  regFile_param #(.width(width), .length(length), .delay(delay)) uut(.clk(clk), .D(D), .Q1(Q1), .Q2(Q2), .RS1(RS1), .RS2(RS2), .WS(WS));

  b_clkGen #(.period(10), .length(100)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, clk, D, Q1, Q2, RS1, RS2, WS);
  end
  
  // always #10 D = D + 1;

  initial begin
    // D = 0;
    // WS = #10 5'b00000;
    // WS = #10 5'b00001;
    // WS = #10 5'b00010;
    // WS = #10 5'b00011;
    // WS = #10 5'b00100;
    // WS = #10 5'b00101;
    // WS = #10 5'b00110;    
    // WS = #10 5'b00111;
    // WS = #10 5'b01000;
    // WS = #10 5'b01001;    
    // WS = #10 5'b01010;
    // WS = #10 5'b01011;
    // WS = #10 5'b01100;
    // WS = #10 5'b01101;    
    // WS = #10 5'b01110;
    // WS = #10 5'b01111;
    // WS = #10 5'b10000;
    // WS = #10 5'b10001;
    // WS = #10 5'b10010;
    // WS = #10 5'b10011;
    // WS = #10 5'b10100;
    // WS = #10 5'b10101;
    // WS = #10 5'b10110;    
    // WS = #10 5'b10111;
    // WS = #10 5'b11000;
    // WS = #10 5'b11001;    
    // WS = #10 5'b11010;
    // WS = #10 5'b11011;
    // WS = #10 5'b11100;
    // WS = #10 5'b11101;    
    // WS = #10 5'b11110;
    // WS = #10 5'b11111;

    // RS1 = #3 5'b00000;
    // RS2 = #3 5'b10000;
    // RS1 = #3 5'b00001;
    // RS2 = #3 5'b10001;
    // RS1 = #3 5'b00010;
    // RS2 = #3 5'b10010;
    // RS1 = #3 5'b00011;
    // RS2 = #3 5'b10011;
    // RS1 = #3 5'b00100;
    // RS2 = #3 5'b10100;
    // RS1 = #3 5'b00101;
    // RS2 = #3 5'b10101;
    // RS1 = #3 5'b00110;
    // RS2 = #3 5'b10110;
    // RS1 = #3 5'b00111;
    // RS2 = #3 5'b10111;
    // RS1 = #3 5'b01000;
    // RS2 = #3 5'b11000;
    // RS1 = #3 5'b01001;
    // RS2 = #3 5'b11001;
    // RS1 = #3 5'b01010;
    // RS2 = #3 5'b11010;
    // RS1 = #3 5'b01011;
    // RS2 = #3 5'b11011;
    // RS1 = #3 5'b01100;
    // RS2 = #3 5'b11100;
    // RS1 = #3 5'b01101;
    // RS2 = #3 5'b11101;
    // RS1 = #3 5'b01110;
    // RS2 = #3 5'b11110;
    // RS1 = #3 5'b01111;
    // RS2 = #3 5'b11111;

    D = 7;
    WS = #10 7'b0000000;
    WS = #10 7'b0000001;
    WS = #10 7'b0000010;
    WS = #10 7'b0000011;


    RS1 = #10 7'b0000000;
    RS2 = #10 7'b0000001;
    RS1 = #10 7'b0000010;
    RS2 = #10 7'b0000011;
  end
endmodule
// */

/*
module mips_regFile_tb;
  parameter width = 8;
  parameter length = 128;
  parameter delay = 0;
  integer i;
  reg[width-1:0] D;
  reg clk;
  reg[$clog2(length)-1:0] RS1, RS2, WS;
  wire[width-1:0] Q1, Q2;
  
  regFile_param #(.width(width), .length(length), .delay(delay)) uut(.clk(clk), .D(D), .Q1(Q1), .Q2(Q2), .RS1(RS1), .RS2(RS2), .WS(WS));

  b_clkGen #(.period(10), .length(100)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, clk, D, Q1, Q2, RS1, RS2, WS);
  end
  
  always #10 D = D + 1;

  initial begin
    // D = 0;
    // WS = #10 7'b0001100;
    // WS = #10 7'b0011010;
    // WS = #10 7'b1100101;
    // WS = #10 7'b1000101;


    // RS1 = #3 7'b0001100;
    // RS2 = #3 7'b0011010;
    // RS1 = #3 7'b1100101;
    // RS2 = #3 7'b1000101;

    D = 0;
    WS = #10 7'b0000000;
    WS = #10 7'b0000001;
    WS = #10 7'b0000010;
    WS = #10 7'b0000011;


    RS1 = #3 7'b0000000;
    RS2 = 7'b0000000;
    RS1 = #3 7'b0000001;
    RS2 = 7'b0000001;
    RS1 = #3 7'b0000010;
    RS2 = 7'b0000010;
    RS1 = #3 7'b0000011;
    RS2 = 7'b0000011;
  end
endmodule
// */

/*
module fullAdder_param_tb;
  parameter size = 32;
  parameter delay = 0;
  reg[size-1:0] A;
  reg[size-1:0] B;
  reg[size-1:0] Cin;

  wire[size-1:0] Cout;
  wire[size-1:0] S;

  wire[size:0] Cshift;
  assign Cshift = Cout << 1;

  fullAdder_param #(.size(size), .delay(delay)) uut(.A(A), .B(B), .Cin(Cin), .Cout(Cout), .S(S));
          
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, A, B, Cin, Cout, Cshift, S);
    $display("A   B   Cin   Cout   Cshift   S");
    $monitor("%d; %d; %d; %d; %d; %d;", A, B, Cin, Cout, Cshift, S);
  end
  
  initial begin
    A = 4524;
    B = 13224;
    Cin = 23122;
    #50;
    A = 56345;
    B = 3434;
    Cin = 272;
    #50;
  end
endmodule
// */

/*
module comparator_tb;
  parameter size = 1;
  parameter delay = 0;
  reg[size-1:0] A;
  reg[size-1:0] B;
  reg Lin;
  reg Gin;

  wire L;
  wire E;
  wire G;

  comparator #(.delay(delay)) uut(.A(A), .B(B), .L(L), .E(E), .G(G), .Lin(Lin), .Gin(Gin));
  b_clkGen #(.period(10), .length(200)) b_clkGen(.clk(clk));

          
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, A, B, L, E, G, Lin, Gin);
  end
  
  initial begin
    A = 0;
    B = 0;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;

    A = 0;
    B = 1;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;
    A = 1;
    B = 0;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;
    A = 1;
    B = 1;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;
  end
endmodule
// */

/*
module comparator_param_tb;
  parameter size = 4;
  parameter delay = 0;
  reg[size-1:0] A;
  reg[size-1:0] B;
  reg Lin;
  reg Gin;

  wire L;
  wire E;
  wire G;

  comparator_param #(.delay(delay), .size(size)) uut(.A(A), .B(B), .L(L), .E(E), .G(G), .Lin(Lin), .Gin(Gin));
  b_clkGen #(.period(10), .length(200)) b_clkGen(.clk(clk));

          
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, A, B, L, E, G, Lin, Gin);
  end
  
  initial begin
    A = 254;
    B = 2346234135234;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;

    A = 234524526;
    B = 16645245;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;
    A = 3453453;
    B = 3453453;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;
    A = 6256262;
    B = 6256262;
    Lin = 0;
    Gin = 0;
    #10;
    Lin = 0;
    Gin = 1;
    #10;
    Lin = 1;
    Gin = 0;
    #10;
  end
endmodule
// */

/*
module b_program_counter_tb;
  parameter size = 32;
  reg[size-1-6:0] imm;
  reg clk;
  reg reset;
  reg jump;
  wire[size-1:0] pc;
  reg[size-1:0] imm4;

  assign imm4 = imm * 4;
  b_program_counter #(.width(32), .op_w(6)) uut(.clk(clk), .reset(reset), .jump(jump), .imm(imm), .pc(pc));
  b_clkGen #(.period(10), .length(600)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");

    //change this
    $dumpvars(1, clk, reset, jump, imm4, pc);
  end
  
  initial begin
    imm = 3242134;
    #10;
    reset = 0;
    jump = 1;
    imm = 1342134;
    #10;
    reset = 0;
    jump = 0;
    imm = 1342134;
    #10;
    reset = 1;
    jump = 0;
    imm = 1342134;
    #10;
    reset = 0;
    jump = 0;
    imm = 1342134;
    #10;
    #10;
    #10;

  end
endmodule
// */

/*
module b_sign_extend_tb;
  parameter size = 8;
  reg[size-1:0] out;
  reg[size/2-1:0] in;
  reg clk;

  b_sign_extend #(.iw(4), .ow(8)) uut(.in(in), .out(out));
  b_clkGen #(.period(10), .length(600)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");

    //change this
    $dumpvars(1, in, out);
  end
  
  initial begin
    in = 4'b0000;
    #10;
    in = 4'b1000;
    #10;
    in = 4'b0011;
    #10;
    in = 4'b1001;
    #10;
    in = 4'b1100;
    #10;
    in = 4'b0000;
    #10;

  end
endmodule
// */

/*
module b_memory_tb;
  parameter delay = 0;

  //change below
  parameter addrSize = 32;
  parameter width = 32;
  reg[addrSize-1:0] address;
  reg[width-1:0] in;
  wire[width-1:0] out;
  reg write;
  b_memory #(.addrSize(addrSize), .width(width)) uut(.address(address), .in(in), .clk(write), .out(out));
  b_clkGen #(.period(10), .length(600)) b_clkGen();

  initial begin
    $dumpfile("dump.vcd");

    //change this
    $dumpvars(1, write, address, in, out);
  end
  
  initial begin

    //change this
    write = 0;
    address = 0;
    in = 5;
    #10;
    write = 1;
    #10;
    write = 0;
    #50;
    address = 1;
    in = 7;
    #50;
    address = 0;
    #50;
    address = 1;
    #10;
    write = 1;
    #10;
    write = 0;
    #10;
    address = 0;
    #50;
    address = 1;
  end
endmodule
// */

// /*
module b_print_tb;
  //change below
  parameter width = 32;
  reg[width-1:0] data;
  wire[width-1:0] out;

  reg prt;
  reg_param #(.size(32)) printer(.clk(prt), .D(data), .Q(out));
  b_clkGen #(.period(10), .length(600)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");

    //change this
    $dumpvars(1, data, prt, out);
    $monitor("Fib Output: %d", out);
  end

  initial begin
    data = 5;

    #10;  // Delay for simulation purposes

    prt = 1;
  end
endmodule
// */

/*
module template_tb;
  parameter delay = 0;

  //change below
  parameter size = 1;
  reg[size-1:0] inputs;
  wire[size-1:0] outputs;
  comparator #(.delay(delay)) uut(.A(A), .B(B), .L(L), .E(E), .G(G));
  b_clkGen #(.period(10), .length(600)) b_clkGen(.clk(clk));

  initial begin
    $dumpfile("dump.vcd");

    //change this
    $dumpvars(1, A, B, L, E, G);
  end
  
  initial begin

    //change this
    A = 0;
    B = 0;
    #50;
    A = 0;
    B = 1;
    #50;
    A = 1;
    B = 0;
    #50;
    A = 1;
    B = 1;
    #50;
  end
endmodule
// */


