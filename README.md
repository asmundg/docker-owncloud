docker-owncloud
===============

Owncloud docker image

Run this with a postgres container linked as db:

```bash
docker run --link postgres:db -P -d owncloud
```
