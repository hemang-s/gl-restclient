FROM golang:latest as builder

ARG OS=darwin
ARG ARCH=amd64

WORKDIR /go/src/github.com/APPNAME

COPY . .
ENV GO111MODULE=on
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o APPNAME .

FROM alpine:latest
COPY --from=builder /go/src/github.com/APPNAME /app
ENV PATH=$PATH:/app

CMD [ "APPNAME" ] 