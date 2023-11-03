
A docker image for making rancher and self-hosted gitlab oauth authentication work together.

## Usage

```sh
docker run --name rancher-gitlab-proxy -d \
	-e GITLAB_URL=https://gitlab.domain.com/ \
	-e RANCHER_URL=https://rancher.domain.com/ \
	-p 8888:8888 \
	ghcr.io/joy2fun/rancher-gitlab-proxy:master
```

## GitLab application settings

The Callback URI has to be `https://rancher.domain.com/verify-auth`

The Scope has to be `read_api`


## Addtional gitlab.rb configuration

```conf
	nginx['custom_gitlab_server_config'] = "
	        # CONNECTION TO rancher-gitlab-proxy BEGIN
	        location /login/oauth/authorize {
	                proxy_pass http://rancher-gitlab-proxy-host:8888;
	        }
	        location /login/oauth/access_token {
	                proxy_pass http://rancher-gitlab-proxy-host:8888;
	        }
	        location /api/v3/user {
	                proxy_pass http://rancher-gitlab-proxy-host:8888;
	        }
	        location /api/v3/teams/ {
	                proxy_pass http://rancher-gitlab-proxy-host:8888;
	        }
	        location /api/v3/search/users {
	                proxy_pass http://rancher-gitlab-proxy-host:8888;
	        }
	        # CONNECTION TO rancher-gitlab-proxy END
	"
```

## Links

https://github.com/rancher/rancher/issues/1317

https://sandstorm.de/de/blog/post/making-rancher-2-and-gitlab-oauth-authentication-work-together.html
