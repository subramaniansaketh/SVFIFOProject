module register_arr #(parameter DATA_WIDTH = 8, parameter DEPTH = 16)
                     (input clk, 
                     input write_enable,
                     input [$clog2(DEPTH) - 1:0] write_addr,
                     input [DATA_WIDTH - 1: 0] write_data, 
                     input [$clog2(DEPTH) - 1: 0] read_addr, 
                     output wire [DATA_WIDTH - 1: 0] read_data);

                     reg [DATA_WIDTH - 1: 0] mem [DEPTH - 1: 0];

                     always @(posedge clk) begin
                         if (write_enable) begin
                             mem[write_addr] <= write_data;
                         end
                     end

                     assign read_data = mem[read_addr];
endmodule