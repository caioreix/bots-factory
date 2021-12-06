FROM golang:1.17-alpine3.13 as builder
WORKDIR /go/src/github.com/caioreix

COPY . .
RUN apk add --no-cache git tree make
RUN cd cmd/channels/discord && make build
RUN mv cmd/channels/discord/discord build/channels/discord

FROM alpine
WORKDIR /root
COPY --from=builder /go/src/github.com/caioreix/build/channels/discord .
CMD ["./discord"]
