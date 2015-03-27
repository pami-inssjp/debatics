if [ "$(id -u)" != "0" ];
	then echo "This script must be run as root with -E parameter for proxy settings" 1>&2 exit 1
fi

systemctl start docker
docker run -d -p 27017:27017 --name mongo mongo
docker run -d -p 80:80 \
-e "NODE_PATH=." \
-e "PORT=80" \
-e "STAFF=itpami@pami.org.ar" \
-e "MONGO_URL=mongodb://mongo:27017" \
-e "HOST=https://it.pami.org.ar/debatics" \
-e "NODE_ENV=production" \
-e "ORGANIZATION_URL=https://it.pami.org.ar" \
-e "LOCALE=es" \
-e "FAVICON=https://it.pami.org.ar/profiles/dkan/themes/contrib/nuboot/favicon.ico" \
-e "LOGO=/lib/boot/images/logo_debatics.png" \
-e "http_proxy=$http_proxy" \
--link mongo:mongo \
--name debatics democracyos/app:0.14.0-deis
docker exec -d debatics git config --system http.proxy $http_proxy
docker exec -d debatics git config --system https.proxy $http_proxy
docker exec -d debatics git clone https://github.com/pami-inssjp/debatics.git
docker exec -d debatics cp -fv debatics/logo_debatics.png public/lib/boot/images/logo_debatics.png
docker exec -d debatics cp -fv debatics/app.css public/app.css
