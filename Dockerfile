FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential apt-utils postgresql node

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

RUN mkdir /tbb
ADD . /tbb
WORKDIR /tbb

EXPOSE 3000
EXPOSE 8888

ENV RAILS_ENV production
RUN bundle
CMD bundle exec foreman start
