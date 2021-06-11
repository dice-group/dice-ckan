# DICE CKAN

![](images/screenshot.jpg)

## Installation using Docker

The following installation instructions are based on [Docs 2.9.2: Installing CKAN with Docker Compose](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html) and [ckanext-dcat](https://github.com/ckan/ckanext-dcat).
The  installation will run five Docker containers: CKAN, PostgreSQL, Redis, Solr and CKAN Datapusher.

Note: A HTTPS configuration is not integrated in this setup.


### 1. Environment

The docker people used a cloud based VM with 16 GB storage. They mounted a 100 GB btrfs-formatted external storage volume and symlinked /var/lib/docker to the external volume.

Install *Docker* and *Docker Compose* on your system.

Get the DICE CKAN source files:

```shell
git clone https://github.com/dice-group/dice-ckan.git
cd dice-ckan
git checkout dice-ckan-2.9.2
```


### 2. Build Docker images

Create the configuration file [.env](https://github.com/dice-group/dice-ckan/blob/dice-ckan-2.9.2/contrib/docker/.env.dice.template):

```shell
cp contrib/docker/.env.dice.template contrib/docker/.env
```

* The file contains entries to run CKAN on localhost. For a production setup, edit ***CKAN_SITE_URL*** and ***CKAN_PORT***.
* You can also change the password entries *POSTGRES_PASSWORD* and *DATASTORE_READONLY_PASSWORD*.
* To enable CKAN to send mails, set the *CKAN_SMTP_** entries.

Build and start Docker:

```shell
cd contrib/docker
docker-compose up -d --build
```

Note: On first runs, the postgres container could need longer to initialize the database cluster than the ckan container will wait for. This time span depends heavily on available system resources. If the CKAN logs show problems connecting to the database, restart the ckan container a few times:

```shell
docker-compose restart ckan
docker ps | grep ckan
docker-compose logs -f ckan
```

There should be 5 containers (CKAN, PostgreSQL, Redis, Solr, CKAN Datapusher) running and 4 volumes (docker_ckan_config, docker_ckan_home, docker_ckan_storage, docker_pg_data) avilable. (See the
[original docs](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html#build-docker-images)
for details.)

Access your running instance at CKAN_SITE_URL (e.g. [localhost:5000](http://localhost:5000) or [datasets.dice-research.org:443](https://datasets.dice-research.org:443)).


### 3. Datastore and datapusher

Execute the built-in setup script:

```shell
docker exec ckan /usr/local/bin/ckan -c /etc/ckan/production.ini datastore set-permissions | docker exec -i db psql -U ckan
```

(Note: this is a [fixed command](https://github.com/ckan/ckan/issues/5677#issuecomment-713279480), as from CKAN 2.9 onwards, the paster command has been replaced with the ckan command)

Add **datastore datapusher** to **ckan.plugins** and  enable the datapusher option **ckan.datapusher.formats**:

```shell
docker exec -u 0 -it ckan bash # as root
apt-get update ; apt-get install nano
nano /etc/ckan/production.ini
```

Values:

```ini
ckan.plugins = [...] datastore datapusher
ckan.datapusher.formats = [...]
```

Check if the datastore API returns content, e.g. at
[localhost:5000](http://localhost:5000/api/3/action/datastore_search?resource_id=_table_metadata) or
[datasets.dice-research.org:443](https://datasets.dice-research.org:443/api/3/action/datastore_search?resource_id=_table_metadata).


### 4. CKAN admin user

You will be asked if you want to create a new user and for the related password to set.  
E-Mail values can be nomail@example.org.

```shell
docker exec -it ckan /usr/local/bin/ckan -c /etc/ckan/production.ini user setpass default
docker exec -it ckan /usr/local/bin/ckan -c /etc/ckan/production.ini user add dice
```


### 5. Migrate data

Not integrated now. Can be added later, see [docs](https://docs.ckan.org/en/2.9/maintaining/installing/install-from-docker-compose.html#migrate-data).


### 6. Add extensions


#### Add DCAT extension

Install unzip:

```shell
docker exec -u 0 -it ckan bash # as root
apt-get install unzip
```

Install the extension:

```shell
docker exec -it ckan bash
source $CKAN_VENV/bin/activate && cd $CKAN_VENV/src/
wget https://github.com/ckan/ckanext-dcat/archive/refs/tags/v1.1.1.zip
unzip v1.1.1.zip
cd ckanext-dcat-1.1.1/
pip install -r requirements.txt
python setup.py install
```

Add the extension to CKAN plugins:

```shell
docker exec -it ckan nano /etc/ckan/production.ini
```

Values:

```ini
ckan.plugins = [...] dcat dcat_json_interface structured_data
```

Check if the catalog is available, e.g. at
[localhost:5000/catalog.ttl](http://localhost:5000/catalog.ttl) or
[datasets.dice-research.org:443/catalog.ttl](https://datasets.dice-research.org:443/catalog.ttl).


#### Add DICE extension

Install the extension:

```shell
docker exec -it ckan bash
source $CKAN_VENV/bin/activate && cd $CKAN_VENV/src/
wget -O dice-ckanext-master.zip https://github.com/dice-group/dice-ckanext/archive/refs/heads/master.zip
unzip dice-ckanext-master.zip
cd dice-ckanext-master/
python setup.py install
```

Add the extension to CKAN plugins:

```shell
docker exec -it ckan nano /etc/ckan/production.ini
```

Values:

```ini
ckan.plugins = [...] dice
```

Check if the field *Publisher URI* is displayed on creating a new dataset, e.g. at
[localhost:5000/dataset/new](http://localhost:5000/dataset/new) or
[datasets.dice-research.org:443/dataset/new](https://datasets.dice-research.org:443/dataset/new).


### 7. Configuration

Edit the configuration file ([docs](https://docs.ckan.org/en/2.9/maintaining/configuration.html#ckan-configuration-file)) via:

```shell
docker exec -it ckan nano /etc/ckan/production.ini
```

Values:

```ini
## Authorization Settings
[...]
ckan.auth.user_delete_groups = false
ckan.auth.user_delete_organizations = false
[...]
ckan.auth.create_user_via_web = false
[...]
ckan.auth.public_user_details = false
[...]

## Front-End Settings
[...]
ckan.site_title = DICE datasets
[...]
ckan.favicon = /base/images/dice-favicon.png
[...]
licenses_group_url = http://licenses.opendefinition.org/licenses/groups/ckan.json
[...]

## Internationalisation Settings
[...]
ckan.locale_order = en de es fr it pl nl ru pt_BR ja cs_CZ ca el sv sr fi sr@latin no sk bg ko_KR hu sa sl lv
[...]

## Storage Settings
[...]
ckan.max_resource_size = 0
```

## Configuration via web frontend

The main installation is complete.
Additional configuration can be set afterwards in the Web interface. There are some prepared [default settings](configuration.md).


## About this repository

This repository was forked from [ckan/ckan](https://github.com/ckan/ckan).

To be able to keep the repositories in sync, to provide this readme file and not to end up in merge conflicts, the additional branch [dice](https://github.com/dice-group/dice-ckan/tree/dice) was created and set as default branch.

When this repository was created, the latest CKAN version was [release 2.9.2](https://github.com/ckan/ckan/releases/tag/ckan-2.9.2) (commit 1b6d917). That version was used to create branch **[dice-ckan-2.9.2](https://github.com/dice-group/dice-ckan/tree/dice-ckan-2.9.2)**. You can compare the [changes](https://github.com/dice-group/dice-ckan/compare/ckan-2.9.2..dice-ckan-2.9.2).