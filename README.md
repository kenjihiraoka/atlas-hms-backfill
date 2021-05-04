# atlas-hms-backfill

This repository implements the external script to run the import data script from Hive Metastore to Apache Atlas.

### Configuration

We need to change some properties according to the environment that we want to run this script.

At file [atlas-application.properties](https://github.com/kenjihiraoka/atlas-hms-backfill/blob/main/hive-metastore/atlas-configuration/atlas-application.properties)
located under `/hive-metastore/atlas-configuration`, we need to change the properties:
 
- `atlas.kafka.zookeeper.connect`
- `atlas.kafka.bootstrap.servers`
- `atlas.rest.address`

---

At file [hive-site.xml](https://github.com/kenjihiraoka/atlas-hms-backfill/blob/main/hive-metastore/hms-configuration/hive-site.xml) and
[metastore-site.xml](https://github.com/kenjihiraoka/atlas-hms-backfill/blob/main/hive-metastore/hms-configuration/metastore-site.xml)
located under `/hive-metastore/hms-configuration`, we need to change the properties:

- `javax.jdo.option.ConnectionURL`
- `javax.jdo.option.ConnectionUserName`
- `javax.jdo.option.ConnectionPassword`

### Build local script

First, build the docker image with the following command:

```bash
docker build -t atlas-backfill .
```

Now to run the script, run:

```bash
docker run -ti --rm --name atlas-backfill atlas-backfill
```

If you have a VPN layer at your machine host, its need to add the flag `--add-host` to the `docker run` command.

```bash
docker run -ti --rm --add-host=<postgres_db>:<ip> --add-host=<atlas_host>:<ip> --name atlas-backfill atlas-backfill
```

The script asks for a user and password for the Apache Atlas service.

### How it works


The script access the Hive Metastore database to get all databases and tables, it checks if those objects are already registered
at Apache Atlas backend (HBase db), and we have some cases:

1. There are not register:
    - Then, the script import all those objects directly to the Hbase and create the corresponding messages to the topic `ATLAS_ENTITIES`.

2. There are register:
    - Then, the script update the entity at Apache Atlas backend with new information from HMS database and create the corresponding messages to the topic `ATLAS_ENTITIES`.

> Obs: the topic ATLAS_HOOK does not register those operations from backfill, because the script uses the Atlas backend (HBase) directly.
