if [ "$(id -u)" != "0" ];
	then echo "This script must be run as root with -E parameter for proxy settings" 1>&2
	exit 1
fi

docker-compose -p debatics up -d
