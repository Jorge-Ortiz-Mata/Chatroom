FROM ruby:3.0.4 as base

RUN apt-get update -qq \
    && apt-get install -y nodejs \
    ca-certificates \
    curl \
    sudo \
    postgresql-client \
    imagemagick \
    libvips

WORKDIR /chatroom

FROM base as development

RUN apt-get update

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD [ "puma" ]
