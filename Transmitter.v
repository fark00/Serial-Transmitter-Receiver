module Transmitter(Packet, tClk, Send_flag, Dout, Busy, Dout_Valid);

input [7:0] Packet;
input tClk, Send_flag;
output reg Dout, Busy, Dout_Valid;
integer i = 0;
integer counter = 0;
reg [7:0] Packet_Length = 0;

always @(posedge tClk)
begin
	if(Send_flag == 1 && counter < Packet_Length + 3)
	begin
		Dout = Packet[i];
		i = i + 1;
		if(counter == 0)
		begin
				Packet_Length = Packet;
				counter = counter + 1;
		end
				
		if(i == 8 || counter == Packet_Length + 2)
		begin
			i = 0;
			counter = counter + 1;
		end
		
		Busy = 1;
		Dout_Valid = 1;
	end
	else
	begin
		i = 0;
		Dout = 1'bx;
		Busy = 0;
		Dout_Valid = 0;
	end
end

endmodule