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
-e "LOGO=https://it.pami.org.ar/profiles/dkan/themes/contrib/nuboot/logo.png" \
--link mongo:mongo \
--name debatics democracyos/app:0.14.0-deis
