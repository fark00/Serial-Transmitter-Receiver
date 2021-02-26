module Controller(Clk, Send, Busy, Dout, Dout_Valid, N);

input Clk, Send;
output Busy;
output Dout, Dout_Valid;
output [7:0] N;

wire Sender_clk;
wire [7:0] Data;
wire Send_flag;
wire Receive_flag;
wire [7:0] Packet;

parameter [7:0] String_1 = 8'b00000101;

defparam s.Packet_Length = 8'h14;

Clock_divider c(Clk,Sender_clk);

Sender s(Sender_clk, Send, Data, Send_flag);

Transmitter t(Data, Clk, Send_flag, Dout, Busy, Dout_Valid);

Receiver r(Dout,Dout_Valid,Clk, Receive_flag,Packet);

File f(Sender_clk, Packet, Receive_flag);

String_Detector d(String_1, Packet, Receive_flag, Sender_clk, N);


endmodule
