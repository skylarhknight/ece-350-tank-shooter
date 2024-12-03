module sll(data_operandA, ctrl_shiftamt, data_result);
        
    input [31:0] data_operandA;
    input [4:0] ctrl_shiftamt;
    output [31:0] data_result;

    wire [31:0] shift1, shift2, shift4, shift8, shift16;

    // Stage 1: Shift by 1 bit
    mux_2_single stage1 [31:0] (.out(shift1), .select(ctrl_shiftamt[0]),  .in0(data_operandA), .in1({data_operandA[30:0], 1'b0}));

    // Stage 2: Shift by 2 bits
    mux_2_single stage2 [31:0] (.out(shift2), .select(ctrl_shiftamt[1]), .in0(shift1), .in1({shift1[29:0], 2'b00}));

    // Stage 3: Shift by 4 bits
    mux_2_single stage3 [31:0] (.out(shift4), .select(ctrl_shiftamt[2]), .in0(shift2), .in1({shift2[27:0], 4'b0000}));

    // Stage 4: Shift by 8 bits
    mux_2_single stage4 [31:0] (.out(shift8), .select(ctrl_shiftamt[3]), .in0(shift4), .in1({shift4[23:0], 8'b00000000}));

    // Stage 5: Shift by 16 bits
    mux_2_single stage5 [31:0] (.out(shift16), .select(ctrl_shiftamt[4]), .in0(shift8), .in1({shift8[15:0], 16'b0000000000000000}));

    // Final output
    assign data_result = shift16;

endmodule