---
layout: post
current: post
cover:  assets/images/restfulAPI-python-flask.jpg
navigation: True
title: Build API with Flask
date: 2019-1-2 10:00:00
tags: software
class: post-template
subclass: 'facebook bot AI drawing time timing'
author: martin
---

Application interfaces are the bridges between two or more software entities. APIs are present everywhere, they are a standard method to expose databases to clients.

Most common API communication protocol is Representational State Transfer (REST). Because REST represents most common ways the communication evolves between interfaces and databases: GET, PUT, POST and DELETE.  REST is also common because, compared to SOAP, it uses less bandwidth and it is also less complex while being more dynamic.

In this post, we are going to build our API using Flask Microframework for python.

``` python
from flask import Flask, request
from flask_restful import Resource, API

app = Flask(__name__)
api = Api(app)

#construct a simple data structure
data = {}
data['fruits'] = []
data['fruits'].append({
  'apples':'4',
  'pineaples':'3'
  })

# returns the whole data structure
class Show_Fruit_Storage(Resource):
  def get(self):
  return data

# enables selection to specific fruits
class Fruit_Name(Resource):
  def get(self, fruit_id):
  return data['fruits'][0][fruit_id]

# routes
api.add_resource(Show_Fruit_Storage, '/fruits') # 127.0.0.1:5002/fruits
api.add_resource(Fruit_Name, '/fruits/<fruit_id>') # 127.0.0.1:5002/fruits/pineaples

if __name__ == '__main__':
  app.run(port='5002')
```

You can run the code and try visiting the following links in your browser:
[127.0.0.1:5002/fruits](http://127.0.0.1:5002/fruits)

[127.0.0.1:5002/fruits/pineaples](http://127.0.0.1:5002/fruits/pineaples)

From here you can add other queries like POST, PUT and DELETE as you like. You can also add different database queries into classes. Enjoy!
