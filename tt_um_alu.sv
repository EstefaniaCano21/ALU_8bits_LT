`default_nettype none

module tt_um_alu (
    input  wire [7:0] ui_in,    // A[3:0] = ui_in[3:0], B[3:0] = ui_in[7:4]
    output wire [7:0] uo_out,   // Resultado de 8 bits (4 bits útiles)
    input  wire [7:0] uio_in,   // Selector: sel[2:0] = uio_in[2:0]
    output wire [7:0] uio_out,  // Flags: uio_out[0] = zero, uio_out[1] = carry
    output wire [7:0] uio_oe,   // Configuración E/S (0=input, 1=output)
    input  wire       ena,      // Habilitación (no usado)
    input  wire       clk,      // Reloj (no usado)
    input  wire       rst_n     // Reset activo bajo (no usado)
);

    // Conexiones
    wire [3:0] A = ui_in[3:0];
    wire [3:0] B = ui_in[7:4];
    wire [2:0] sel = uio_in[2:0];
    wire [3:0] alu_result;
    wire carry, zero;

    // Instancia del núcleo ALU
    alu_4bit alu_core (
        .A(A),
        .B(B),
        .sel(sel),
        .Y(alu_result),
        .carry(carry),
        .zero(zero)
    );

    // Asignación de salidas
    assign uo_out = {4'b0, alu_result};  // Extiende a 8 bits
    assign uio_out = {6'b0, carry, zero};
    assign uio_oe = 8'b00000011;  // Bits 0-1 como salidas (flags)
endmodule
