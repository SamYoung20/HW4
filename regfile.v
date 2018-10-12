//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module regfile
(
  //Deliverable 7
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

  wire[31:0] enablewires;
  wire[31:0] register[31:0];
  decoder1to32 decode(.out(enablewires),.enable(RegWrite), .address(WriteRegister));

  generate
      genvar i;
      for (i=1; i<32; i=i+1)
            begin
            register32 reg32(.q(register[i]),.d(WriteData), .wrenable(enablewires[i]), .clk(Clk));
      end
    endgenerate
  register32zero reg32(.q(register[0]),.d(WriteData), .wrenable(enablewires[0]), .clk(Clk));
  mux32to1by32 read1(.out(ReadData1),.address(ReadRegister1),
      .input0(register[0]),
      .input1(register[1]),
      .input2(register[2]),
      .input3(register[3]),
      .input4(register[4]),
      .input5(register[5]),
      .input6(register[6]),
      .input7(register[7]),
      .input8(register[8]),
      .input9(register[9]),
      .input10(register[10]),
      .input11(register[11]),
      .input12(register[12]),
      .input13(register[13]),
      .input14(register[14]),
      .input15(register[15]),
      .input16(register[16]),
      .input17(register[17]),
      .input18(register[18]),
      .input19(register[19]),
      .input20(register[20]),
      .input21(register[21]),
      .input22(register[22]),
      .input23(register[23]),
      .input24(register[24]),
      .input25(register[25]),
      .input26(register[26]),
      .input27(register[27]),
      .input28(register[28]),
      .input29(register[29]),
      .input30(register[30]),
      .input31(register[31])
      );
      mux32to1by32 read2(.out(ReadData2),.address(ReadRegister2),
          .input0(register[0]),
          .input1(register[1]),
          .input2(register[2]),
          .input3(register[3]),
          .input4(register[4]),
          .input5(register[5]),
          .input6(register[6]),
          .input7(register[7]),
          .input8(register[8]),
          .input9(register[9]),
          .input10(register[10]),
          .input11(register[11]),
          .input12(register[12]),
          .input13(register[13]),
          .input14(register[14]),
          .input15(register[15]),
          .input16(register[16]),
          .input17(register[17]),
          .input18(register[18]),
          .input19(register[19]),
          .input20(register[20]),
          .input21(register[21]),
          .input22(register[22]),
          .input23(register[23]),
          .input24(register[24]),
          .input25(register[25]),
          .input26(register[26]),
          .input27(register[27]),
          .input28(register[28]),
          .input29(register[29]),
          .input30(register[30]),
          .input31(register[31])
          );
  // These two lines are clearly wrong.  They are included to showcase how the
  // test harness works. Delete them after you understand the testing process,
  // and replace them with your actual code.
  //assign ReadData1 = 42;
  //assign ReadData2 = 42;

endmodule



/*
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
*/
module register32
//Deliverable 2
  (
  output reg[31:0]	q,
  input[31:0]	d,
  input wrenable,
  input	   clk
  );

  always @(posedge clk) begin
      if(wrenable) begin
          q <= d;
      end
  end

endmodule

module register32zero
//Deliverable 3
(
  output reg[31:0]	q,
  input[31:0]	d,
  input  wrenable,
  input		clk
  );

      always @(posedge clk) begin
          if(wrenable) begin
              q <= 0;
          end
      end


endmodule

module mux32to1by32
//Deliverable 5
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
