`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2024 15:55:11
// Design Name: 
// Module Name: traffic
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
`define TRUE 1'b1;
`define FALSE 1'b0;

module traffic(X,clock,clear,C,H);
    input X;
    input clock, clear;
    output [1:0] C, H;
    
    reg [1:0] C, H;
    reg [2:0] state, next_state;
    
    parameter R = 2'b00;
    parameter Y = 2'b01;
    parameter G = 2'b10;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    
    parameter Y2RDELAY = 3;
    parameter R2GDELAY = 2;
    
    always @ (posedge clock) 
        if(clear)
            state <= S0;
        else
            state = next_state;
    
    always @ (state)
    begin
        H = G;
        C = R;
        case(state)
        
        S0: ;
        S1 : H = Y;
            
        S2 : H = R;
        
        S3 : begin
            H = R;
            C = G;
            end
        S4 : begin
            H = R;
            C = Y;
            end
        endcase
    end
    
    always @ (state or X)
    begin
        case(state)
        S0: if(X) 
                next_state = S1;
            else
                next_state = S0;
        S1: begin
            repeat (Y2RDELAY) next_state = S1;
            next_state = S2;
            end
        S2: begin
            repeat (R2GDELAY) next_state = S2;
            next_state = S3;
            end
        S3: if(~X) 
                next_state = S4;
            else
                next_state = S3;
        S4: begin
            repeat (Y2RDELAY) next_state = S4;
            next_state = S0;
            end
        default: next_state = S0;
        endcase
    end
endmodule


