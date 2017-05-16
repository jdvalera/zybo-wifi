`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2017 10:10:50 AM
// Design Name: 
// Module Name: h_bridge_ctrl
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


module h_bridge_ctrl(
        input wire clk,
        input wire [15:0] pwm_in,
        input wire [7:0] cmd,
        output reg pwm_m1,
        output reg pwm_m2,
        output reg dir_m1,
        output reg dir_m2
    );
    reg [16:0] cnt = 0;
    reg en = 0;
    
    always @(posedge clk)
       begin 
        if (cnt < 65_535)
            cnt <= cnt + 1'b1;
        else
            cnt <= 0;
       end
       
    always @*
        begin
            case(cmd)
                0://stop
                begin
                    dir_m1 = 0;
                    dir_m2 = 0;
                    en = 0;
                end
                1://forward
                begin
                    dir_m1 = 0;
                    dir_m2 = 1;
                    en = 1;
                end
                2://right
                begin
                    dir_m1 = 1;
                    dir_m2 = 1;
                    en = 1;
                end
                3://back
                begin
                    dir_m1 = 1;
                    dir_m2 = 0;
                    en = 1;
                end
                4://left
                begin
                    dir_m1 = 0;
                    dir_m2 = 0;
                    en = 1;
                end
                default:
                begin
                    dir_m1 = 0;
                    dir_m2 = 0;
                    en = 0;
                end
            endcase
        end
       
    always @*
        begin
            if (en)
                begin
                    if (pwm_in < cnt)
                        begin
                            pwm_m1 = 0;
                            pwm_m2 = 0;
                        end
                    else
                        begin
                            pwm_m1 = 1;
                            pwm_m2 = 1;
                        end
                end
            else
                begin
                    pwm_m1 = 0;
                    pwm_m2 = 0;
                end
        end
   
endmodule
