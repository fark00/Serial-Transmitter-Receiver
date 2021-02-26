module Receiver (Dout,Dout_Valid,tClk, Receive_flag,Packet);

input tClk,Dout,Dout_Valid;
output reg [7:0] Packet;
output reg Receive_flag;
reg [7:0] data;
reg [7:0] Packet_Length = 0;
integer counter = 1;
integer i = 0;

always @(posedge tClk)
begin
	if(Dout_Valid == 1 || counter == Packet_Length + 2)
	begin
		if(Dout_Valid == 1)
		begin
			data[i] = Dout;
			i = i + 1;
		end
		else
		begin
			data[i] = 0;
			i = i + 1;
		end
		
		if(i == 8)
		begin
			i = 0;
			Packet = data;
			if(counter == 1) Packet_Length = data;
			counter = counter + 1;
			Receive_flag = 1;
		end
	end
	else
	begin
		i = 0;
		Receive_flag = 0;
	end
end

endmodule

