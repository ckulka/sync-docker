# Resilio Sync

[Sync](https://www.resilio.com/individuals/) uses peer-to-peer technology to provide fast, private file sharing for teams and individuals. By skipping the cloud, transfers can be significantly faster because files take the shortest path between devices. Sync does not store your information on servers in the cloud, avoiding cloud privacy concerns.

## Supported tags and respective Dockerfile links

* [`release-2.5.13`, `latest` (Dockerfile)](https://github.com/bt-sync/sync-docker/blob/2.5.13/Dockerfile)
  * `release-2.5.13-amd64`
  * `release-2.5.13-arm32v7`

## Quick reference

* **Where to get help:**
  [Help Center](https://help.getsync.com), [Support Page](https://help.getsync.com/hc/en-us/requests/new?ticket_form_id=91563)
* **Where to file issues:** [Support Page](https://help.getsync.com/hc/en-us/requests/new?ticket_form_id=91563)
* **Maintained by:** [the Resilio Sync Docker Maintainers](https://github.com/bt-sync/sync-docker)
* **Supported architectures:** [`amd64`](https://hub.docker.com/r/amd64/ubuntu/), [`arm32v7`](https://hub.docker.com/r/arm32v7/ubuntu/)

## Usage

```bash
DATA_FOLDER=/path/to/data/folder/on/the/host
WEBUI_PORT=[ port to access the webui on the host ]

mkdir -p $DATA_FOLDER

docker run -d --name Sync \
  -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
  -v $DATA_FOLDER:/mnt/sync \
  --restart on-failure \
  resilio/sync
```

Go to <http://localhost:$WEBUI_PORT> in a web browser to access the webui.

**Important:** if you need to run Sync under specific user inside your container - use `--user` parameter ([Docs](https://docs.docker.com/engine/reference/run/#user)).

### LAN access

If you do not want to limit the access to the webui to `localhost`, run instead:

    docker run -d --name Sync \
      -p $WEBUI_PORT:8888 -p 55555 \
      -v $DATA_FOLDER:/mnt/sync \
      --restart on-failure \
      resilio/sync

### Extra directories

If you need to mount extra directories, mount them in `/mnt/mounted_folders`:

```bash
docker run -d --name Sync \
  -p 127.0.0.1:$WEBUI_PORT:8888 -p 55555 \
  -v $DATA_FOLDER:/mnt/sync \
  -v <OTHER_DIR>:/mnt/mounted_folders/<DIR_NAME> \
  -v <OTHER_DIR2>:/mnt/mounted_folders/<DIR_NAME2> \
  --restart on-failure \
  resilio/sync
```

Do not create directories at the root of `mounted_folders` from the Sync webui since this new folder will not be mounted on the host.

### Volume

* `/mnt/sync` - State files and Sync folders

### Ports

* `8888` - Webui
* `55555` - Listening port for Sync traffic

## Building the image

The image uses three build arguments:

* `FROM_ARCH` is the platform of the [base image](https://hub.docker.com/_/ubuntu/), e.g. [`amd64`](https://hub.docker.com/r/amd64/ubuntu/) or [`arm32v7`](https://hub.docker.com/r/arm32v7/ubuntu/)
* `ARCH` is the target platform as provided by Resilio, e.g. `x64` or `armhf`
* `VERSION` is the version of Resilio Sync, e.g. `2.5.13` or `stable`

```bash
docker build -t resilio/sync \
  --build-arg FROM_ARCH=amd64 \
  --build-arg ARCH=x64 \
  --build-arg VERSION=stable \
  .
```