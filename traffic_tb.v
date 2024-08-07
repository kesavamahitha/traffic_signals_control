`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2024 16:00:36
// Design Name: 
// Module Name: traffic_tb
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
`timescale 1ns / 1ps

module traffic_tb();

    reg X;
    reg clock;
    reg clear;

    wire [1:0] C;
    wire [1:0] H;

    traffic uut (
        .X(X), 
        .clock(clock), 
        .clear(clear), 
        .C(C), 
        .H(H)
    );

    always #5 clock = ~clock;  

    initial begin
        X = 0;
        clock = 0;
        clear = 0;

        #10;

        clear = 1;
        #10;
        clear = 0;

        #10; X = 1;  
        #20; X = 0;  
        #20; X = 1;  
        #20; X = 0;  
        #20; X = 1; 

        #50;

        $finish;
    end

endmodule

