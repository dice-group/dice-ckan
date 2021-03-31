# DICE CKAN


## About this repository

This repository was forked from [ckan/ckan](https://github.com/ckan/ckan).

To be able to keep the repositories in sync, to provide this information and not to end up in merge conflicts, the additional branch [dice](https://github.com/dice-group/dice-ckan/tree/dice) was created and set as default branch.

When this repository was created, the latest CKAN version was [release 2.9.2](https://github.com/ckan/ckan/releases/tag/ckan-2.9.2) (commit 1b6d917). That version was used to create branch [dice-ckan-2.9.2](https://github.com/dice-group/dice-ckan/tree/dice-ckan-2.9.2).


## Installation using Docker

The following installation instructions are based on [Docs 2.9.2: Installing CKAN with Docker Compose](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html).
The  installation will run five Docker containers: CKAN, PostgreSQL, Redis, Solr and CKAN Datapusher.

### 1. Environment

The docker people used a cloud based VM with 16 GB storage. They mounted a 100 GB btrfs-formatted external storage volume and symlinked /var/lib/docker to the external volume.

Install *Docker* and *Docker Compose*.

Get the code:

```shell
git clone https://github.com/dice-group/dice-ckan.git
git checkout dice-ckan-2.9.2
```

### 2. Build Docker images

Create the configuration file [.env](https://github.com/dice-group/dice-ckan/blob/dice-ckan-2.9.2/contrib/docker/.env.dice.template):

```shell
cp contrib/docker/.env.dice.template contrib/docker/.env
```

* The file contains entries to run CKAN on localhost. For a production setup, edit **CKAN_SITE_URL** and **CKAN_PORT**.
* You should also change the password entries **POSTGRES_PASSWORD** and **DATASTORE_READONLY_PASSWORD**.
* To enable CKAN to send mails, set the **CKAN_SMTP_*** entries.

Start Docker:

```shell
cd contrib/docker
sudo docker-compose up -d --build
```

On first runs, the postgres container could need longer to initialize the database cluster than the ckan container will wait for. This time span depends heavily on available system resources. If the CKAN logs show problems connecting to the database, restart the ckan container a few times:

```shell
docker-compose restart ckan
docker ps | grep ckan
docker-compose logs -f ckan
```

There should be 5 containers running and 4 volumes. (Check the
[original docs](shttps://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html#build-docker-images)
for details.)  
Access your running instance at CKAN_SITE_URL (e.g. [localhost:5000](http://localhost:5000) or [datasets.dice-resarch.org:443](https://datasets.dice-resarch.org:443))


### 3. Datastore and datapusher

Execute the built-in setup script (this is a [fixed command](https://github.com/ckan/ckan/issues/5677#issuecomment-713279480)):

```shell
docker exec ckan /usr/local/bin/ckan -c /etc/ckan/production.ini datastore set-permissions | docker exec -i db psql -U ckan
```

Add **datastore datapusher** to **ckan.plugins** and  enable the datapusher option **ckan.datapusher.formats**:

```shell
sudo docker exec -it ckan bash
nano /etc/ckan/production.ini
```

```ini
ckan.plugins = [...] datastore datapusher
ckan.datapusher.formats = [...]
```

Restart:

```shell
docker-compose restart ckan
```

Check if the datastore API returns content, e.g. at
[localhost](localhost:5000/api/3/action/datastore_search?resource_id=_table_metadata) or
[datasets.dice-resarch.org](https://datasets.dice-resarch.org:443/api/3/action/datastore_search?resource_id=_table_metadata).


### 4. Create CKAN admin user

```shell
docker exec -it ckan /usr/local/bin/ckan -c /etc/ckan/production.ini sysadmin add wilke
```


# TODO

- HTTPS
- DCAT extension
- disable web account creation 