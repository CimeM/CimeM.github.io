---
layout: post
current: post
cover:  assets/images/arduino-thermometer-logger-cover.jpg
navigation: True
title: Arduino data logger tweaks
date: 2019-1-01 22:00:00
tags: code
class: post-template
subclass: 'post data science Arduino programing'
author: martin
---

In previous posts, I have mentioned a way to establish hardware and software for Arduino data logger. In this post, we will be looking at some software tweaks thus arriving to a new software update (2.0).

As you may know, Arduino boards have limited amount of space. Running in infinite loops by default, the microcontroller can run out of data very soon. This memory leak populates the memory, that is crucial for its operation. Regarding this, a reset button may be pushed every now and then, so that the memory is freed and the board begins its process from the beginning. It is needless to say that pushing a button every 24 hours seems like a scene from an episode of Lost. Luckily there is a way to do this, so the microcontroller can reset itself periodically.

```C
long lastReadingTime = 0;

void setup() {

}

void(* resetFunc) (void) = 0; //declare reset function @ address 0

void loop() {

  performReset();
}

void performReset(){

  // check for a reading no more than once a second.
  if (millis() - lastReadingTime > 600000) {
  resetFunc();
  }else{
  lastReadingTime = millis();

  }
}
```

the `void(* resetFunc) (void) = 0;` defines a pointer to a function and sets that pointer to zero, so when the function is called it transfers control to the reset vector at address zero.

From the code, you can see that the main loop calls a function performReset() that fires the reset function about 10 minutes into the run.

I know this is a dirty way of ensuring that Arduino doesn't fill the memory, but if you don't have time to learn all about the Arduino, this will be the fastest way of going forward.
A cleaner way would be to allocate a memory block and ensure that the new data always rewrites the old.
