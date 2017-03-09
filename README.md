

Prometheus snmp_exporter helper
===============================

This project creates a helper container with the awesome [generator](https://github.com/prometheus/snmp_exporter/blob/master/generator/README.md) tool from the the [prometheus/snmp_exporter] project. 


## Build

to build just: 
```make```


## Usage

```sh
docker run -ti -v $PWD/snmp.yml:/generator/snmp.yml -v $PWD/generator.yml:/generator/generator.yml -v $PWD/CISCO-6200-MIB:/generator/mibs/cisco.mib alex/snmp_exporter_generator:latest  generate```

1. create a `generator.yml` file in your host containing the OIDs that you would like the tool to walk and generate a config file and mount it as a volume to `/generator/generator.yml`
2. create an empty `snmp.yml` file in your host where the generated configuration will be written, mount it in your container to `/generator/generator.yml`
3. mount the MIB file of the OIDs you would like to walk to the `/generator/mibs/` directory (they can be several, depending on your walked OIDs).
4. By running `generate` the tool will write the result to the snmp.yml which afterwards you can trim as according to your needs.



