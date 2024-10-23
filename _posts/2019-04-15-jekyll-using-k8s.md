---
layout: post
current: post
cover:  assets/images/kobu-agency-703554-unsplash.jpg
navigation: True
title: Deploying Jekyll using Docker and Kubernetes
date: 2019-04-15 10:00:00
tags: software
class: post-template
subclass: 'software kubernetes pipeline jekyll'
author: martin
published: true
---

Here we are building a simple Jekyll CICD.
This article will show you how to build your own Jekyll site and publish it within a container to docker hub. Also, we are going to go through the process of deploying the container on a local node using kubernetes.

The article covers the foremost topic of deploying code within a container and is directed to those who produce code for a living.

The second part involves container deployment, port exposure and troubleshooting.

Although the descriptions are brief, keep in mind there is a lot more going on in the background. To understand this article you do not need to be proficient in all areas, but its recommended to understand the concept behind CICD, Docker fundamentals and understand kubernetes.

If you are a developer, looking to understand containers, you came to the right place. We are covering the bare minimum of what it takes to deploy the code to a node.

Also, a word of advice; I do not recommend using this example in production It is meant for demonstration purposes only.

## Building Jekyll

as an example, we are going to build the Jasper 2 theme that serves as a popular Jekyll blogging platform. Anyone that is picky about the design of their blog is going to agree, that this is a great starting point for a blog.
Here you can find a repo with the theme [Github/jasper2](https://github.com/jekyller/jasper2)

Let's say you already have the project in your folder. Now its time to compile the site and wrap it in a container. Having the privilege of using containers we are going to use one just to build the Jekyll site. Another to host the site.
The same privilege disregards what machine you are using.

### Create certifficate for SSL encription
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt`

### Build Jekyll and copy the code to nginx container

This *Dockerfile* will download a ruby container, copy the project, build it and copy the product to a downloaded nginx container.

```Dockerfile
FROM jekyll/jekyll as build

RUN mkdir /constructionsite
COPY sites/jasper2/. /constructionsite
WORKDIR /constructionsite

RUN chmod 644 /constructionsite/assets/images/*
RUN chown -R jekyll /constructionsite

RUN bundle install && bundle exec jekyll build -d public


FROM nginx

COPY --from=build /constructionsite/public/ /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/
COPY nginx.crt /etc/ssl/
COPY nginx.key /etc/ssl/

EXPOSE 80:81
EXPOSE 443:443
```
Because we are using SSL, we need to modify nginx settings. This is 'default.conf' that belongs to nginx settings.
```Nginx
server {
    listen       80;
    server_name  localhost;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}

server {
    listen 443;
    ssl off;
    ssl_certificate /etc/ssl/nginx.crt;
    ssl_certificate_key /etc/ssl/nginx.key;
    server_name  localhost;

    server_tokens off;
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```

Activate the sequence with:

`
docker build --tag my blog .
`

`
docker images
`
will display what we have just built. The new image should be at the top of your list - check the timestamp.

You can run the container with:
`
docker run -p 123:80 1234:443 --name myblog-ssl
`

A browser tab is a great way to test our ports right now. Test the site with navigating to ```localhost:1234```. This is a way to test the site locally. Note that terminal will tail nginx logs directly.

### Push the container to docker hub

step one: tag

`
docker tag <imagehash> yourusername/myblog:initial
`


step two: push

`
docker push yourusername/myblog
`

All further versions should be tagged with other than 'initial'. This one is just for testing. I recommend you make two kinds of tags. One should always be 'latest' the other can be version number (v1, v2, etc...).

The 'latest' should always point to the latest build. Versions will be used to deploy new versions in kubernetes. You may come to different conclusions with your DevOps team.


### Deploy the container

`
kubectl run myblog --image=yourusername/myblog:latest --port=443
`

### Expose the port

`
kubectl expose deployments myblog --type="NodePort" --port=30622
`

Reveal your ingress port.
`
kubectl describe service myblog | grep 'NodePort:'
`

You should be able to direct the traffic to this port and get the correct response.


![terminal screenshot revealing exposed port](assets/images/kubectl-describe-service-NodePort-reveal.png)




Relevant influencing articles:

- [davemateer.com](https://davemateer.com/2018/01/25/Jekyll-and-Docker)

- [scmquest.com](https://scmquest.com/nginx-docker-container-with-https-protocol/)

Docker hub:

- [docker.com/r/jekyll/jekyll](https://hub.docker.com/r/jekyll/jekyll/)

Kubernetes documentation:

- [kubernetes.io](https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/)

Books:

- [Kubernetes up and running](https://www.amazon.com/Kubernetes-Running-Dive-Future-Infrastructure/dp/1491935677)

Photos by:

-[Photo by Kobu Agency on Unsplash]()
