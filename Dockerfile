FROM golang:latest as build

WORKDIR /go/src/app
ADD . /go/src/app

RUN go get -d -v ./...

RUN go build -o /go/bin/k8s-oidc-helper

# Now copy it into our base image.
FROM gcr.io/distroless/base-debian10
COPY --from=build /go/bin/k8s-oidc-helper /k8s-oidc-helper
ENTRYPOINT ["/k8s-oidc-helper"]