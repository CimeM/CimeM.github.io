---
layout: post
current: post
cover:  assets/images/kiwi-bootcamp.jpg
navigation: True
title: Cloud weekend - kiwi.com bootcamp
date: 2019-06-10 10:00:00
tags: software
class: post-template
subclass: 'software kubernetes pipeline cicd gitlab terraform'
author: martin
---


Developers and Infrastructure engineers from [kiwi.com](http://kiwi.com) prepared a bootcamp-like workshop in the weekend days in Ljubljana from 7 to 9th June 2019. The course followed a hands-on workshop method and builds upon containerisation, integration and deployment skills. We had the opportunity to learn Terraform, Kubernetes and Gitlab CI/CD. Our mentors were kind enough to show us how to build production grade infrastructure with healing, scalability and fault tolerance in mind. We also had a discussion at the end where we got a glimpse into their production environment and got to know some of the practices they use on their systems.

#### Gatekeeping:

Getting a chair at the workshop wasn't as easy as just applying for it, there were coding tests, where I had to prove basic knowledge of linux, python (or other languages) and some basic understanding of the tools mentioned above. This wasn't just for the show, it is important for attendees to have some basic understanding, so that the workshop would run smoother, and also to avoid time-consuming explanation what every command did. This forced some of us to do our homework and filter less serious individuals.

#### Matching audience:

The worksop was intended to devotees who wanted to expand their horizon Infrastructure engineering. Wether a developer or infrastructure engineer, QA or enthusiast ready to move to the cloud. To me, this was a great opportunity to get introduced and gain distinct perspectives towards the tools.

#### Fabrication:

In next blog posts I will be taking apart some of the intricate configs and trying to make sense out of the obscure parts with the help of the documentation. This way I can defeat some of the uncertainty that piled during the workshop. If some link is yet not made, that simply means, I had yet not devoted time to conclude the content.

- Terraform
- Kubernetes
- Gitlab CI/CD
- terminal tools for kubernetes

## Gitlab CICD

This is like your home-made CI/CD but better. Its built into your favourite open-source version control. This means you can CI your code and CD it to production. You can have as many stages as prefer with as many parallel jobs!  

Continuous Delivery ensures your project is built every time you push to the default branch of your repo. This mean you can catch those bugs early in development stage.

The workshop was based around a file `.gitlab-ci.yml` as you can expect, this file has it all. Let's dive in.

``` yaml

stages:
  - plan
  - build
  - deploy

.terraform: &terraform
  image:
    name: hashicorp/terraform:light
    entrypoint: [""]
  script:
    - terraform init
    - terraform $TF_ACTION $TF_OPTIONS

Terraform plan:
  stage: plan
  <<: *terraform
  variables:
    TF_ACTION: plan

Terraform fmt:
  stage: plan
  <<: *terraform
  variables:
    TF_ACTION: fmt
    TF_OPTIONS: -check
  allow_failure: true

Terraform apply:
  stage: build
  <<: *terraform
  variables:
    TF_ACTION: apply
    TF_OPTIONS: --auto-approve
  only:
    changes:
      - "*.tf"
      - "*.gitlab-ci.yml"
    refs:
      - master
  when: manual

.deployment: &deployment
  image: kiwimember/cloudweekend-runner:lju
  when: manual
  only:
    refs:
      - master
  environment:
    name: default

Kube canary deploy:
  stage: deploy
  <<: *deployment
  script:
    - kubectl apply -f ./k8s/deployment-canary.yaml
    - kubectl rollout status -f ./k8s/deployment-canary.yaml

Kube deploy:
  stage: deploy
  <<: *deployment
  script:
    - kubectl apply -f ./k8s/deployment.yaml
    - kubectl rollout status -f ./k8s/deployment.yaml

Kube full deploy:
  stage: deploy
  <<: *deployment
  script:
    - kubectl apply -f ./k8s
    - kubectl rollout status -f ./k8s/deployment.yaml

```


You can see there are quite a few interesting parts. Here is how you can understand them:

- *Stages*: makes room for multi stage - horizontal pipeline. The behaviour follows: all jobs in a stage run in parallel. A stage doesen't continue until jobs in previous stage are concluded. If you don't define stages; `build`, `deploy` and `test` will can be used. If a job doesn't specify a stage, it is thrown into the test stage.


``` yaml

stage:
  - build
  - test
  - deploy

job1:
  stage: build
  script: make build dependencies

job2:
  stage: build
  script: make build artefacts

job3:
  stage: test
  script: make test

job4:
  stage: deploy
  script: make deploy

```


- *Anchors*: let you duplicate content in your config. You can easily write and anchor and use it in combination with hidden keys. You can use hidden keys with coma (`.`), and anchors with ampersand (`&`). See how we used the anchor to inject our code (`<<: *job_deffinition`). In our yaml file we had the chance to insert authentication secrets, for our cluster and also to define image name for running jobs.



``` yaml

.job_template: &job_definition # Hidden key that defines an anchor named 'job_definition'
  image: ruby:2.1
  services:
    - postgres
    - redis

test1:
  <<: *job_definition # Merge the contents of the 'job_definition' alias
  script:
    - test1 project

```



- *Variables*: Gitlab allows definition of variables within your document. They are later passed to the environments in use. They can be used in scripts using a prefix; dollar sign ($) - with bash. If they are defined only within jobs, then they are used just in that scope. To store sensitive information in your `gitlab-ci.yml` would be wrong. Secrets are to be defined through gitlab UI, and can be masked for security reasons. In our case there are ones like  `$TF_VAR_gc_zone` . This one was defined through the UI (Project>Settings>CI/CD>Variables). There are also some system variables that define the strategy, submodule strategy, checkout and more. Here is more about that: [variables]([https://docs.gitlab.com/ee/ci/yaml/#git-strategy](https://docs.gitlab.com/ee/ci/yaml/#git-strategy))


``` yaml

.terraform: &terraform
  image:
    name: hashicorp/terraform:light
    entrypoint: [""]
  script:
    - terraform init
    - terraform $TF_ACTION $TF_OPTIONS

Terraform plan:
  stage: plan
  <<: *terraform
  variables:
    TF_ACTION: plan

```

Don't be confused because we called our anchor first, before defining variables.

There is a lot more to discover with gitlab-ci. you can see more in official [gitlab docs page]([https://docs.gitlab.com/ee/ci/introduction/](https://docs.gitlab.com/ee/ci/introduction/)).

Need to find a CI template for your project? here you go: [templates]([https://gitlab.com/gitlab-org/gitlab-ce/tree/master/lib/gitlab/ci/templates](https://gitlab.com/gitlab-org/gitlab-ce/tree/master/lib/gitlab/ci/templates))


## Terraform

Terraform is an opensource orchestration tool for provisioning your muatable infrastructure using declarative appraoch. Thetool is quite new (being released in 2014) and has quite a big community due to the age. The key advantage is multicloud provisioning. Config files use HCL syntax, which is better for us to read or with JSON format - for software based appraoch. 


Here are two blocks of configuration. First one defines a VM on a provider, the other creates a simple DNS record. You can easily change the provider and use the seme configuration to create a VM on a different provider. 
 

``` json
resource "aws_instance" "app" {
 instance_type = "t2.micro"
 availability_zone = "us-east-1a"
 ami = "ami-40d28157"
 user_data = <<-EOF
 #!/bin/bash
 sudo service apache2 start
 EOF
}
resource "aws_db_instance" "db" {
 allocated_storage = 10
 engine = "mysql"
 instance_class = "db.t2.micro"
 name = "mydb"
 username = "admin"
 password = "password"
}
resource "aws_elb" "load_balancer" {
  name = "frontend-load-balancer"
   instances = ["${aws_instance.app.id}"]
   availability_zones = ["us-east-1a"]
   listener {
     instance_port = 8000
     instance_protocol = "http"
     lb_port = 80
     lb_protocol = "http"
   }
  }
}
```

user data - bash script that executes while the instance is booting.

##### Procedural vs declarative 

There is an abundance of reasons why declarative approach is better that procedural. One of the main ones is that the configuration you read with declarative is always the latest one. Because terraform would destroy anything that exists on site but not in your config. The other side is that with procedural appraoch, you have to ensure for yourself, that your slate is clean before applying new configuration. Otherwise you can end up with duplicates.

##### Client/server vs Client only 

Terraform and ansible are almost only client-only orchestrators. This only means you do not need to install terraform to instances running on prem or in the cloud. That would be different with Clinet/server configurations.


Photo by [Austin Distel](https://unsplash.com/@austindistel?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on Unsplash
