module fifo_alu_dut #(parameter WIDTH = 8)
                     (
                        input clk,
                        input reset,
                        input write_enable,
                        input [(2 * WIDTH + 4) - 1: 0] write_data,
                        output full,
                        output [WIDTH - 1: 0] result,
                        output carry_out,
                        output zero,
                        output negative,
                        output [2:0] cmp_out,
                        output result_valid
                     );

            wire empty,
                 full_internal,
                 read_enable,
                 capture_enable;
            wire [(2 * WIDTH + 4) - 1 : 0] read_data;
            wire [3:0] opcode;
            wire [WIDTH - 1: 0] a,
                                b;
            wire [WIDTH - 1 : 0] alu_result;
            wire alu_carry,
                 alu_zero,
                 alu_negative;
            wire [2:0] alu_cmp;
            
            reg [3:0] reg_opcode;
            reg [WIDTH - 1: 0] reg_a, reg_b;

            assign full = full_internal;
            assign b = read_data[WIDTH - 1 : 0];
            assign a = read_data[(2 * WIDTH) - 1 : WIDTH];
            assign opcode = read_data[(2 * WIDTH + 4) - 1 : (2 * WIDTH)];

            assign carry_out = alu_carry;
            assign zero = alu_zero;
            assign negative = alu_negative;
            assign cmp_out = alu_cmp;

            always @(posedge clk) begin
                if (!empty) begin
                    reg_opcode <=opcode;
                    reg_a <= a;
                    reg_b <= b;
                end
            end

            sync_fifo d0 (
                        .clk(clk), .reset(reset), 
                        .write_enable(write_enable),
                        .write_data(write_data),
                        .read_enable(read_enable),
                        .read_data(read_data),
                        .full(full_internal),
                        .empty(empty)
                        );

            control_fsm d1 (
                                .clk(clk), .reset(reset),
                                .empty(empty), .read_enable(read_enable),
                                .capture_enable(capture_enable),
                                .result_valid(result_valid)
                           );
            
            alu d2 (
                        .a(reg_a), .b(reg_b), .opcode(reg_opcode),
                        .result(alu_result), .carry_out(alu_carry),
                        .zero(alu_zero), .negative(alu_negative),
                        .cmp_out(alu_cmp)
                   );
            
            param_register d3 (
                                    .clk(clk), .rstn(~reset),
                                    .enable(capture_enable),
                                    .d(alu_result), .q(result)
                              );
        


endmodule