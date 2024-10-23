---
layout: post
current: post
cover:  assets/images/graphite.jpg
navigation: True
title: Graphite Database
date: 2019-01-07 10:00:00
tags: trip environment
class: post-template
subclass: 'data programing software '
author: martin
published: true
---

If you're like me, you do everything in docker. Making a test site on my computer and implementing that funny database that just came out is a common scenario. Appart from religious things, docker is a serious tool and here is a way how you can implement graphite database into the docker container, export it and install it somewhere else. And yes, that includes histoy data.

If you don't know about graphite here's what you shou know:
Its a simple way to collect, display and compute time-series data. It has three main components: Carbon: a deamon that listens to incomming time series data, Whisper - database and Graphite web app - django web app that displays all those graphs. Graphite is used for production environments by many companies and it is simple to learn and use.

This tutorial will guide you through installing graphite on docker environment:

``` bash
docker run -d --name graphite -p 80:80 -p 2003:2003 -p 2003:2003/udp \
-p 2004:2004 -p 7002:7002 mrlesmithjr/graphite
```

Once it spins, you basicaly have to make sure it runs as it should:

``` bash
docker container ls
```

Runing this container on your machine or network should render the website available on port 80.

If you continue and visit the dashboard: [http://localhost/dashboard]('http://localhost/dashboard')
and click into the words you will finally end up having a graph, where you will be able to see those random temperatures you just logged into the system.

For those of you who like quicker tests, you can send data from terminal like this:
This one-liner sends a data point to the database.

``` bash 
echo "local.measurement 4" | nc localhost 2003
```

This python program will send randomized data point to the database. You can modify it as you like, just be careful of the syntax. Copy the code to a file named "sendRandomDataToGraphite.py" and run it with a local version of python. Install packages if neccesary.

``` python
import argparse
import socket
import random

CARBON_SERVER = 'localhost'
CARBON_PORT = 2003

def sendToDatabase(metric_path, value):
  timestamp = int(time.time())
  message = '%s %s %d\n' % (metric_path, str(value), timestamp)
  sock = socket.socket()
  sock.connect((CARBON_SERVER, CARBON_PORT))
  sock.sendall(message)
  sock.close()


for x in range(30):
  sleep(0.5)
  sendToDatabase(house1,livingroom.window.temperature, random.randint(20,35))
```

Congrats. You can stop and use the database like it is, or you can upload it to the server and have it run 24/7! We will do just that, but lets first send some data to the database with python!

Now, you are ready and capable to push the database to the production server. You also want to keep the data you logged into the system already.


``` bash
docker stop graphite
docker export graphite > graphite.tar
```

transfer graphite.tar to the server (possibly with scp)

``` bash
scp graphite.tar USERNAME@SERVER_IP:/home/USERNAME
```

Where you have to provide username and SERVER_IP of the destination server, you will be prompted for password and the transfer will begin.

````
docker load < graphite.tar
````

``` bash
docker import graphite.tar
docker container ls
docker run -d --name graphite -p 80:80 -p 2003:2003 -p 2003:2003/udp \
-p 2004:2004 -p 7002:7002
```

And you are up and ready to test the site!
Just change the ***CARBON_SERVER*** var in your python code and run again. You should be able to see new data on the production server dashboard! Happy coding!

Thanks to bloggers that provided resources and discussed commands in detail. I will be visiting your blogs for sure! Thanks!

* [everythingshouldbevirtual.com]('https://everythingshouldbevirtual.com/containers/docker-spinning-graphite-container/')

* [techsparx.com]('https://techsparx.com/software-development/docker/deploy-images-without-registry.html')

* [tuhrig.de]('https://tuhrig.de/difference-between-save-and-export-in-docker/')
