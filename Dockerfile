FROM golang:1.20 

WORKDIR /app

COPY . /app/

RUN GOOS=linux go build -o rancher_gitlab_proxy_linux main.go

CMD [ "rancher_gitlab_proxy_linux" ]
