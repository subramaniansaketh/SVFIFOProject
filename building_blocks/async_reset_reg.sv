module param_register #(parameter WIDTH = 8)
                        (input logic clk, 
                        input logic rstn, 
                        input logic enable, 
                        input logic [WIDTH - 1: 0] d, 
                        output logic [WIDTH - 1: 0] q);
                
                always_ff @(posedge clk or negedge rstn) begin
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