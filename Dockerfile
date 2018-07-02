FROM ruby:2.4

LABEL maintainer="Tiago Rocha <tmrocha89@gmail.com>"

RUN git clone https://github.com/tmrocha89/slate

WORKDIR /slate

RUN echo "gem 'execjs'" >> Gemfile
RUN echo "gem 'therubyracer'" >> Gemfile
RUN bundle install
#RUN gem install therubyracer

#CMD bundle exec middleman server
RUN echo "bundle exec middleman build --verbose --clean" > /usr/local/bin/update
RUN echo "cp -r /slate/build/* /build" >> /usr/local/bin/update
RUN chmod 700 /usr/local/bin/update

RUN mkdir -p /source
RUN mkdir -p /build

EXPOSE 4567
CMD cp -r /source/* /slate/source/ && update