# Caddy server + proxy + ssl

### List of tools
* Docker
* image of Alpine linux with golang
* Caddy

Running the container
```
$ sudo docker run -it -p 80:80 -p 443:443 -p 2015:2015 \
        --name=caddy \
        -e SERVER_DOMAIN=container.thiagozs.com \
        -e LB_HOST=localhost 
        -e LB_PORT=8181 \
        -e EMAIL=yours@email.com \
        -d thiagozs/caddyproxy:1.0.0
```

If you need the image local. Just docker pull the repo.
```
$ sudo docker pull thiagozs/caddyproxy:1.0.0
```

Remember, you need open the ports **80**, **443**, **2015**. All envs need to be fill.
Any doubt you can see the **Dockerfile** for better interpretation.

---

The MIT License (MIT)

Copyright (c) 2017 THIAGO ZILLI SARMENTO

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
