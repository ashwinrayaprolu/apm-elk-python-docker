# 
# 
# Hace un monitoreo de URL's con hilos.
# Se invoca la URL y registra el código de respuesta HTTP, el tiempo 
# transcurrido y si hubo alguna excepción.
# 

import requests
import time
import threading
from queue import Queue
import datetime

print ("PyWebToring is working...")

urls = [one_line.strip()
        for one_line in open('monitoring_urls.txt')]

length = {}
queue = Queue()
start_time = time.time()
threads = []
response_time=0
response_code=0
ex_http=0

def get_length(one_url):
        response_code=0
        response_time=0
        response=""
        ex_http = "OK"

        try:
                response = requests.get(one_url, verify=False)
                response_code = response.status_code
                response_time = response.elapsed.total_seconds()

        except Exception as ex:
                #print (ex)
                ex_http = ex
        finally:
                queue.put((str(datetime.datetime.now()),one_url,response_time,response_code,str(ex_http)))


for one_url in urls:
        t = threading.Thread(target=get_length, args=(one_url,))
        threads.append(t)
        print(one_url)
        t.start()
print ("Joining")
for one_thread in threads:
        one_thread.join()
print ("Retrieve and printing")

while not queue.empty():
        #one_url, response_time, response_code, ex_http = queue.get()
        rows = queue.get()
        print (rows)
        
        #Aquí vamos a realizar el insert a influxdb


end_time = time.time()
total_time = end_time - start_time
print("Total time : {0:3} seconds ".format(total_time))
