FROM ruby:3.2.2

RUN echo "Africa/Addis_Ababa" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cmake
RUN mkdir /opt/app
WORKDIR /opt/app

COPY ./Gemfile ./Gemfile.lock ./

RUN bundle install --jobs 20 --retry 5

COPY . .

EXPOSE 3000

CMD [ "rails", "s", "-b", "0.0.0.0"]