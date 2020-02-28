
![Docker Pulls](https://img.shields.io/docker/pulls/cmjchrisjones/dockersslcertificategener8or)

# What is this

This is a docker image that will simply create a self-signed certificate (SSL) for web development


## Can I see the source code

Sure, its public over on my [GitHub Repo](https://github.com/cmjchrisjones/DockerSSLCertificateGener8or)

## How do I use it

- Windows
  - via Docker Run
    ```
    docker run -e PASSWORD=qqqq -e COMMON_NAME=elite -v ${PWD}/certs:/certs/ cmjchrisjones/dockersslcertificategener8or
      ```
  - via Docker Compose
    ```
          version: "3.7"

          services:
            certs:
              image: cmjchrisjones/dockersslcertificategener8or
              env_file:
                - ./env/.env
              volumes:
                - ./certs/:/certs
    ```

- MAC
  - TBC
- Linux
  - TBC