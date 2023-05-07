from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time
import datetime


def printlog(log):
    now = datetime.datetime.utcnow()
    timestamp = now.strftime('%Y-%m-%d %H:%M:%S')
    print(f'{timestamp}: {log}', flush=True)


def start(headless, url, login_id, password, operation):
    printlog(f'Suite started login_id={login_id}, operation={operation}')

    options = Options()
    if headless:
        options.add_argument('--headless')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')

    driver = webdriver.Chrome(options=options)

    ops = operation.split('+')
    for op in ops:
        printlog(f'operation {op}')
        if op == 'Login':
            cmd_login(driver, url, login_id, password)
        elif op == 'Logout':
            cmd_logout(driver, url)

    time.sleep(5)

    driver.quit()
    printlog('Quit')


def cmd_login(driver: webdriver.Chrome, url, login_id, password):
    printlog('Opening login page')
    driver.get(url + '/login')

    login_id_f = driver.find_element('name', 'loginId')
    login_id_f.send_keys(login_id)

    password_f = driver.find_element('name', 'password')
    password_f.send_keys(password)

    button_f = driver.find_element('css selector', 'button[type=submit]')
    button_f.click()

    printlog('Attempting login')
    time.sleep(3)


def cmd_logout(driver: webdriver.Chrome, url):
    printlog('Attempting logout')
    driver.get(url + '/logout')
    time.sleep(3)
