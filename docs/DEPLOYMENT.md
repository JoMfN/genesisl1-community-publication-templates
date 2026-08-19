# Two-device build and deployment model

## Device A: preprocessing and release builder

Device A contains:

- the Git repository;
- Python 3.11 or later;
- GNU Make;
- TeX Live with pdfLaTeX and the required packages;
- optional Open Babel for explicit chemistry preprocessing;
- no production Nginx requirement.

Build:

```bash
git pull --ff-only
make all
```

The build:

1. removes prior build and web output;
2. copies official press-kit brand assets into every template;
3. compiles all templates in an isolated `build/` directory;
4. creates allowlisted ZIP packages;
5. creates PDF previews;
6. generates `SHA256SUMS` and `release.json`;
7. audits `/web/` and the contents of every ZIP;
8. removes the temporary build directory.

Only `web/` is a deployment artifact.

Transfer example:

```bash
rsync -av --delete web/ webhost:/srv/genesisl1-web/
```

Use a dedicated deployment account and SSH key policy appropriate to the operator.

## Device B: static Nginx host

Device B contains only the generated static files and Nginx. It does not need:

- Git history;
- TeX Live;
- Python build tools;
- Open Babel;
- manuscript source datasets;
- credentials from the build machine.

Installation:

```bash
sudo rsync -av --delete /srv/genesisl1-web/ /usr/share/nginx/html/web/
sudo find /usr/share/nginx/html/web -type d -exec chmod 0755 {} \;
sudo find /usr/share/nginx/html/web -type f -exec chmod 0644 {} \;
sudo chown -R root:root /usr/share/nginx/html/web
```

Minimal Nginx location:

```nginx
location = /web {
    return 301 /web/;
}

location /web/ {
    index index.html;
    try_files $uri $uri/ =404;
}
```

Validate and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

The web host does not build archives and should not have write permission to the
published files from the Nginx worker account.
