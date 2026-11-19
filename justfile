default:
    @just --list

install:
    bundle install
    npm ci

update: install

upgrade:
    bundle update
    npm update
    bundle exec jekyll build

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

js: install
    bundle exec rake js
