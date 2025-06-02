`default_nettype none

module tt_um_alu (
    input  wire [7:0] ui_in,    // A[3:0], B[3:0]
    output wire [7:0] uo_out,   // Resultado[7:0]
    input  wire [7:0] uio_in,   // Selector[2:0] + otros
    output wire [7:0] uio_out,  // Flags (zero, carry)
    output wire [7:0] uio_oe,   // Habilitación de salida
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    // Asignación de entradas
    wire [3:0] A = ui_in[3:0];
    wire [3:0] B = ui_in[7:4];
    wire [2:0] sel = uio_in[2:0];

    // Señales internas
    wire [7:0] result;
    wire zero, carry;

    // Instancia de la ALU de 8 bits (ahora con flags)
    alu_8bit alu_core (
        .A(A),
        .B(B),
        .sel(sel),
        .Y(result),
        .zero(zero),
        .carry(carry)
    );

    // Asignación de salidas
    assign uo_out = result;
    assign uio_out = {6'b0, carry, zero}; // Flags en los bits más bajos
    assign uio_oe = 8'b00000011; // Solo los 2 LSB como salidas (flags)

endmodule
