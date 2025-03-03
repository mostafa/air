FROM golang:1.24 AS builder

LABEL maintainer="Mostafa Moradian <mstfmoradian@gmail.com>"

ENV GOPATH /go
ENV GO111MODULE on

COPY . /go/src/github.com/mostafa/air
WORKDIR /go/src/github.com/mostafa/air

RUN --mount=type=cache,target=/go/pkg/mod go mod download

RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build make ci && make install

FROM golang:1.24

COPY --from=builder /go/bin/air  /go/bin/air

ENTRYPOINT ["/go/bin/air"]
