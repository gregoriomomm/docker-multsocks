FROM ubuntu:bionic AS builder

RUN  apt update 
RUN  apt install -qy build-essential git

RUN mkdir /src 
WORKDIR /src  
RUN git clone https://github.com/gregoriomomm/microsocks
WORKDIR /src/microsocks
RUN  make 

FROM ubuntu:bionic AS runner

RUN  apt-get update &&  apt-get install -qy tsocks nmap socat &&  rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN mkdir /multsocks
COPY --from=builder /src/microsocks/microsocks /multsocks/microsocks 
COPY tsocks.conf /etc/tsocks.conf 
COPY run.sh /multsocks/run.sh

RUN chmod +x /multsocks/microsocks  
RUN chmod +x /multsocks/run.sh 

EXPOSE 1080/udp 1080/udp

CMD /multsocks/run.sh
