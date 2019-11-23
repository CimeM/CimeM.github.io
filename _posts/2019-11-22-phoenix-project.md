---
layout: post
current: post
cover:  assets/images/phoenix-project.jpg
navigation: True
title: The Phoenix project
date: 2019-11-22 10:00:00
tags: devops
class: post-template
subclass: 'book devops CI management'
author: martin
---

The Phoenix project is a throwback to “the Goal” a book that united lessons from the Theory of Constraints (TOC) and a story of a production plant manager. 
The Phoenix authors didn’t hide they were borrowing lessons from the goal. They even made it obvious by comparing the production plant and the software release processes. If you compare the books, they both have a similar storyline, a protagonist that struggles to keep up with discovering the rules of TOC and facing the disbelief at the same time. The end in both cases is positive and the hero gets rewarded for the efforts.
The reader doesn't need to know the Goal to follow up with the phoenix. 



The Goal inspired many readers and even got on the list of the 25 most influential business management books. The same lessons can today be found in many prestigious business schools. The Phoenix brings the same lessons into the present, where code lives practically everywhere and almost any IT professional will relate to the narrative with no trouble. In this article we will go through the TOC cycle and how do the tools like Kanban and Tickets help to reach Continuous Delivery (CD).



If you found yourself here reading this article without opening the Phoenix I advise you to read on! You can expect spoilers in such manner that you will eventually end up buying the book.
 

 
The happening revolves around the main protagonist Bill Palmer who goes through a revealing process that dismantles the IT department and connects it back together by using the core rules from the Goal. Because the IT department struggles to keep up with the release of the Phoenix project the company Parts Unlimited struggles to maintain its public integrity. Captured in the prison of their own mistakes the IT department delivers an unstable product that pushed the company in risky waters. Along the way, they discovered many security problems that got released in the public. This was bad news for the whole company and eventually, the whole IT department is threatened to be replaced by an outsourced team. But they manage to save themselves and the company along the way.



They managed to deliver because they hold on to the new rules and this finally save themselves and others from meeting the bitter end. The board of the company did not understand at first but eventually saw the results. The IT department continued to surprise everyone by increasing the quality of the company’s business process by meeting market demands faster. The company was able to re-gain its reputation and even overcame its previous records. Through the story, the author described the tools and methods that the protagonist implemented to meet all these goals. I saw many companies, departments and even small teams adopting these approaches to optimize their flows.



The novel’s ending almost sounds too exaggerated. And the story is often repetitive. Bill Palmer gets this big promotion for saving the IT department and makes the company overcome competition. I read the ending just because I hoped for another lesson. However, I believe that the techniques described, even if just theoretical, have the potential and are well worth considering the implementation. 



Continuous delivery (CD) as the goal for the IT department
CD is where most of the recurring tasks are automated, constraints are managed and the company can release to production with the speed of 10 times per day. The software isn’t delivered in large silos anymore and released on the due date but rather released in small chunks to the already established platform. The author argues this is also the state all IT companies should be in to successfully reach deadlines and deliver their promised product. Of course, the automation and tools have advanced since the book was released, but it is still a great start for those reaching for similar goals.
 
### Tickets: 
Tickets come early in the book. Due to the limited time the company has, they decide to divide the work in small tickets and order them from most to least important. They use post-it notes and paste them on the whiteboard in their so-called “war room”. They rank them from most to least important for the release and decide to do the important ones first. 
This way they organise the work for maximizing flow: business -> development -> operations -> customer. 

### TOC
The theory of constraints comes as a cycle that also plays a big part in the company success. In the Phoenix, Bill makes his first iteration of the cycle as slow as possible but iterates next ones much faster to avoid repetition. The same cycle later changes other parts of the company. The cycle consists of the following steps: 
* Identify the constraint 
* exploit the constraint 
* subordinate al other activities to the constraint 
* elevate the constraint to new levels 
* find the next constraint 
 


The book also describes relations between the business executives in the company. Because IT departments are struggling to deliver their products, some executives grow habits to address IT personnel directly to advance their agenda. The story describes how the Director of Distributed Technology operations Wes Davis corners Brent, the IT employee, to work on their product first. 
The new structure doesn't allow this behaviour any more. This brings some friction to the members that got uses dot cut corners. Bill Palmer tries to resolve the issue politely at the beginning. He explained that this behaviour will bring the IT department back to the old system. Wes eventually ignores the warnings and eventually ends up getting fired from the company. In the end, the board started to cooperate differently and that reflected in the benefits I included the list of five dysfunctions of a team. There are quite a few pointers in the book that indicate when individuals break such rules. 
* absence of trust - unwilling to be vulnerable within the group 
* fear of conflict - seeking artificial harmony over the constructive passionate debate 
* avoidance of accountability - ducking the responsibility to call peers on counterproductive behaviour, which sets low standards 
* inattention to results - focusing on personal success and ego before team success 
 
### Key realizations 
By the time a new project arrives (project Unicorn), the IT department adopts it using the iterative deployment lifecycle. This helps them identify issues faster and early in the process of development. Also, the customers are happier because they can steer the product along the way. 
The department increases cycle time towards the goal, which is 10 deployments per day. This makes the updates smaller and easier to manage on the production systems. They adjust for the quantitative deployments and start to collaborate in a way that supports the deployment process. Teams even recognise the doubled work and eliminate it. 
 
