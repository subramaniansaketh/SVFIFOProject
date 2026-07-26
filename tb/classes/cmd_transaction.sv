class cmd_transaction #(int WIDTH = 8);
    // What goes into the DUT
    logic [3:0] opcode;
    logic [WIDTH - 1: 0] a;
    logic [WIDTH - 1: 0] b;
    // Outputs
    logic [WIDTH - 1: 0] exp_result;
    logic exp_carry_out;
    logic exp_zero;
    logic exp_negative;
    logic [2:0] exp_cmp_out; // {lt, eq, gt}

    function new();
        this.opcode = 0;
        this.a = 0;
        this.b = 0;
        this.exp_result = 0;
        this.exp_carry_out = 0;
        this.exp_zero = 0;
        this.exp_negative = 0;
        this.exp_cmp_out = 0;
    endfunction

    function void compute_expected();
        this.exp_result = 0;
        this.exp_carry_out = 0;
        this.exp_zero = 0;
        this.exp_negative = 0;
        this.exp_cmp_out = 0;
        
        case (opcode)
            4'b0000: begin
                {this.exp_carry_out, this.exp_result} = this.a + this.b;
            end
            4'b0001: begin
                {this.exp_carry_out, this.exp_result} = this.a - this.b;
            end
            4'b0010: begin
                this.exp_result = this.a & this.b;
            end
            4'b0011: begin
                this.exp_result = this.a | this.b;
            end
            4'b0100: begin
                this.exp_result = this.a ^ this.b;
            end
            4'b0101: begin
                this.exp_result = ~this.a;
            end
            4'b0110: begin
                this.exp_result = this.a << 1'b1;
            end
            4'b0111: begin
                this.exp_result = this.a >> 1'b1;
            end
            4'b1000: begin
                this.exp_cmp_out = {this.a < this.b, this.a == this.b, this.a > this.b};
            end
            4'b1001: begin
                for (int i = 0; i < WIDTH; i++) begin
                    if (this.a[i]) begin
                        this.exp_result += 1;
                    end
                end
            end
            default: begin
                this.exp_result = 0;
                this.exp_carry_out = 0;
                this.exp_zero = 0;
                this.exp_negative = 0;
                this.exp_cmp_out = 0;
            end
        endcase

        this.exp_zero = (this.exp_result == 0);
        this.exp_negative = (this.exp_result[WIDTH - 1] == 1);
    endfunction

    function void print();
        $display("OPCODE: %b, a = %b, b = %b | exp_result = %b, zero = %b, carry = %b, negative = %b, cmp (LT, EQ, GT): %b", this.opcode, this.a, this.b, this.exp_result, this.exp_zero, this.exp_carry_out, this.exp_negative, this.exp_cmp_out);
    endfunction

    function bit compare (logic [WIDTH - 1: 0] actual_result, logic actual_carry, logic actual_zero, 
    logic actual_negative, logic [2:0] actual_cmp);
        bit pass;

        if (actual_result == exp_result && actual_carry == exp_carry_out && 
        actual_zero == exp_zero && actual_negative == exp_negative && 
        actual_cmp == exp_cmp_out) begin
            pass = 1'b1;
            $display("PASS");
        end
        else begin
            pass = 1'b0;
            $display("FAIL");
        end

        return pass;
    endfunction



endclass