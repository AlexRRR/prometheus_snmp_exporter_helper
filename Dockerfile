FROM debian:8.7
RUN echo "deb http://ftp.debian.org/debian/ jessie main contrib non-free" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
	curl build-essential libsnmp-dev snmp-mibs-downloader \
	&& rm -rf /var/lib/apt/lists/* 
RUN curl -O https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz \
 	&& tar xvf go1.8.linux-amd64.tar.gz \
	&& chown -R root:root ./go \
	&& mv go /usr/local 
	
ENV GOPATH=/root/work
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
COPY ./snmp_exporter /root/work/src/github.com/prometheus/snmp_exporter/
WORKDIR /root/work/src/github.com/prometheus/snmp_exporter/generator/
RUN go build
RUN mkdir -p /generator/mibs \ 
	&& mkdir -p /root/.snmp \ 
	&& ln -sf /generator/snmp.yml /root/work/src/github.com/prometheus/snmp_exporter/generator/snmp.yml \
	&& ln -sf /generator/generator.yml /root/work/src/github.com/prometheus/snmp_exporter/generator/generator.yml \
	&& ln -sf /generator/mibs /root/.snmp/mibs
ENTRYPOINT ["./generator"]

