FROM ruby:3.4

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/
RUN bundle install -j 8

ADD auth-service.rb /app
ENV PORT 3000
EXPOSE 3000
CMD ["ruby", "auth-service.rb"]