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

RUN mkdir /microsocks
COPY --from=builder /src/microsocks/microsocks /microsocks/microsocks 
COPY tsocks.conf /etc/tsocks.conf 
COPY run.sh /microsocks/run.sh

RUN chmod +x /microsocks/microsocks  
RUN chmod +x /microsocks/run.sh 

EXPOSE 1080/udp 1080/udp

CMD /microsocks/run.sh
