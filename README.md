# SSH Reverse Tunnel

<div align="left">

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/c0depool/ssh-reverse-tunnel/docker-publish.yml?style=for-the-badge)](https://github.com/c0depool/ssh-reverse-tunnel/actions/workflows/docker-publish.yml)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/c0depool/ssh-reverse-tunnel?sort=semver&style=for-the-badge)](https://github.com/c0depool/ssh-reverse-tunnel/releases)

</div>

This is a simple SSH reverse tunnel to forward your local port to a remote server without the needing to change any configuration on your router. You can use this to expose your local applications to internet if you have a compute resource on any Public Cloud platform (like AWS, GCP, Azure, OCI etc.).

## Usage

You should have your remote server SSH Key renamed as id_rsa. For simplicity you can copy the key to ~/.ssh in your local machine.

On your remote server edit the /etc/ssh/sshd_config file and set ```GatewayPorts yes```. Run ```service sshd reload``` to reload the ssh config.

Now in docker-compose.yml you can define the reverse tunnel as follows:

```yml
    version: '2'
    services:
      reverse-tunnel:
        image: ghcr.io/ssh-reverse-tunnel
        volumes:
          - $HOME/.ssh:/root/ssh
        environment:
          TUNNEL_HOST: <local application>
          TUNNEL_PORT: <local application port>
          REMOTE_HOST: <remote server hostname/IP>
          REMOTE_PORT: <remote port which should listen to your local port>
          USERNAME: <remote server username>
          SSH_EXTRA_OPTS: "-v -o ServerAliveInterval=60"
```

Run ```docker-compose up -d``` from your local machine

After you start up docker containers, the local application container port can be accessed from your remote server and from the internet if the remote server is having the corresponding port open (check your cloud provider documentation for more details). For eg. you can forward http://nginx:80 to your remote machine http://example.com:8080. You can use this to port forward any port/service via SSH.
