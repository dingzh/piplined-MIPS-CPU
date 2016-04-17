`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:21:38 03/01/2016 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(
    input        CLOCK,
    input        RESET,
    input [2:0]  MODE,
    output [7:0] LED,
	 input FAST
    );
	 
	 //for IO
////            GENRERATING SLOW CLOCK          ////
	wire CLK;
	reg [26:0] Buffer = 0;
	always@ (posedge CLOCK) Buffer = Buffer + 1;
	assign CLK = FAST ? CLOCK : Buffer[26];

////            IO MODE SEL                     ////
	wire [31:0] IF_CurrPC;
	assign LED[7] = RESET;
	assign LED[6] = CLK;
	wire [5:0] OUTPUT;
	assign LED[5:0] = OUTPUT;
	wire [31:0] reg1;
	wire [31:0] reg2;
	wire [5:0]  reg12;
	assign reg12[5:3] = reg2;
	assign reg12[2:0] = reg1;
	wire [31:0] CURR_PC_IO;
	assign CURR_PC_IO = IF_CurrPC>>2;
	wire [5:0] TEMP1;
	wire [5:0] TEMP2;
	assign TEMP1 = MODE[0] ? reg1:reg12;
	assign TEMP2 = MODE[1] ? reg2:TEMP1;
	assign OUTPUT = MODE[2]? CURR_PC_IO:TEMP2; 
	 
	 //1.0 For stage IF to ID;
	 reg [31:0] IF_ID_PCAdd4;
	 reg [31:0] IF_ID_Instr;
	 
	 //2.0 For stage ID to EX;
	 reg [31:0]  ID_EX_PCAdd4;
	 reg [31:0]  ID_EX_RegReadData1;
	 reg [31:0]  ID_EX_RegReadData2;
	 reg [31:0]  ID_EX_SignExt;
	 reg [20:16] ID_EX_InstHigh;
	 reg [15:11] ID_EX_InstLow;
	 //2.1 To EX
	 reg [31:0] ID_EX_Instr;
	 reg ID_EX_RegDst;
	 reg [1:0] ID_EX_ALUOp;
	 reg       ID_EX_ALUSrc;
	 //2.2 To MEM
	 reg ID_EX_Jump;
	 reg ID_EX_Branch;
	 reg ID_EX_MemWrite;
	 reg ID_EX_MemRead;
	 //2.3 To WB
	 reg ID_EX_MemToReg;
	 reg ID_EX_RegWrite;
	 
	 //3.0 For stage EX to MEM;
	 reg        EX_MEM_Zero;                 
	 reg [31:0] EX_MEM_ALUOut;
	 reg [31:0] EX_MEM_BranchAddress;
	reg [31:0] EX_MEM_JumpAddress;	 
	 reg [31:0] EX_MEM_RegReadData2;
	 
	 //3.1 To MEM
	 reg EX_MEM_Branch;					
	 reg EX_MEM_MemWrite;
	 reg EX_MEM_MemRead;
	 reg EX_MEM_Jump= 0;
	 reg [4:0]  EX_MEM_RegWriteAddress;  //rt or rd
	 //3.2 To WB
	 reg EX_MEM_MemToReg;
	 reg EX_MEM_RegWrite;
	 
	 //4.0 For stage MEM to WB;
	 reg [31:0] MEM_WB_ALUOut;
	 reg [31:0] MEM_WB_MemReadData;
	 reg [4:0]  MEM_WB_RegWriteAddress;
	 reg        MEM_WB_RegWrite;
	 reg        MEM_WB_MemToReg;
//////////////////////////////////////////////////////////////////////////////////////////////
	
//1.0 IF
	wire IF_PCSrc,  //for MUX sel signal
	     IF_Branch,
		  IF_Zero;
	wire FLUSH;
	wire IF_Jump;
	wire [31:0] IF_BranchAddress;
	wire [31:0] IF_JumpAddress;
	//wire [31:0] IF_CurrPC;    DEFINED BEFORE
	wire [31:0] IF_NextPC;
	wire [31:0] IF_PCAdd4;
	wire [31:0] IF_Instr;	
	//associate with reg
	assign FLUSH = RESET? 0: IF_Branch | IF_Jump;
	assign IF_BranchAddress = EX_MEM_BranchAddress;
	assign IF_Zero = EX_MEM_Zero;
	assign IF_Branch = RESET? 0 : EX_MEM_Branch;
	assign IF_Jump = RESET? 0 :EX_MEM_Jump;
	assign IF_JumpAddress = EX_MEM_JumpAddress;	
	//Combinational Logic
	assign IF_PCAdd4 = IF_CurrPC +4;
	assign IF_PCSrc  = IF_Branch & IF_Zero & ~RESET;
	wire [31:0] IF_NextPCJ;
	assign IF_NextPCJ = IF_Jump? IF_JumpAddress : IF_PCAdd4;
	assign IF_NextPC = IF_PCSrc? IF_BranchAddress: IF_NextPCJ;  //MUX
	
	wire [31:0] IF_JumpAdress;
	//assign IF_NextPC = IF_PCAdd4;
	//update PC at posedge
	Pc mainPC (
    .clock_in(CLK), 
    .nextPC(IF_NextPC), 
    .currPC(IF_CurrPC), 
    .rst(RESET)
    );
	wire [31:0] IF_Index;
	assign IF_Index = IF_CurrPC>>2;
	instructionMemory InstrMemory (
    .address(IF_Index), 
    .clock_in(CLK), 
    .reset(RESET), 
    .readData(IF_Instr)
    );
	//InstMem;
	
//1.5 IF/ID REG UPDATE
	
	always @(posedge CLK)
		begin
			IF_ID_PCAdd4 <= FLUSH ? 0: IF_PCAdd4;
			IF_ID_Instr <= FLUSH ? 0: IF_Instr;
		end
	
//2.0 ID
	wire [31:0] ID_Instr;
	wire [5:0] ID_OpCode;
	wire [31:0] ID_PCAdd4;
	wire [4:0] ID_RegReadAddress1;
	wire [4:0] ID_RegReadAddress2;
	wire [15:0] ID_Imm;
	wire [31:0] ID_SignExt;
	wire [20:16] ID_InstHigh;
	wire [15:11] ID_InstLow;
	wire [31:0] ID_RegReadData1;
	wire [31:0] ID_RegReadData2;
	wire WB_RegWrite,
	     WB_MemToReg;
	wire [4:0]  WB_RegWriteAddress;
	wire [31:0] WB_MemReadData;
	wire [31:0] WB_ALUOut;
	wire [31:0] WB_RegWriteData;
	wire ID_Jump;
	//associate with reg
	assign ID_Instr = IF_ID_Instr;
	assign ID_PCAdd4 = IF_ID_PCAdd4;
	assign ID_OpCode = ID_Instr[31:26];
	assign ID_RegReadAddress1 = ID_Instr[25:21];
	assign ID_RegReadAddress2 = ID_Instr[20:16];
	assign ID_Imm = ID_Instr[15:0];
	assign ID_InstHigh = ID_Instr[20:16];
	assign ID_InstLow  = ID_Instr[15:11];
	assign WB_RegWrite = MEM_WB_RegWrite;
	assign WB_MemToReg = MEM_WB_MemToReg;
	assign WB_RegWriteAddress = MEM_WB_RegWriteAddress;
	assign WB_ALUOut = MEM_WB_ALUOut;
	assign WB_MemReadData = MEM_WB_MemReadData;
	assign WB_RegWriteData = WB_MemToReg? WB_MemReadData: WB_ALUOut;
	
	Register mainReg (
    .clock_in(CLK), 
    .regWrite(WB_RegWrite), 
    .readReg1(ID_RegReadAddress1), 
    .readReg2(ID_RegReadAddress2), 
    .writeReg(WB_RegWriteAddress), 
    .writeData(WB_RegWriteData), 
    .reset(RESET), 
    .readData1(ID_RegReadData1), 
    .readData2(ID_RegReadData2),
	 .reg1(reg1),
	 .reg2(reg2)
    );

	 
	 
	 //To EX
	 wire [1:0] ID_ALUOp;
	 wire ID_RegDst,
			ID_ALUSrc;
	 //2.2 To MEM
	 wire ID_Branch;
	 wire ID_MemWrite;
	 wire ID_MemRead;
	 //2.3 To WB
	 wire ID_MemToReg;
	 wire ID_RegWrite;
	 wire JUMP;  //of no use
	 Ctr mainCtr (
    .opCode(ID_OpCode), 
    .regDst(ID_RegDst), 
    .aluSrc(ID_ALUSrc), 
    .memToReg(ID_MemToReg), 
    .regWrite(ID_RegWrite), 
    .memRead(ID_MemRead), 
    .memWrite(ID_MemWrite), 
    .branch(ID_Branch), 
    .aluOp(ID_ALUOp), 
    .jump(ID_Jump)
    );
	 
	 signExt mainSignExt (
    .inst(ID_Imm), 
    .data(ID_SignExt)
    );
	 
//2.5 ID/EX REG UPDATE
	always @(posedge CLK)
		begin
		  //2.0 For Stage ID To EX
	     ID_EX_PCAdd4       <= FLUSH ? 0: ID_PCAdd4;
	     ID_EX_RegReadData1 <= FLUSH ? 0: ID_RegReadData1;
	     ID_EX_RegReadData2 <= FLUSH ? 0: ID_RegReadData2;
	     ID_EX_SignExt      <= FLUSH ? 0: ID_SignExt;
	     ID_EX_InstHigh     <= FLUSH ? 0: ID_InstHigh;
	     ID_EX_InstLow      <= FLUSH ? 0: ID_InstLow;
	     //2.1 To EX
	     ID_EX_RegDst       <= FLUSH ? 0: ID_RegDst;
	     ID_EX_ALUOp        <= FLUSH ? 0: ID_ALUOp;
	     ID_EX_ALUSrc       <= FLUSH ? 0: ID_ALUSrc;
	     //2.2 To MEM
	     ID_EX_Branch       <= FLUSH ? 0: ID_Branch;
	     ID_EX_MemWrite     <= FLUSH ? 0: ID_MemWrite;
	     ID_EX_MemRead      <= FLUSH ? 0: ID_MemRead;
	     //2.3 To WB
	     ID_EX_MemToReg     <= FLUSH ? 0: ID_MemToReg;
	     ID_EX_RegWrite     <= FLUSH ? 0: ID_RegWrite;
		end
		
//3.0 EX
	//2.0 For stage ID to EX;
	wire [31:0] EX_PCAdd4;
	wire [31:0] EX_ALUSrc1;
	wire [31:0] EX_ALUSrc2;
	wire [31:0] EX_RegReadData2;
	wire [31:0] EX_SignExt;
	wire [20:16] EX_InstHigh;
	wire [15:11] EX_InstLow;
	wire [31:0] EX_Instr;
	wire EX_RegDst,
	     EX_ALUSrc;
	wire [1:0] EX_ALUOp;
	wire [4:0] EX_RegWriteAddress;
	wire [5:0] EX_Funct;
	wire EX_Jump;
	wire [31:0] EX_JumpAddress;
	
	//associate with Reg
	assign EX_RegDst  = ID_EX_RegDst;
	assign EX_ALUOp   = ID_EX_ALUOp;
	assign EX_ALUSrc1 = ID_EX_RegReadData1;
	assign EX_ALUSrc  = ID_EX_ALUSrc;     //contral signal
	assign EX_ALUSrc2 = EX_ALUSrc? EX_SignExt: EX_RegReadData2;
	assign EX_RegWriteAddress = EX_RegDst? EX_InstLow: EX_InstHigh;  //MUX
	assign EX_PCAdd4 = ID_EX_PCAdd4;	
	assign EX_RegReadData2 = ID_EX_RegReadData2;
	assign EX_SignExt  = ID_EX_SignExt;
	assign EX_Funct    = ID_EX_SignExt[5:0];
	assign EX_InstHigh = ID_EX_InstHigh;
	assign EX_InstLow  = ID_EX_InstLow;
	assign EX_Jump = ID_EX_Jump;
	assign EX_Instr = ID_EX_Instr;
	assign EX_JumpAddress[31:28] = EX_PCAdd4[31:28];
	assign EX_JumpAddress[27:2] = EX_Instr[25:0];
	assign EX_JumpAddress[1:0] = 2'b00;//Instances	
	wire [3:0]   EX_ALUCtr;
	AluCtr mainALUCtr (
    .aluOp(EX_ALUOp), 
    .funct(EX_Funct), 
    .aluCtr(EX_ALUCtr)
    );
	
	wire EX_Zero;
	wire [31:0] EX_ALUOut;	
	wire [31:0] EX_ALUSrc1_f;
	wire [31:0] EX_ALUSrc2_f;
	Alu mainALU (
    .input1(EX_ALUSrc1_f), 
    .input2(EX_ALUSrc2_f), 
    .aluCtr(EX_ALUCtr), 
    .zero(EX_Zero), 
    .aluRes(EX_ALUOut)
    );

	 //2.2 To MEM
	 wire EX_Branch,
			EX_MemWrite,
			EX_MemRead;
	 assign EX_Branch   = ID_EX_Branch;
	 assign EX_MemWrite = ID_EX_MemWrite;
	 assign EX_MemRead  = ID_EX_MemRead;
	 //2.3 To WB
	 wire EX_MemToReg,
			EX_RegWrite;
	 assign EX_MemToReg = ID_EX_MemToReg;
	 assign EX_RegWrite = ID_EX_RegWrite;
	 //BranchAddress
	 wire [31:0] EX_BranchAddress;
	 assign EX_BranchAddress = (EX_SignExt<<2) + EX_PCAdd4;

//3.5 EX/MEM REG UPDATE
   always @(posedge CLK)
	  begin
	    EX_MEM_Branch <= FLUSH ? 0: EX_Branch;
		 EX_MEM_MemWrite <= FLUSH ? 0: EX_MemWrite;
		 EX_MEM_MemRead <= FLUSH ? 0: EX_MemRead;
		 EX_MEM_MemToReg <= FLUSH ? 0: EX_MemToReg;
		 EX_MEM_RegWrite <= FLUSH ? 0: EX_RegWrite;
		 EX_MEM_BranchAddress <= FLUSH ? 0: EX_BranchAddress;
		 EX_MEM_Zero <= FLUSH ? 0: EX_Zero;
		 EX_MEM_ALUOut <= FLUSH ? 0: EX_ALUOut;
		 EX_MEM_RegWriteAddress <= FLUSH ? 0: EX_RegWriteAddress;
		 EX_MEM_RegReadData2 <= FLUSH ? 0: EX_RegReadData2;
	  end	
	
//4.0 MEM
	wire MEM_MemWrite,
		  MEM_MemRead;
	wire [4:0] MEM_RegWriteAddress;
	wire [31:0] MEM_ALUOut;
	wire [31:0] MEM_MemWriteData;
	wire [31:0] MEM_MemReadData;
	//associate with reg
	assign MEM_MemWrite = EX_MEM_MemWrite;
	assign MEM_MemRead = EX_MEM_MemRead;
	assign MEM_RegWriteAddress = EX_MEM_RegWriteAddress;
	assign MEM_ALUOut = EX_MEM_ALUOut;
	assign MEM_MemWriteData = EX_MEM_RegReadData2;
	//instances
   dataMemory DataMemory (
    .clock_in(CLK), 
    .address(MEM_ALUOut), 
    .writeData(MEM_MemWriteData), 
    .readData(MEM_MemReadData), 
    .memWrite(MEM_MemWrite), 
    .memRead(MEM_MemRead)
    );
	 
	 //to WB
	 wire MEM_MemToReg,
			MEM_RegWrite;
	 assign MEM_MemToReg = EX_MEM_MemToReg;
	 assign MEM_RegWrite = EX_MEM_RegWrite;
	 
//4.5 MEM/WB REG UPDATE
	always @(posedge CLK)
		begin
			MEM_WB_ALUOut = MEM_ALUOut;
		   MEM_WB_MemReadData = MEM_MemReadData;
	      MEM_WB_RegWriteAddress = MEM_RegWriteAddress;
	      MEM_WB_RegWrite = MEM_RegWrite;
	      MEM_WB_MemToReg = MEM_MemToReg;
      end


//UPDATE REGISTER USED FOR JUMP

	 always @(posedge CLK)	begin
		ID_EX_Jump <= ID_Jump;
		ID_EX_Instr <= ID_Instr;
		EX_MEM_Jump <= EX_Jump;
		EX_MEM_JumpAddress <= EX_JumpAddress;
		end
		
//FORWARDING PART
//MUX
	//wire [31:0] EX_ALUSrc1_f;		//as mux output;
	//wire [31:0] EX_ALUSrc2_f;		//defined before ALU
	wire [31:0] EX_MEM_ALU;		//input from other stage
	wire [31:0] MEM_WB_ALU;
	assign EX_MEM_ALU = EX_MEM_ALUOut;
	assign MEM_WB_ALU = MEM_WB_ALUOut;
	wire [1:0] forwardA;
	wire [1:0] forwardB;

//FORWARD UNIT	 
	 wire [4:0] EX_MEM_regWriteAddress_f;
	 wire [4:0] MEM_WB_regWriteAddress_f;
	 wire	MEM_WB_regWrite_f;
	 wire EX_MEM_regWrite_f;
	 wire [4:0] rs_f;
	 wire [4:0] rt_f;
	 assign EX_MEM_regWriteAddress_f = EX_MEM_RegWriteAddress;
	 assign MEM_WB_regWriteAddress_f = MEM_WB_RegWriteAddress;
	 assign EX_MEM_regWrite_f = EX_MEM_RegWrite;
	 assign MEM_WB_regWrite_f = MEM_WB_RegWrite;
	 assign rs_f = ID_EX_Instr[25:21];//ID_EX
	 assign rt_f = ID_EX_Instr[20:16];
	 
	 
	 forwardUnit mainFUnit (
    .rs(rs_f), 
    .rt(rt_f), 
    .MEM_WB_regWrite(MEM_WB_regWrite_f), 
    .MEM_WB_rd(MEM_WB_regWriteAddress_f), 
    .EX_MEM_regWrite(EX_MEM_regWrite_f), 
    .EX_MEM_rd(EX_MEM_regWriteAddress_f), 
    .forwardA(forwardA), 
    .forwardB(forwardB),
	 .rst(RESET)
    );
	 
	forwardMux MUXA (
    .ID_EX(EX_ALUSrc1), 
    .EX_MEM(EX_MEM_ALU), 
    .MEM_WB(MEM_WB_ALU), 
    .Forward(forwardA), 
    .Sel(EX_ALUSrc1_f)
    );
	 
	 forwardMux MUXB (
    .ID_EX(EX_ALUSrc2), 
    .EX_MEM(EX_MEM_ALU), 
    .MEM_WB(MEM_WB_ALU), 
    .Forward(forwardB), 
    .Sel(EX_ALUSrc2_f)
    );
	

		 
	 
endmodule
