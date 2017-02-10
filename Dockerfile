FROM alpine
RUN apk add --update bash apache2-utils nginx \
    && rm -rf /var/cache/apk/* \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && mkdir /webroot /ssl /pass

VOLUME /ssl /webroot

COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80 443

ENV HTTPUSER auser
ENV PASSWORD asecret

CMD bash -c 'htpasswd -cb /pass/htpasswd $HTTPUSER $PASSWORD && nginx'
