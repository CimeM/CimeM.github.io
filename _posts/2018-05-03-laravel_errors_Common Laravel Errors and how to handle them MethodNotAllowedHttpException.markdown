---
layout: post
current: post
cover:  assets/images/damian-zaleski-843-unsplash.jpg
navigation: True
title: Common Laravel Errors and how to handle them Method Not Allowed HttpException
date: 2018-05-03 10:00:00
tags: software
class: post-template
subclass: 'post laravel'
author: martin
published: false
---


Laravel is a great Ecosystem to work with. It was built as PHP framework that promotes expressive and ‘beautiful’ syntax. Its Pints of magic are visible when you are able to install the whole authentication mechanism with a simple command in Terminal. Laravel, when working properly, works like a charm and is a pleasure to work with.

However, there are problems visible only to those who see its guts and sometimes its a drag to look for a bug. Especially when you’ve depleted your resources of knowledge to find the problem.

For me, this was a 2-day struggle, that basically existed because of a simple mistake. Many Stack Overflow solutions suggested overseeing the cause of the problem. and for many people that was the solution, but not for me. I was the there and blindly believed my problem was similar to others just because everyone recognised with that. Persisting to look at it that way I struggled to find the problem.

The process should be working like this: Using POST method to target ‘phonebook’ URI would trigger the ‘store’ method in my PhonebookCntrlr controller but didn’t. My configuration seemed solid (below), and deviating from this configuration either called some other method in the controller or produced a different error, which was a step in the wrong direction.

Configuration:
As mentioned, i’m using Laravel 5.5.
Path :
<pre>
|| POST             | phonebook  || App\Http\Controllers\PhonebookCntrlr@store| web|
|| GET|HEAD    | phonebook| phonebook.index| App\Http\Controllers\PhonebookCntrlr@index| web|
|| GET|HEAD    | phonebook/create| phonebook.create    |App\Http\Controllers\PhonebookCntrlr@create| web|
|| GET|HEAD    | phonebook/{phonebook}| phonebook.show| App\Http\Controllers\PhonebookCntrlr@show| web|
|| PUT|PATCH  | phonebook/{phonebook}| phonebook.update| App\Http\Controllers\PhonebookCntrlr@update| web|
|| DELETE        | phonebook/{phonebook}| phonebook.destroy| App\Http\Controllers\PhonebookCntrlr@destroy| web|
|| GET|HEAD     | phonebook/{phonebook}/edit | phonebook.edit| App\Http\Controllers\PhonebookCntrlr@edit| web|
</pre>

My form action:

<pre>
<form method="post" action="" method="post" autocomplete="off”  >
</pre>

An error occurred, when a ‘POST’ submission was created within a blade called create.blade.php. It was directed to target the ‘store’ method inside the Controller class, but this is the error that was presented to me:
MethodNotAllowedHttpException in RouteCollection.php line 251

When you approach StackOverflow or Laracasts community blogs there are vague suggestions like inspecting your paths and checking controllers methods. This is a reasonable suggestion because MethodNotAllowedHttpException by default signals calling an undeclared or unavailable method. Inspecting my controller and path list didn't help. Out of dispair, I compared with another working controller. No luck. This error was already a headache for laravel users back with version 5.3.

It surely isn't the form, since it was copied and adjusted from other ‘create.blade’ too. At this point, I was stuck and left with a code and didn’t know where to look for.

Following tutorials on CRUD functionality in Laravel. Finally visiting every step of creating new entries. The paths were fine, the controller too. Finally, the form. I just rewrote everything in the form and giving it just a few obligatory variables and ended up with a two-input based form. This worked!

Wait?

Database entries showed newly accumulated entry. Here are the code snippets of my two forms:

The one that did not work:
{% highlight html %}
    <form action=" <!-- url('phonebook') -->" method="post" autocomplete="off"  >
        <div class="row">
          <div class="col-md-4">
          <!-- csrf_field() -->
            <input name="_method" type="hidden" value="PATCH">
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name">Ime</label>
                  <input type="text" class="form-control" name=“name" value="">
                </div>
              </div>
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name">Priimek</label>
                  <input type="text" class="form-control" name=“surname" value="">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name">Office</label>
                  <input type="text" class="form-control" name=“office" value="">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name">GSM</label>
                  <input type="text" class="form-control" name=“GSM_num" value="">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-md-12">
                       <button type="submit" class="btn btn-success " style="margin-left:0px">Potrdi</button>
                </div>
              </div>
          </div>
        </div> <!-- row -->
      </form>
```
Working form:
{% highlight html %}
    <form id="form1" action="<!-- url('phonebook') -->" method="post" autocomplete="off">
      <!-- csrf_field() -->

          <div class="row">
            <div class="col-md-4">
              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name">Ime</label>
                  <input type="text" class="form-control" name="name" value="">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name">Priimek</label>
                  <input type="text" class="form-control" name="surname"   value="">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-md-12">
                  <label for="name”>Office</label>
                  <input type="text" class="form-control" name="office" value="">
                </div>
              </div>
            </div>

          <div class="col-md-4">
            <div class="row">
              <div class="form-group col-md-12">
                <label for="name">GSM</label>
                <input type="text" class="form-control" name="GSM_num" value="">
              </div>
            </div>

          </div>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
```

Later in the process of writing this post, I realized, that my mistake was in the forth line within the form.
I forgot to close the input field and that caused my form to freak out and throw the controller into rejection mode.
Hopefully, you are going to learn from my mistake and become even more careful in the process of making web apps.

PS.: I replaced double curly bracket encapsulation with multiline comment marks at csrf_field() and url('phonebook').
