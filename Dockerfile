FROM golang:1.10-alpine3.7 as builder
WORKDIR /go/src/go-jenkins
COPY sum.go .
RUN go get -d ./... && go build -o sum .

FROM alpine:3.8
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/go-jenkins .

EXPOSE 8080
ENTRYPOINT ./sum
