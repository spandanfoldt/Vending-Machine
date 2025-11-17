`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2025 08:38:13 PM
// Design Name: 
// Module Name: VendingMachineTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module VendingMachineTB;

    // Inputs
    reg CLK;
    reg RST;
    reg START;
    reg CANCEL;
    reg [2:0] PRODUCT_CODE;
    reg ONLINE_PAYMENT;
    reg [6:0] COINS;

    // Outputs
    wire [3:0] STATE;
    wire DISPENSE_PRODUCT;
    wire [6:0] RETURN_CHANGE_VALUE;
    wire [6:0] PRODUCT_PRICE_VALUE;

    // Clock generation
    always #5 CLK = ~CLK;  // 10ns clock period = 100MHz

    // Test sequence
    initial begin
        CLK = 0;
        RST = 1;
        START = 0;
        CANCEL = 0;
        COINS = 0;
        ONLINE_PAYMENT = 0;
        PRODUCT_CODE = 3'b000;

        // Hold reset for 100ns
        #100 RST = 0;
        #100;

        // Attempt online payment
        START = 1;
        ONLINE_PAYMENT = 1;
        #30;
        START = 0;
        ONLINE_PAYMENT = 0;

        #50;

        // Notebook purchase with insufficient coins
        START = 1;
        PRODUCT_CODE = 3'b001;  // notebook
        COINS = 7'd60;
        #30;
        START = 0;

        #50;

        // Water bottle purchase with insufficient coins
        START = 1;
        PRODUCT_CODE = 3'b100;  // water bottle
        COINS = 7'd20;
        #30;
        START = 0;

        #50;

        // Water bottle purchase with sufficient coins
        START = 1;
        PRODUCT_CODE = 3'b100;  // water bottle
        COINS = 7'd30;
        #30;
        START = 0;

        #50;
        $finish;
    end

    // DUT instantiation
    VendingMachine DUT (
        .i_clk(CLK),
        .i_rst(RST),
        .i_start(START),
        .i_cancel(CANCEL),
        .i_product_code(PRODUCT_CODE),
        .i_online_payment(ONLINE_PAYMENT),
        .i_total_coin_value(COINS),
        .o_state(STATE),
        .o_dispense_product(DISPENSE_PRODUCT),
        .o_return_change(RETURN_CHANGE_VALUE),
        .o_product_price(PRODUCT_PRICE_VALUE)
    );

endmodule
