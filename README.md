# Drone-capistrano
> Inspired by [drone-capistrano](https://github.com/glaszig/drone-capistrano)

##  Usage
1. Generate SSH key for deploy
2. Put public SSH key to the server that you want to deploy
3. Set drone secret capistrano_private_key with private SSH key
```
drone secret add \
  --name capistrano_private_key \
  --value @$HOME/.ssh/deploy_rsa \
  --image uitk23009/drone-capistrano
  --repository octocat/hello-world

```
4. Set drone task
```
pipeline:
  deploy:
    image: uitk23009/drone-capistrano
    pull: true
    repo: octocat/hello-world
    capistrano_cmd:
        - cap production deploy
        - cap staging deploy
    secrets: [ capistrano_private_key ]
    when:
      branch: master
```