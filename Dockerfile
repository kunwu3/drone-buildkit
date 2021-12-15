FROM alpine:3.13
USER root
COPY buildctl.sh /
RUN apk --no-cache add curl ca-certificates bash && \
    curl -L https://glare.now.sh/moby/buildkit/linux-amd64 | tar xz && \
    chmod a+x bin/buildctl && \
    mv bin/buildctl /usr/local/bin/ && \
    rm -rf ./bin
RUN /bin/bash -c 'chmod a+x /buildctl.sh'
CMD ["/bin/bash", "/buildctl.sh"]
