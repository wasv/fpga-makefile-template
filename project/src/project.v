module TOP(
           input            nrst,
           input            clk,
           output reg [3:0] led
           );

   reg [32:0]               counter;

   always@(posedge clk, negedge nrst) begin
      if(!nrst)
        counter <= 0;
      else
        counter <= counter + 8'd1;
   end

   always led <= ~counter[27:24];

endmodule
