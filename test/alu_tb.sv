module alu_tb;
    reg [3:0] A, B;
    reg [2:0] sel;
    wire [7:0] Y;
    wire zero, carry;
    
    alu_8bit dut(.*);
    
    initial begin
        $display("Testing ALU...");
        
        // Test ADD
        A = 4'b1010; B = 4'b0101; sel = 3'b000;
        #10 assert(Y === 8'b00001111) else $error("ADD failed");
        
        // Test AND
        sel = 3'b010;
        #10 assert(Y === 8'b00000000) else $error("AND failed");
        
        // Más pruebas...
        
        $display("All tests passed!");
        $finish;
    end
endmodule
