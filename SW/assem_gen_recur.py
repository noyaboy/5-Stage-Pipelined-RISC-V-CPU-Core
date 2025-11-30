import random
from random import sample
import sys

n = sys.argv[1]

stall = True
bypass = True
neg = False
Test_Num = 5

random.seed(n)

# ALU = ["add", "sub", "xor", "or", "and", "sll", "srl", "sra", "slt", "sltu"]
# ALUI = ["addi", "xori", "ori", "andi", "slli", "srli", "srai", "slti", "sltiu"]

f = open("./TP/assem/assem_inter/assem_inter_" + str(n.zfill(3)) + ".txt", "w")
f2 = open("./TP/assem/assem_dec/assem_dec_" + str(n.zfill(3)) + ".txt", "w")

# no sub
if neg :
    ALU = ["add", "sub", "xor", "or", "and"]
    ALUI = ["addi", "xori", "ori", "andi"]
    neg_imm = random.randint(-2048, 2047)
    neg_ini = -4096
else:
    ALU = ["add", "xor", "or", "and", "sll", "srl", "sra", "slt", "sltu"]
    ALUI = ["addi", "xori", "ori", "andi", "slli", "srli", "srai", "slti", "sltiu"]
    neg_imm = random.randint(0, 32)
    neg_ini = 0

# no shift
LOAD = ["lw", "lb"]
STORE = ["sw", "sb"]
BRANCH = ["beq"]
JUMP = ["jal", "jalr"]
UTYPE = ["lui", "auipc"]

REGS = ["x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15", "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23", "x24", "x25", 
"x26", "x27", "x28", "x29", "x30", "x31"]

def instr_addi(rd, rs1, imm):
    f.write(ALUI[0] + " " + REGS[rd] + ", " + REGS[rs1] + ", " + str(imm)+ "\n")
    f2.write(ALUI[0] + " " + REGS[rd] + ", " + REGS[rs1] + ", " + str(imm)+ "\n")

def instr_alu(rd, rs1, rs2):
    x = random.choice(ALU)
    f.write(x + " " + REGS[rd] + ", " + REGS[rs1] + ", " + REGS[rs2]+ "\n")
    f2.write(x + " " + REGS[rd] + ", " + REGS[rs1] + ", " + REGS[rs2]+ "\n")

def instr_alui(rd, rs1, imm = neg_imm):
    x = random.choice(ALUI)
    f.write(x + " " + REGS[rd] + ", " + REGS[rs1] + ", " + str(imm)+ "\n")
    f2.write(x + " " + REGS[rd] + ", " + REGS[rs1] + ", " + str(imm)+ "\n")

def instr_load(rd, imm = random.randint(0,9)*4, rs2 = 0):
    i = random.randint(0,1)
    if(i):
        f.write(LOAD[i] + " " + REGS[rd] + ", " + str(imm) + "(" + REGS[rs2] + ")"+ "\n")
        f2.write(LOAD[i] + " " + REGS[rd] + ", " + str(imm) + "(" + REGS[rs2] + ")"+ "\n")
    else: 
        f.write(LOAD[i] + " " + REGS[rd] + ", " + str(imm) + "(" + REGS[rs2] + ")"+ "\n")
        f2.write(LOAD[i] + " " + REGS[rd] + ", " + str(imm) + "(" + REGS[rs2] + ")"+ "\n")

def instr_store(rs2, imm = random.randint(0,9)*4):
    i = random.randint(0,1)
    if(i):
        f.write(STORE[i] + " " + REGS[rs2] + ", " + str(imm) + "(x0)"+ "\n")
        f2.write(STORE[i] + " " + REGS[rs2] + ", " + str(imm) + "(x0)"+ "\n")
    else: 
        f.write(STORE[i] + " " + REGS[rs2] + ", " + str(imm) + "(x0)"+ "\n")
        f2.write(STORE[i] + " " + REGS[rs2] + ", " + str(imm) + "(x0)"+ "\n")

def instr_beq(rs1, rs2, imm = random.randint(-20, 20)):
    x = random.choice(BRANCH)
    f.write(x + " " + REGS[rs1] + ", " + REGS[rs2] + ", " + str(imm)+ "\n")
    f2.write(x + " " + REGS[rs1] + ", " + REGS[rs2] + ", " + str(imm)+ "\n")

def instr_bne(rs1, rs2, imm = random.randint(-20, 20)):
    x = "bne"
    f.write(x + " " + REGS[rs1] + ", " + REGS[rs2] + ", " + str(imm)+ "\n")
    f2.write(x + " " + REGS[rs1] + ", " + REGS[rs2] + ", " + str(imm)+ "\n")

def instr_jalr(rd, rs1, imm = 4*random.randint(-5, 5)):
    f.write(JUMP[1] + " " + REGS[rd] + ", " + REGS[rs1] + ", " + str(imm)+ "\n")
    f2.write(JUMP[1] + " " + REGS[rd] + ", " + str(imm) + "(" + REGS[rs1] + ")" + "\n")

def instr_jal(rd, imm = random.randint(-5, 5)):
    f.write(JUMP[0] + " " + REGS[rd] + ", " + str(4*imm)+ "\n")
    f2.write(JUMP[0] + " " + REGS[rd] + ", " + str(4*imm)+ "\n")

