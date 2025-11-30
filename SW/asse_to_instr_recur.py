from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
import sys

n = sys.argv[1]

PATH = "F:\SideProject\Python Pratice\riscv_conv\chromedriver.exe"
driver = webdriver.Edge()

driver.get("https://luplab.gitlab.io/rvcodecjs/")
print(driver.title)
# for table in driver.find_elements(By.CSS_SELECTOR, "[aria-label=XXXX]"):
#     for tr in table.find_elements(By.TAG_NAME, 'tr'):
#         td = tr.find_elements(By.XPATH, './/td')
#         print(td.text)
f = open("./TP/assem/assem_dec/assem_dec_" + str(n.zfill(3)) + ".txt", "r")
f_write = open("./TP/decoder/instruction_" + str(n.zfill(3)) + ".txt", "w")

# print(f.read())

zero = bin(0)

for line in f:
    if line.startswith('NOP') :
        f_write.write(zero[2:].zfill(32) + " // " + line)
    else :
        search = driver.find_element(By.ID, 'search-input')
        search.send_keys(line + Keys.ENTER)

        instr = driver.find_element(By.ID, 'hex-data')
        b = bin(int(instr.text, 16))
        f_write.write(b[2:].zfill(32) + " // " + line)
        search.clear()
    
f.close()
f_write.close()

driver.quit()