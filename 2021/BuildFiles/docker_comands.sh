docker build -t dmbala/shahclass-ru .
docker push dmbala/shahclass-ru
docker run -p 8888:8787 -e PASSWORD=bala123 -e USER=bala dmbala/shahclass-ru
