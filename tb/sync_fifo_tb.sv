module sync_fifo_tb;

reg clk, reset, write_enable, read_enable;
reg [19:0] write_data; // 2*8+4 = 20 bits for W=8
wire [19:0] read_data;
wire full, empty;

localparam DEPTH = 16;

sync_fifo dut (
                .clk(clk), .reset(reset),
                .write_enable(write_enable), .write_data(write_data),
                .read_enable(read_enable), .read_data(read_data),
                .full(full), .empty(empty)
              );

always #5 clk = ~clk;

integer i;
integer j;
integer k;
integer l;

initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0, sync_fifo_tb);
     
    clk = 0;
    reset = 1;
    write_enable = 0;
    read_enable = 0;
    write_data = 0;
    #10;
    reset = 0;

    // TEST STEPS HERE
    for (i = 0; i < DEPTH; i = i + 1) begin
        write_data = i;
        write_enable = 1;
        #10;
    end

    #10;
    write_enable = 0;
    $display("full = %d", full == 1);

    for (j = 0; j < DEPTH; j = j + 1) begin 
        #10;
        read_enable = 1;
        $display("Read value: %d", read_data);
    end
    
    #10;
    read_enable = 0;
    $display("empty = %d", empty == 1);

    for (k = 0; k < (DEPTH / 4); k = k + 1) begin
        #10;
        write_enable = 1;
        read_enable = 0;
        write_data = k;
    end
    

    for (l = 0; l < (DEPTH / 4); l = l + 1) begin
        #10;
        write_enable = 1;
        write_data = l;
        read_enable = 1;
        $display("Read value: %d", read_data);
    end

    write_enable = 0;
    read_enable = 0;

    #100;
    $finish;

end


endmodule