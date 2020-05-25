FROM alpine:3.11.6 as builder

WORKDIR /app

ADD https://github.com/snail007/goproxy/releases/download/v9.5/proxy-linux-amd64.tar.gz /tmp/goproxy.tar.gz
ADD https://github.com/txthinking/brook/releases/download/v20200502/brook_linux_amd64 /app/brook/brook
ADD https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz /tmp/frp.tar.gz

RUN mkdir /app/goproxy
RUN mkdir /app/frp
RUN tar -zxf /tmp/goproxy.tar.gz -C /app/goproxy
RUN tar -zxf /tmp/frp.tar.gz -C /app/frp --strip-components 1
RUN chmod 755 /app/brook/brook


FROM alpine:3.11.6

LABEL maintainer="Ztj <ztj1993@gmail.com>"

WORKDIR /app

COPY --from=builder /app /app

RUN apk add --no-cache supervisor
