if [ "$(id -u)" != "0" ];
	then echo "This script must be run as root with -E parameter for proxy settings" 1>&2
	exit 1
fi

docker exec -t debatics_dos_1 git config --system http.proxy $http_proxy
docker exec -t debatics_dos_1 git config --system https.proxy $http_proxy
docker exec -t debatics_dos_1 git clone https://github.com/pami-inssjp/debatics.git
docker exec -t debatics_dos_1 cp -frv debatics/debatics-theme/app/public .
