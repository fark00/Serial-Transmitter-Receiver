module String_Detector(String_1, String_2, Receive_flag, Clk, N);

input [7:0] String_1, String_2;
input Clk;
input Receive_flag;
output reg [7:0] N = 0;
integer counter = 0, i = 0;


always @(posedge Clk)
begin
	if(Receive_flag == 1)
	begin
		if(i == 0)
		begin
			counter = String_2;
			i = i + 1;
		end
		else if(i <= counter + 1)
		begin
			i = i + 1;
			if(String_2 == String_1)
			begin
				N = N + 1;
			end
		end
	end
end

endmodule
