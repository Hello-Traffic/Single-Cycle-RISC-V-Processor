module DataMemory(
    input rst,
    input clk,
    input memWrite,
    input memRead,
    input [31:0] address,
    input [31:0] writeData,
    output reg [31:0] readData
);

reg [7:0] data_memory [127:0];
integer i;

always @(posedge clk) begin
    if (rst) begin // Reset the memory to zero on reset
        for (i = 0; i < 128; i = i + 1)
            data_memory[i] <= 8'b0;
    end
    else if (memWrite) begin // Write data to memory in little-endian format
        data_memory[address + 3] <= writeData[31:24]; 
        data_memory[address + 2] <= writeData[23:16];
        data_memory[address + 1] <= writeData[15:8];
        data_memory[address]     <= writeData[7:0];
    end
end

always @(*) begin
    if (memRead) begin // Read data from memory in little-endian format
        readData[31:24] = data_memory[address + 3];
        readData[23:16] = data_memory[address + 2];
        readData[15:8]  = data_memory[address + 1];
        readData[7:0]   = data_memory[address];
    end
    else begin
        readData = 32'b0;
    end
end

endmodule