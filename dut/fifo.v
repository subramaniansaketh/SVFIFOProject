module sync_fifo #(parameter W = 8, parameter DEPTH = 16)
                  (
                    input clk,
                    input reset, 
                    input write_enable,
                    input [(2 * W + 4) - 1 : 0] write_data, // data to be written
                    input read_enable,
                    output [(2 * W + 4) - 1: 0] read_data, // data to be read in
                    output full,
                    output empty
                  );

        reg [$clog2(DEPTH): 0] write_pointer;
        reg [$clog2(DEPTH): 0] read_pointer;

        reg [(2 * W + 4) - 1: 0] fifo [DEPTH - 1: 0];

        always @(posedge clk) begin
          if (reset) begin
            write_pointer <= 0;
          end
          else begin
            if (write_enable & !full) begin
              fifo[write_pointer[$clog2(DEPTH) - 1: 0]] <= write_data;
              write_pointer <= write_pointer + 1;
            end
          end
        end

        always @(posedge clk) begin
          if (reset) begin
            read_pointer <= 0;
          end
          else begin
            if (read_enable & !empty) begin
              read_pointer <= read_pointer + 1;
            end
          end
        end

        assign read_data = fifo[read_pointer[$clog2(DEPTH) - 1: 0]];
        assign empty = (read_pointer == write_pointer);
        assign full = (read_pointer[$clog2(DEPTH)] != write_pointer[$clog2(DEPTH)]) & (read_pointer[$clog2(DEPTH) - 1: 0] == write_pointer[$clog2(DEPTH) - 1: 0]);

endmodule