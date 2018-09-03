FROM alpine:3.8

LABEL maintainer "Valentin Lavrinenko <Valentin.Lavrinenko@gmail.com>"

ENV PUBLIC_HOST=example.com
ENV FTPD_ARGS="-c 5 -C 5 -P $PUBLIC_HOST -R -i -l puredb:/etc/pure-ftpd/pureftpd.pdb -p 30000:30009"

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add pure-ftpd@testing supervisor syslog-ng shadow

RUN mkdir -p /var/lib/ftp/pub \
    && chown -R ftp:ftp /var/lib/ftp \
    && usermod -d /var/lib/ftp/pub ftp

COPY supervisord.conf /etc/supervisord.conf
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY *.supervisor.conf /etc/supervisor.d/

EXPOSE 21 30000-30009

CMD /usr/bin/pure-pw mkdb /etc/pure-ftpd/pureftpd.pdb  -f /etc/pure-ftpd/pureftpd.passwd && /usr/bin/supervisord

