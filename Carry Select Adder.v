FULL ADDER: 
module full_adder(
    input a,b,cin,
    output sum,carry
    );
    assign sum=a^b^cin;
    assign carry=(a&b)|((a^b)&cin);
endmodule
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RIPPLE CARRY ADDER:
module rca(
    input [3:0]a,
    input [3:0]b,
    input c,
    output [3:0]sum,
    output cout
    );
    wire c1,c2,c3;
    full_adder fa1(a[0],b[0],c,sum[0],c1);
    full_adder fa2(a[1],b[1],c1,sum[1],c2);
    full_adder fa3(a[2],b[2],c2,sum[2],c3);
    full_adder fa4(a[3],b[3],c3,sum[3],cout);
endmodule
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CARRY SELECT ADDER:(WITHOUT MUX)
module carry_select_adder(
    input [3:0] a,
    input [3:0]b,
    input cin,
    output [3:0] sum,
    output cout
    );

wire [3:0]s0;
wire [3:0]s1;
wire c0,c1;
rca r0(a,b,1'b0,s0,c0);
rca r1(a,b,1'b1,s1,c1);

assign s = (cin == 1'b0) ? s0 : s1;
assign cout = (cin == 1'b0) ? c0 : c1;
endmodule
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MULTIPLIXER 2 TO 1:
module mux_221(
    input d1,d0,
    input sel,
    output reg y
    );
    
always@(sel) begin
    case(sel)
        1'b0:y=d0;
        1'b1:y=d1;
    endcase
end
endmodule
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CARRY SELECT ADDER:(WITH MUX)
module carry_select_adder(
    input [3:0] a,
    input [3:0]b,
    input cin,
    output [3:0] sum,
    output cout
    );

wire [3:0]s0;
wire [3:0]s1;
wire c0,c1;
rca r0(a,b,1'b0,s0,c0);
rca r1(a,b,1'b1,s1,c1);

mux_221 mux1(s1[0],s0[0],cin,sum[0]);
mux_221 mux2(s1[1],s0[1],cin,sum[1]);
mux_221 mux3(s1[2],s0[2],cin,sum[2]);
mux_221 mux4(s1[3],s0[3],cin,sum[3]);

mux_221 c(c1,c0,cin,cout);
endmodule
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
