module Top_module;

reg Clk, Send;
wire Dout, Dout_Valid, Busy;
wire [7:0] N;

defparam c.String_1 = 8'b00000101;

Controller c(Clk, Send, Busy, Dout, Dout_Valid, N);

always 
	#20 Clk = ~Clk;
	
initial
begin
	Clk = 1;
	Send = 0;
	#320 Send = 1;
	#40 Send = 0;
	#7490 $finish;
end

endmodule