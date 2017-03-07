FROM ruby:2.1.8
RUN apt-get update -qq && apt-get install -y build-essential libmysqlclient-dev apt-utils nodejs npm nodejs-legacy imagemagick

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

RUN mkdir /tbb
ADD . /tbb
WORKDIR /tbb

EXPOSE 3000
EXPOSE 8888

RUN bundle --local
