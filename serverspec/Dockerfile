FROM ruby:2.1
ADD Gemfile /usr/src/app/Gemfile
ADD Rakefile /usr/src/app/Rakefile
WORKDIR /usr/src/app

RUN bundle

ENTRYPOINT ["/usr/local/bin/rake"]

CMD ["spec"]
