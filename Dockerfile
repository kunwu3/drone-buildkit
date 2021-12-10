FROM alpine:3.13
RUN apk --no-cache add curl ca-certificates bash && \
    curl -L https://glare.now.sh/moby/buildkit/linux-amd64 | tar xz && \
    chmod a+x bin/buildctl && \
    mv bin/buildctl /usr/local/bin/ && \
    rm -rf ./bin
COPY buildctl.sh /
ENTRYPOINT ["/buildctl.sh"]