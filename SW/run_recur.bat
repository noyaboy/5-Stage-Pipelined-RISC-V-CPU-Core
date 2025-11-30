@echo off
Title run_recur
for /l %%x in (437, 1, 437) do (
   echo %%x
   python .\assem_gen_recur.py  %%x
)

for /l %%x in (437, 1, 437) do (
   echo %%x
   python .\asse_to_instr_recur.py  %%x
)

for /l %%x in (437, 1, 437) do (
   echo %%x
   python .\instr_to_golden_recur.py  %%x
)


pause
