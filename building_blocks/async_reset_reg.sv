module param_register #(parameter WIDTH = 8)
                        (input clk, 
                        input rstn, 
                        input enable, 
                        input [WIDTH - 1: 0] d, 
                        output reg [WIDTH - 1: 0] q);
                
                always @(posedge clk or negedge rstn) begin
                    if (!rstn) begin
                        q <= 0;
                    end
                    else if (enable) begin
                        q <= d;
                    end
                    else begin
                        q <= q;
                    end
                end

endmodule