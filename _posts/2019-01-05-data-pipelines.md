---
layout: post
current: post
cover:  assets/images/moritz-mentges-1144492-unsplash.jpg
navigation: True
title: Data pipelines
date: 2019-1-5 10:00:00
tags: software
class: post-template
subclass: 'software data pipeline datalake sensors ML'
author: martin
---

Data pipeline is a concept for data being brought from one end to another, usually with some modifications along the way. It all comes down to a set of instructions, that extract data or push it from one end to another, only to reach its goal. Sometimes data is aggregated on one location and when the time is right, the triggers launch the process of data extraction. 

All the processes are automated. Merging data from a database to another, moving and correcting data, adding, dividing, averaging, everything.

Making automated jobs is almost synonymous to making a data pipeline. Not only does this accelerate the data flow process, but also allows us to build abstraction layers. Automation also helps us to filter out important data, and deliver it in the right format.

![alt text](assets/images/data_pipe.jpg)


Handling data flow is not an easy task and does involve quite a bit of software. It is also important to build it in a way, that it will be able to handle the given load and deliver correct data to the customer. 

The key objective is to create a system that will connect data generators, data consumers and provide an interface to actuators. While doing that job, it will also include storage optimization and actuator utilization. 

The project consists of:
* Sensors
* Flask Microservice - Python-based API for making a data intersection
* Graphite - a database that stores all the data and allows data reduction 
* Actuator - a controller that controls the system
* PWA - an interface for users that are able to observe the process in real time
* Decision tree - provide simple 'programs' for users to activate
* Notifications - an alert system that warns users of any anomalies

The reasons for making the project are several:
* How can we operate the system, so that we save on resources
* How can we measure the cost and effectiveness of the system
* How can we distribute energy, so that it suits our needs and still provides ways to save on resources

These are questions that have multi-level solutions and need a lot of analytics and further investigation to answer them.

It is obvious that the data flow for this project has an opportunity to involve several machine learning systems, and my job is to dive into the data and expose some of the facts, we can benefit from. Data party coming up!

Photo by [Moritz Mentges]('https://unsplash.com/photos/Aa8mOPyjCN0?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText') on [Unsplash]('https://unsplash.com/search/photos/pipeline?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText')
