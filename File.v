module File(Clk, Packet, Receive_flag);

input Clk;
input Receive_flag;
input [7:0] Packet;
reg [7:0] out;
integer i = 0;
integer Packet_length;
integer count = 0;
integer parity_count;
integer file;


always @(posedge Clk)
	begin
		if (Receive_flag || Packet_length == 0)
		begin
			if(i == 0)
			begin
				i = i + 1;
				Packet_length = Packet;
				out = Packet;
				parity_count = one_count(Packet);
				file = $fopen("E:\\test5.txt", "w");
				$fwrite(file, "data :\n ");
				$fclose(file);
				
			end
			else if (i > 0)
				begin
					if(Packet_length > 0)
					begin
					out = Packet;
					parity_count = parity_count + one_count(Packet);
					//count = count + 1;
					file = $fopen("E:\\test5.txt", "a");
					$fwrite(file, " hex : %h  , binary : %b \n ", out,out);
					$fclose(file);
					Packet_length = Packet_length - 1;
					end
				
					else if(Packet_length <= 0)
					begin
						Packet_length = Packet_length - 1;
						if  (parity_count % 2 != Packet[0])
						begin
							file = $fopen("E:\\test5.txt", "w");
							$fwrite(file, "ERROR");
							$fclose(file);
						end
					end
				end
			
			
		end
		
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
