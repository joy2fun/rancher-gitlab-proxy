FROM golang:1.20 as builder

WORKDIR /app
COPY . /app/

RUN GOOS=linux go build -o rancher_gitlab_proxy_linux main.go

FROM alpine

WORKDIR /app
COPY --from=builder app/rancher_gitlab_proxy_linux /app/rancher_gitlab_proxy_linux
EXPOSE 8888
CMD [ "/app/rancher_gitlab_proxy_linux" ]
