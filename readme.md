# Reverse-proxy configuration for Prototyper-web.


## Setup 
- Clone the repository (inclunding all submodules) with 
    ```bash
    git clone --recurse-submodules https://github.com/ls1intum/prototyper-web-proxy.git
    ```
    - If you already cloned the reposiotry without the `--recurse-submodules` option, you can use the following commands to checkout prototyper_web
        ```bash
        git submodule init
        git submodule update --remote --merge
        ```
- Follow the setup instructions in `./prototyper_web/readme.md` file 
- Update the `#FIXME` entries in `./nginx/prototyper.yml` and in `init_certbot.sh`
- Execute the certbot script 
    ```bash
    ./init_certbot.sh
    ```
- Start the service with 
    ```bash
    docker-compose up -d --build
    ```

- TBA 
    - TODO: certbot script 


## Update to newest version 

```bash
docker-compose down
git pull
git submodule update --remote --merge
docker-compose up -d --build
```
