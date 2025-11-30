from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
import sys

n = sys.argv[1]

PATH = "F:\SideProject\Python Pratice\riscv_conv\chromedriver.exe"
driver = webdriver.Edge()

driver.get("https://www.cs.cornell.edu/courses/cs3410/2019sp/riscv/interpreter/?fbclid=IwAR1PbauCSyt1AUaKQPjek2A7u18HxpXzLQ52k8DtjIbHnacCCV4hDEgujac")
print(driver.title)
# for table in driver.find_elements(By.CSS_SELECTOR, "[aria-label=XXXX]"):
#     for tr in table.find_elements(By.TAG_NAME, 'tr'):
#         td = tr.find_elements(By.XPATH, './/td')
#         print(td.text)
f = open("./TP/assem/assem_inter/assem_inter_" + str(n.zfill(3)) + ".txt", "r")
# print(f.read())
f_write = open("./TP/interpreter/golden_" + str(n.zfill(3))  + ".txt", "w")

zero = bin(0)

search = driver.find_element(By.ID, 'code')

for line in f:
    if line.startswith('NOP') :
        search.send_keys(line)
    else :
        search.send_keys(line)

driver.find_element(By.ID, 'freq').click()
driver.find_element(By.XPATH, ".//a[@onclick='setFrequency(256);']").click()
driver.find_element(By.ID, 'run').click()

x = driver.find_element(By.ID, 'recent-instruction')

while "No more instructions to run!" not in x.text:
    time.sleep(0.1)

driver.find_element(By.ID, 'stop').click()

regs = []

table = driver.find_element(By.ID, 'registers')
for td in table.find_elements(By.XPATH, './/td[3]'):
    print(td.text)
    regs.append(td.text)

table = driver.find_element(By.ID, 'memory')
for td in table.find_elements(By.XPATH, './/td[2]'):
    regs.append(td.text)

for i in range(32):
    # f_write.write(regs[i] + " // r" + str(i) + "\n")
    f_write.write(regs[i] + "\n")

f_write.write(regs[32] + "\n")
f_write.write(regs[33] + "\n")
f_write.write(regs[34] + "\n")
f_write.write(regs[35] + "\n")
f_write.write(regs[36] + "\n")
f_write.write(regs[37] + "\n")
f_write.write(regs[38] + "\n")
f_write.write(regs[39] + "\n")
f_write.write(regs[40] + "\n")
f_write.write(regs[41] + "\n")

driver.quit()