### They realize: 
* the distinction between WIP and unplanned work 
* a project can be split into manageable chunks 
* benefits of cross-team synchronization  
* automate recurring tasks 



Here are some of the other memorable notes I took while reading: 
 - Understand how code moves through the system. (aka product lifecycle) 
* Expect random effects from software updates. Always increase the speed of the flow but never pass defects downstream (technical debt). 
* Feedback: Understand the needs of both internal and external customers. Shorten the feedback loops whenever possible. Continuously ask customers for the review. 
* Continual Learning(CL): Encourage experimentation and learn from failures. Don’t expect to be perfect at the beginning. But do make improvements along the way. 
* Automate what you can. 
 
### Types of work
Through the whole story, we get to discover the 4 types of work. They ultimately dictate how and when the tasks should be worked on. 
* Business projects 
* IT tasks
    * operation projects that business projects create (create a new environment, automate deployment)
* Changes 
    * generated from IT tasks and business decisions 
* Unplaned work or recovery work 
    * operational incidents often caused by previous types of work. Always comes at the expense of other planned work commitments. 
 
### Kanban boards 
When they recognised that Brent is the constraint rather than a liability, they wrote down the tasks on post-it notes and attached it to a whiteboard. The lines separate tasks that are being worked on and the ones still waiting or pending. Doing this allowed better transparency and visibility. With kanban, they were able to reduce reliance on Brent for unplanned work and even outages. They even started to figure out ways to exploit Brent better for the remaining three types of work: business, IT and changes. 
Kanban can be modified to fit the needs of a team: The lanes can be further divided into smaller sections and even types of work. The doing section, for example, can be divided into planning, development, testing and deployment. 
In the beginning, the Parts Unlimited tracked projects by the deadline time. By implementing kanban they allowed space for continuous development. 
 
### Task wait time: 
The whole problem solving is focused on removing constraints. The only graph in the book shows the wait time as a relationship between resource busy time and its idle time. Erik used it to show why 30-minute changes take weeks to be completed. Because Brent was constantly being used, the work piled before him. The tasks waited a long time before being done unless escalations occurred. And even when they did it was more often hurting the process, because they came from unqualified work processes across the company. 
The graph is not a real interpretation of the real wait time but merely serves as an indicator of what to expect from resources when being overloaded. 

![The only image in the book is a graph](assets/images/phoenix-project-wait-time.jpg)
 
Wait time combined with handoffs explains why tasks are getting stuck in the waiting line. Handoffs happen when a person is working on a task but realizes it is time to hand it off to the next person. The ticket enters the waiting line for the next person. If tickets have 7 handoffs and every single one takes 9 hours (90% resource utilization) that leads to 63 hours of queue time for the task. If the resource would be at 50% utilization the overall time would be reduced to 7x(50/50) = 7h. 
* one-time unit is 1 hour. 


 
### Technical debt 
Technical debt is that work you leave behind when saying: I will work on this when I will have some extra time. It's easy to just forget about it and leave it behind. In terms of IT, technical debt can be from refactoring, writing tests, deployment procedure, build scripts etc… It can be anything that doesn't satisfy the immediate need but needs to be done eventually. 
 
### Work In Progress 
Everything from the start of the product production line to the product being released is work in progress or WIP. 
 
### Why Brent is a constraint: 
Brent Geller is a go-to engineer for unsolvable problems. He has the experience to solve even the most difficult problems. The things he does are known only to him. And when he goes on vacation, no real work is getting done. The catch is that he is a constraint. Because of this, all the projects went with the speed he dictated. And since the tasks piled in front, the only way to get something done fast needed to be escalated. And that meant, even more, wait time for the rest of the queue. The solution to this problem was to assign knowledge transfers, automated procedures and strict offloading of the tasks from Brents queue. 



Subordination and elevation of the constraint 
In “The Goal” Alex puts Herbie, the slowest scout, at the front of the whole marching row of scouts. Herbie was the slowest, so he dictated the speed of the whole process. The similar process was later implemented in the production pant. Alex subordinates the work to the bottleneck - the heat treating oven. he finally realizes this was a step in the right direction but needed more work. The whole process was synchronised, but not optimised for speed. Some processes still had to wait or slow down because they were faster than the tempo. To speed up the slowest part in the production line they combined the heat treat oven with the process of painting. After the mod, the oven could do the painting and curing. In this step they combined the four work centres into one, they eliminated over thirty manual error-prone steps, completely automating the work cycle. They achieved single-piece flow and eliminated all setup time. They managed to increase the speed of the bottleneck and with that, they managed to increase the overall output. This was the second constraint they were dealing with. The first one was the NCX-10 robot. And the one after the oven was market - which is outside of the production plant. The result was so impressive Alex Rogo gets promoted.  
In the Phoenix project, Bill Palmer did the same by managing tasks Brent did. They offloaded his waiting list, transferred knowledge to other members and ensured he can go on vacation without halting the system. The next constraint was MRP application support - this is not within the organization anymore. 
 
