FULL ADDER:
module full_adder(
    input a,b,cin,
    output sum,carry
    );
    assign sum=a^b^cin;
    assign carry=(a&b)|((a^b)&cin);
endmodule
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CARRY SAVE ADDER:
module csa(
    input [3:0] a,b,cin,
    output [3:0] sum,
    output cout
    );

wire [3:0]s,c;   
full_adder fa1(a[0],b[0],cin[0],s[0],c[0]);
full_adder fa2(a[1],b[1],cin[1],s[1],c[1]);
full_adder fa3(a[2],b[2],cin[2],s[2],c[2]);
full_adder fa4(a[3],b[3],cin[3],s[3],c[3]);

assign sum[0]=s[0];
wire c1,c2,c3;

full_adder fa5(c[0],s[1],cin[0],sum[0],c1);
full_adder fa6(c[1],s[2],cin[1],sum[1],c2);
full_adder fa7(c[2],s[3],cin[2],sum[2],c3);
full_adder fa8(c[3],1'b0,cin[3],sum[3],cout);

endmodule
