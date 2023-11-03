FROM golang:1.20 as builder

WORKDIR /app
COPY . /app/
RUN GOARCH=amd64 GOOS=linux go build -o rancher_gitlab_proxy main.go

FROM alpine

COPY --from=builder app/rancher_gitlab_proxy /bin/rancher_gitlab_proxy
EXPOSE 8888
CMD [ "rancher_gitlab_proxy" ]