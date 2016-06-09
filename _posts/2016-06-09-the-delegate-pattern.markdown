---
published: true
title: The delegate pattern
layout: post
---
In general, this pattern was adopted by iOS developers very early and it has become a fundamental part of iOS development. Often interaction is guaranteed when dealing with user interfaces in iOS. The point of this pattern is that it allows you to easily handle/customise the behaviour of several objects in one central objects.

Wiki:
“…the delegation pattern is a design pattern in object-oriented programming that implements delegation in languages without language-level support, allowing object composition to achieve the same code reuse as inheritance"

Meaning that one object in a program acts on behalf or in coordination with another object. The delegation object keeps the reference to the other object, and at appropriate times sends a message to it.The message informs the delegate of an event that the delegate object is about to handle or has just handled. The delegate may respond with a message, action or returns a value that affects how an impending event is handled.

A clear representation is visible in real life:

![](https://dl.dropboxusercontent.com/s/ukc8s1impxcspuf/delegate_protocol_1_export-1357-1000.jpg)

- A delegator, which needs to perform a task, but doesn’t have some needed information, resources, or logic to do so. It gets that needed information, resources, or logic from…
- A delegate. While it typically can’t do what the delegator does, it has the information, resources, or logic that the delegator needs to perform its task.

The delegate pattern in iOS:

![](https://dl.dropboxusercontent.com/s/6qypx1b7lexdxxv/delegate_protocol_2_export-1659-1000.jpg)

This example shows the text field UI element. This delegator has the power to know when the user starts and stops editing the text in the field, what characters can be inserted etc. … They give the job to the delegate. 

A specific protocol UITextFieldDelegate protocol acts as the connection between the text field and its delegate. The protocol only initialises the methods, and the delegate has to conform to these rules and implement or “adopt” the methods. 

this logic is also similar to the one in C. header files are just define the methods later defined in the files which import the header files. 


Let's go deeper: 
Control-click to any UITextField definition - "jump to definition” will take you to the header file, where you will find all publicly accessible parts of UItextField including the UITextFiledDelegate protocol. you will find it on the bottom of that file 

In order to become a delegate, your View controller has to adopt the UITextFieldDelegate protocol. Here is how: 

"class ViewController: UIViewController, UITextFieldDelegate { "



Methods defined as “optional” you can implement in your delegate. Simply copy the functions name and define it in the ViewController. Giving it the content you control what will happen when the method is called. 
The job of a developer is to recognise which methods he/she needs and changes them according to the job. For more detailed read check out the globalnerdy.com blog. 


Thanx to: 
http://www.globalnerdy.com
https://developer.apple.com