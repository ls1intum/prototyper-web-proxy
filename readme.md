# Reverse-proxy configuration for Prototyper-web.


## Setup 
- Clone the repository (inclunding all submodules) with 
    ```bash
    git clone --recurse-submodules https://github.com/ls1intum/prototyper-web-proxy.git
    ```
    - If you already cloned the repository without the `--recurse-submodules` option, you can use the following commands to checkout prototyper_web
        ```bash
        git submodule init
        git submodule update --remote --merge
        ```
- Follow the setup instructions in `./prototyper_web/readme.md` file without the reverse proxy, but do not start the containers yet
- Update the `#FIXME` entries in `./nginx/prototyper.yml` and in `./init_certbot.sh`
- Start the Prototyper service (required for nginx in the next step)
    ```bash
    docker-compose up -d --build prototyper_web
    ```
- Execute the initialize certbot script. This will create the first signed certificates and start up the remaining containers. This script does not have to be run again. The certificates are renewed automatically from here on.
    ```bash
    ./init_certbot.sh
    ```

## Update to newest version 

```bash
docker-compose down
git pull
git submodule update --remote --merge
docker-compose up -d --build
```
