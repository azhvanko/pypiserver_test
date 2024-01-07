## Pypiserver test

### Installation and usage
##### 1) Install `Docker`/`docker-compose` ([installation guide](https://docs.docker.com/engine/install/)), `certbot` ([installation guide](https://certbot.eff.org/instructions)), `git`, `make`, `openssl`, `htpasswd`
##### 2) Clone this repository
    mkdir pypiserver_test
    git clone git@github.com:azhvanko/pypiserver_test.git ./pypiserver_test/
##### 3) Generate SSL certificates for your domain (you must own the domain for which you’ll be fetching certificates and it must resolve to the public IP address where the docker container is exposed) and copy the generated certificates to `./pypiserver_test/configs/nginx/certificates/` directory
    certbot certonly --standalone -d pypi.example.com
    openssl dhparam -out dhparam.pem 4096
##### You can also automate the renewal of your Let's Encrypt certificates ([see details](https://eff-certbot.readthedocs.io/en/latest/using.html#setting-up-automated-renewal))
##### 4) Create an Apache password file to be able to password protect your pypiserver instance and copy the generated passwords to `./pypiserver_test/configs/htpasswd/`
    htpasswd -cb .htpasswd admin admin && cp ./.htpasswd ./pypiserver_test/configs/htpasswd/admin &&\
    htpasswd -b .htpasswd reader reader && cp ./.htpasswd ./pypiserver_test/configs/htpasswd/all
##### 5) Replace the `server_name` directive with your domain/IP address in the `./pypiserver_test/configs/nginx/nginx.conf` file
##### 6) Run pypiserver
    make start
