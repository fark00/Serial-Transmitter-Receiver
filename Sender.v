module Sender(Clk, Send, Out, Send_flag);

parameter [7:0] Packet_Length = 8'h14;

input Clk, Send;
output reg [7:0] Out;
output reg Send_flag;

integer count;
integer parity_count;
reg [2:0] state;
reg [7:0] data;

`define IDLE 3'b000
`define LENGTH 3'b001
`define DATA 3'b010
`define PARITY 3'b011
`define STOP 3'b100

always @(posedge Clk)
begin
	case(state)
		`IDLE: if(Send) state = `LENGTH;
		`LENGTH: state = `DATA;
		`DATA: if(count >= Packet_Length) state = `PARITY;
		`PARITY: state = `STOP;
		`STOP: state = `STOP;
		default: state = `IDLE;
	endcase
	
	if (state == `IDLE)
	begin
		count = 0;
		Send_flag = 0;
	end	

	if (state == `LENGTH)
	begin
		Out = Packet_Length;
		Send_flag = 1;
		parity_count = one_count(Packet_Length);
	end
		
	if (state == `DATA)
	begin
		data = $random % 8;
		parity_count = parity_count + one_count(data);
		Out = data;
		count = count + 1;
	end
	if (state == `PARITY)
	begin
		if(parity_count % 2 == 0)
			Out = 0;
		else
			Out = 1;
	end
	if (state == `STOP)
		Send_flag = 0;
		
end

function [2:0] one_count;
	input [7:0] data;
	integer i;
	begin
	one_count = 3'b0;
	for(i = 0 ; i < 8 ; i = i + 1)
		if(data[i] == 1)
			one_count = one_count + 1;
	end
endfunction

endmodule