def instr_lui(rd, imm = random.randint(0, 524287)):
    f.write(UTYPE[0] + " " + REGS[rd] + ", " + str(imm)+ "\n")
    f2.write(UTYPE[0] + " " + REGS[rd] + ", " + str(imm)+ "\n")

def instr_auipc(rd, imm = random.randint(0, 5)):
    f.write(UTYPE[1] + " " + REGS[rd] + ", " + str(4*imm)+ "\n")
    f2.write(UTYPE[1] + " " + REGS[rd] + ", " + str(4*imm)+ "\n")

def instr_nop_s():
    if not stall : 
        f.write("NOP"+ "\n")
        f2.write("NOP"+ "\n")
    else :
        print(" ")

def instr_nop_b():
    if not bypass : 
        f.write("NOP"+ "\n")
        f2.write("NOP"+ "\n")
    else :
        print(" ")

def initial():
    for i in range(32):
        temp = random.randint(neg_ini,2000)
        f.write("addi x" + str(i) + ", x0, " + str(temp)+ "\n")
        f2.write("addi x" + str(i) + ", x0, " + str(temp)+ "\n")
    f.write("NOP"+ "\n")
    f2.write("NOP"+ "\n")
    f.write("NOP"+ "\n")
    f2.write("NOP"+ "\n")
    f.write("NOP"+ "\n")
    f2.write("NOP"+ "\n")

def initial_testset():
    r1 = random.randint(1,31)
    r2 = random.randint(1,31)
    r3 = random.randint(1,31)
    return r1, r2, r3


# for i in range(32):
#     f.write("\"x", end="")
#     f2.write("\"x", end="")
#     f.write(i, end="")
#     f2.write(i, end="")
#     f.write("\", ", end="")
#     f2.write("\", ", end="")


initial()

# # LD -> ALU 2NOP
# r1 = random.randint(1,31)
# r2 = random.randint(1,31)
# r3 = random.randint(1,31)
# instr_load(r1)
# instr_nop_s(stall)
# instr_nop_b(bypass)
# instr_nop_b(bypass)
# instr_alu(r3, r2, r1)

# ALU -> ALU 3b
r1, r2, r3 = initial_testset()
instr_alu(r1, r2, r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_alu(r3, r1, r2)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_alui(r2, r3, r1)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_alui(r1, r2, r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_alui(r3, r1, r2)
instr_nop_b()
instr_nop_b()
instr_nop_b()

# LUI AUIPC
r1, r2, r3 = initial_testset()
instr_lui(r1)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_auipc(r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_lui(r2)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_auipc(r1)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_lui(r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()


# ALU -> LW 3b
# LW -> ALU 2b 1s
r1, r2, r3 = initial_testset()
instr_alu(r1, r2, r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_load(r1)
instr_nop_s()
instr_nop_b()
instr_nop_b()
instr_alu(r2, r3, r1)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_load(r2)
instr_nop_s()
instr_nop_b()
instr_nop_b()
instr_alui(r3, r1, r2)
instr_nop_b()
instr_nop_b()
instr_nop_b()


# ALU -> SW 2case both 3b
r1, r2, r3 = initial_testset()
instr_alu(r1, r2, r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_store(r1)

instr_alui(r2, r3, r1)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_store(r2)

# ALU -> Branch 1s2b
r1, r2, r3 = initial_testset()
instr_addi(r1, r2, -5)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_addi(r1, r1, 5)
instr_nop_s()
instr_nop_b()
instr_nop_b()
instr_beq(r1, r2, 12)
instr_nop_s()
instr_alui(31, r3)

instr_addi(r1, r2, -5)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_addi(r1, r1, 5)
instr_nop_s()
instr_nop_b()
instr_nop_b()
instr_jal(r2, 8)
instr_nop_s()
instr_alui(30, r3)

instr_addi(r1, r2, -5)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_addi(r1, r1, 5)
instr_nop_s()
instr_nop_b()
instr_nop_b()
instr_jalr(r2, 0, 564)
instr_nop_s()
instr_nop_s()
instr_nop_s()
instr_alui(30, r3)
instr_nop_b()
instr_nop_b()
instr_nop_b()

instr_addi(r1, r2, 0)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_addi(r1, r1, 5)
instr_nop_s()
instr_nop_b()
instr_nop_b()
instr_beq(r1, r2, 12)
instr_nop_s()
instr_alui(31, r3)

# LW -> LW 2s 1b not test

# LW -> SW 2s 1b not test

# LW -> SW 3b
r1, r2, r3 = initial_testset()
instr_load(r1)
instr_nop_b()
instr_nop_b()
instr_nop_b()
instr_store(r1)

# LW -> BEQ 2s 1b
r1, r2, r3 = initial_testset()
instr_store(r2, 4)
instr_load(r1, 4)
instr_nop_s()
instr_nop_s()
instr_nop_b()
instr_beq(r1, r2, 12)
instr_nop_s()
instr_alui(31, r3)
instr_store(r2, 4)
instr_load(r1, 4)
instr_nop_s()
instr_nop_s()
instr_nop_b()
instr_bne(r1, r2, 12)
instr_nop_s()
instr_alui(31, r3)




