// Single-bit D Flip-Flop with enable
//   Positive edge triggered


module regfile
  (
  output[31:0]  ReadData1,      // Contents of first register read
  output[31:0]  ReadData2,      // Contents of second register read
  input[31:0]   WriteData,      // Contents to write to register
  input[4:0]    ReadRegister1,  // Address of first register to read
  input[4:0]    ReadRegister2,  // Address of second register to read
  input[4:0]    WriteRegister,	// Address of register to write
  input         RegWrite,       // Enable writing of register when High
  input         Clk             // Clock (Positive Edge Triggered)
);


endmodule


module register
  (
  output reg	q,
  input		d,
  input		wrenable,
  input		clk
  );

      always @(posedge clk) begin
          if(wrenable) begin
              q <= d;
          end
      end

endmodule

module register32
  (
  output reg[31:0]	q,
  input[31:0]	d,
  input[31:0]	wrenable,
  input		clk
  );

  generate
      genvar i;
      for (i=0; i<32; i=i+1)
  //makes flipflop for each bit of memory
      begin
          register registerSlice (
              .q(q[i]),
              .d(d[i]),
              .wrenable (wrenable[i]),
              .clk (clk)
          );
      end
    endgenerate

endmodule

module register32zero
(
  output[31:0]	q,
  input[31:0]	d,
  input[31:0]	wrenable,
  input		clk
  );

  generate
      genvar i;
      for (i=0; i<32; i=i+1)
  //makes a flipflop for each bit of memory
      begin
      always @(posedge clk) begin
          if(wrenable[i]) begin
              q[i] <= 0;
          end
      end
      end
    endgenerate

endmodule


module mux32to1by1
(
output      out,
input[4:0]  address,
input[31:0] inputs
);

//--- this
assign out=inputs[address];
// -- or this
/*
  always @(address)
    case (address)
      5’b00000 : out = inputs[0];
      5’b00001 : out = inputs[1];
      5’b00010 : out = inputs[2];
      5’b00011 : out = inputs[3];
      5’b00100 : out = inputs[4];
      5’b00101 : out = inputs[5];
      5’b00110 : out = inputs[6];
      5’b00111 : out = inputs[7];
      5’b01000 : out = inputs[8];
      5’b01001 : out = inputs[9];
      5’b01010 : out = inputs[10];
      5’b01011 : out = inputs[11];
      5’b01100 : out = inputs[12];
      5’b01101 : out = inputs[13];
      5’b01110 : out = inputs[14];
      5’b01111 : out = inputs[15];
      5’b01111 : out = inputs[16];
      5’b10000 : out = inputs[17];
      5’b10001 : out = inputs[18];
      5’b10010 : out = inputs[19];
      5’b10011 : out = inputs[20];
      5’b10100 : out = inputs[21];
      5’b10101 : out = inputs[22];
      5’b10110 : out = inputs[23];
      5’b10111 : out = inputs[24];
      5’b11000 : out = inputs[25];
      5’b11001 : out = inputs[26];
      5’b11010 : out = inputs[27];
      5’b11011 : out = inputs[28];
      5’b11100 : out = inputs[29];
      5’b11101 : out = inputs[30];
      5’b11110 : out = inputs[31];
      5’b11111 : out = inputs[32];
    endcase*/
  endmodule

  module mux32to1by32
  (
  output[31:0]  out,
  input[4:0]    address,
  input[31:0]   input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31
  );

    wire[31:0] mux[31:0];			// Create a 2D array of wires
    assign mux[0] = input0;		// Connect the sources of the array
    assign mux[1] = input1;
    assign mux[2] = input2;
    assign mux[3] = input3;
    assign mux[4] = input4;
    assign mux[5] = input5;
    assign mux[6] = input6;
    assign mux[7] = input7;
    assign mux[8] = input8;
    assign mux[9] = input9;
    assign mux[10] = input10;
    assign mux[11] = input11;
    assign mux[12] = input12;
    assign mux[13] = input13;
    assign mux[14] = input14;
    assign mux[15] = input15;
    assign mux[16] = input16;
    assign mux[17] = input17;
    assign mux[18] = input18;
    assign mux[19] = input19;
    assign mux[20] = input20;
    assign mux[21] = input21;
    assign mux[22] = input22;
    assign mux[23] = input23;
    assign mux[24] = input24;
    assign mux[25] = input25;
    assign mux[26] = input26;
    assign mux[27] = input27;
    assign mux[28] = input28;
    assign mux[29] = input29;
    assign mux[30] = input30;
    assign mux[31] = input31;

    // Repeat 31 times...
    assign out = mux[address];	// Connect the output of the array
  endmodule

module decoder1to32
  (
  output[31:0]  out,
  input         enable,
  input[4:0]    address
  );
      assign out = enable<<address;
endmodule
