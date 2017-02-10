Teeny Webserver Container
=========================

If you need to transfer some secret data to some over the internet, you could do worse than provide
a username and password to an SSL site.

This repo will allow you do this

Get SSL cert
------------

For this used LetsEncrypt to get a cert.


First I installed the script that does all the magic to get the cert.

    sudo apt install letsencrypt

The I ran the script.

    sudo letsencrypt certonly

The script places the cert in `/etc/letsencrypt/live/YOURDOMAIN/`, so I
copied the certs to my local dir.

    sudo bash -c `cp -L /etc/letsencrypt/live/MYDOMAIN/* ./ssl/`

Create HTML
-----------

This is a web service so I put my senative data in an html page.

    echo 'my favorite color is pink' > ./webroot/index.html

Build
-----

Build your container image like so

    docker build -t teeny-webserver . 

Run
---

Now you run the container like so

    docker run -it --rm --name=teeny-webserver \
      --volume=`pwd`/ssl:/ssl \
      --volume=`pwd`/webroot:/webroot \
      --env=HTTPUSER=dave --env=PASSWORD=rave \
      --publish=443:443 \
      teeny-webserver

You should be able to email the person and tell them to visit: https://my.domain.com/
and use the details you provided to access your senative data.

