FROM ruby:alpine as builder

RUN apk add --no-cache --virtual \
      build-dependencies \
      build-base \
    && true

ARG VERSION=0.4.2
RUN gem install fasterer -v $VERSION

RUN rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

FROM ruby:alpine

LABEL io.whalebrew.name 'fasterer'
LABEL io.whalebrew.config.working_dir '/workdir'

COPY --from=builder /usr/local/ /usr/local/

RUN adduser -S fasterer
USER fasterer
ENV HOME /home/fasterer

WORKDIR /workdir
ENTRYPOINT ["fasterer"]
