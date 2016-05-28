---
published: true
title: MVC what, why and how
layout: post
tags: [cocoa, MVC, swift, xcode, iOS, OSX, apple, dev, development]
categories: [SoftwareDesign, programmming, DesignPatterns]
---
MVC is a design pattern, which is used in programming design. It is one of the firs things you are presented with if you go trough the video tutorials from Stanford University (search for: Stanford University iOS 7 Apps). 

Lets go trough MVC. It is a design pattern and it stands for Model View and Controller. The code applies to one of the three. 

The model: 
represents the data in the app. Responsible for sorting, validating and organising data. Controller also contains most of the data manipulation. 

The view: 
Is the “mask” which we also call the user interface. These are graphical representations of the application, which are viewed on the screen. 

The Controller: 
Stands between the View and the Model. It is responsible for acquiring the data from the Model and display it onto the View. Controller is responsible for the information that is going to be displayed. Controller prepares the data to be displayed. 

![](https://dl.dropboxusercontent.com/s/argf4b0dtchca4r/MVC.png)

The trick is to recognise what each section is for and also how they communicate: 
- The controller can always talk to the model 

- Controller can also talk directly to the View 

- The model and View should never speak to each other. 

- Controller hands out an action to the view 

- The controller sets itself as View’s delegate  

- Views does not own the data they display 

- Model uses Radio station model. -> broadcasts info to anyone 

- Controller can tune in to the Model’s radio station. 


The purpose is not only to sort the code, but also making the code more bug prone. Also it enables easy and fast upgrades. 

Coming with a fresh head to this topic it may seem abstract, but once you stumble trough some of your mentors code you will see it. Much like text writing, code also has many levels of focus. 
Because these boxes are connected there is sometimes hard to distinguish where to put your code. Especially if you are writing it starting from the point of visual interface. 

What helped me is to approach the writing of the code by first creating visual objects, connecting it to the View. in The View there are actions and other methods where I wrote future commands which will be sent to the model. That is how I saw what is suppose to happen when user interacts with the UI and also what functions are expected to exist. The functions were basically method calls with simple names - here I don't go into details, and I don't bother yet what is behind the functions. 
Later I summarise and review, the view and start on the controller. Controller and Model are built together. There is not a structured way of building that I follow, and is for now done in the style of demand-supply.