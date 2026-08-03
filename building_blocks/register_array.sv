module register_arr #(parameter DATA_WIDTH = 8, parameter DEPTH = 16)
                     (input logic clk, 
                     input logic write_enable,
                     input logic [$clog2(DEPTH) - 1:0] write_addr,
                     input logic [DATA_WIDTH - 1: 0] write_data, 
                     input logic [$clog2(DEPTH) - 1: 0] read_addr, 
                     output logic [DATA_WIDTH - 1: 0] read_data);

                     logic [DATA_WIDTH - 1: 0] mem [DEPTH - 1: 0];

                     always_ff @(posedge clk) begin
                         if (write_enable) begin
                             mem[write_addr] <= write_data;
                         end
                     end

                     assign read_data = mem[read_addr];
endmodule