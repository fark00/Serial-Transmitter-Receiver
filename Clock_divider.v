module Clock_divider(clock_in,clock_out);

input clock_in;
output clock_out;

reg [27:0] counter=28'd0;
parameter real DIVISOR = 28'd9;

always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter >= (DIVISOR-1))
  counter <= 28'd1;
end

assign clock_out = (counter < DIVISOR / 2) ? 1'b1: 1'b0;

endmodule

