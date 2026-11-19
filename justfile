default:
    @just --list

install:
    bundle install

update: install

upgrade:
    bundle update
    bundle exec jekyll build

upgrade-js:
    npm update
    npm ci
    bundle exec rake js

build:
    bundle exec jekyll build

serve:
    bundle exec jekyll serve --livereload

doctor:
    bundle exec jekyll doctor

check: doctor build

docker: 
    docker build -t my-jekyll-site .
    docker run -p 4000:4000 -v $(pwd):/app my-jekyll-site

js:
    npm ci
    bundle exec rake js
