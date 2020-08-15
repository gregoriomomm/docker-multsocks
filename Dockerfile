FROM alpine:3.11 AS builder

RUN  apk add --update alpine-sdk 

RUN mkdir /src 
WORKDIR /src  
RUN git clone https://github.com/gregoriomomm/microsocks
WORKDIR /src/microsocks 
RUN  make 

FROM alpine:3.11 AS runner

RUN  apk add --update --no-cache tsocks nmap-ncat socat bash 

RUN mkdir /multsocks
COPY --from=builder /src/microsocks/microsocks /multsocks/microsocks 
COPY tsocks.conf /etc/tsocks.conf 
COPY run.sh /multsocks/run.sh

RUN chmod +x /multsocks/microsocks  /multsocks/run.sh 

EXPOSE 1080/udp 1080/udp

CMD /multsocks/run.sh