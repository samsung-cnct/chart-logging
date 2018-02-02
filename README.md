[![pipeline status](https://git.cnct.io/common-tools/samsung-cnct_chart-logging/badges/master/pipeline.svg)](https://git.cnct.io/common-tools/samsung-cnct_chart-logging/commits/master)


# Logging for Kubernetes Cluster
This is a light-weight logging solution for a production grade Kubernetes cluster. This system pulls logs from pods, enriches them with Kubernetes metadata, saves them in a data store and makes them available for visualizing and querying - without ever leaving the kubernetes cluster.  This system also handles Kubernetes event stream logs with [eventrouter](https://github.com/samsung-cnct/chart-eventrouter), but does not yet collect etcd logs.

## How to install on running Kubernetes cluster with `helm`
Get Helm [here](https://github.com/kubernetes/helm/blob/master/docs/install.md).
Make sure your cluster has at least 6 clusterNodes and update the providerConfig.type to m4.xlarge
Install Helm and the Helm registry plugin with [these](https://github.com/app-registry/appr-helm-plugin/blob/master/README.md#install-the-helm-registry-plugin) instructions.

```
helm registry install quay.io/samsung_cnct/logging
```

To install at cluster creation with [kraken-lib](https://github.com/samsung-cnct/kraken-lib) , edit your  [configuration template](https://github.com/samsung-cnct/kraken-lib/blob/5309d46209d5dae53ae70a53dc4bf781e3cf59b5/ansible/roles/kraken.config/files/config.yaml#L14-L28) `helmConfigs`:

```
helmConfigs:
  - &defaultHelm
    name: defaultHelm
    kind: helm
    repos:
      - name: stable
        url: https://kubernetes-charts.storage.googleapis.com
    charts:
      - name: logging
        registry: quay.io
        chart: samsung_cnct/logging

        channel: stable
        # or you may use version instead of channel (ex: version: 0.0.1-42)
        # visit https://quay.io/application/samsung_cnct/logging to see available versions

```

Once this system is set up, you can see your logs by running `kubectl get svc kibana-logging -owide`, then view your logs at `<EXTERNAL_IP>:5601`

Get [kraken](https://github.com/samsung-cnct/kraken) to help you deploy a Kubernetes cluster.

## Assets
Assets for each component in the centralized logging system including github repo, quay repo for the container and quay app registry for the chart.

**On Node Collector:** A Fluent-bit daemonset is responsible for collecting logs from applications on pods.
* Github Container Repo: https://github.com/samsung-cnct/container-fluent-bit
* Github Chart Repo: https://github.com/samsung-cnct/chart-fluent-bit
* Image: https://quay.io/repository/samsung_cnct/fluent-bit-container
* Chart: https://quay.io/application/samsung_cnct/fluent-bit

**Eventstream Log Collector:**  The eventrouter is used to watch for kubernetes apiserver events. Eventrouter is configured to write the events to stdout.  Fluentbit forwards the stdout events to Elasticsearch.
* Github Container Repo: https://github.com/samsung-cnct/container-eventrouter
* Github Chart Repo: https://github.com/samsung-cnct/chart-eventrouter
* Image: https://quay.io/repository/samsung_cnct/eventrouter-container
* Chart: https://quay.io/application/samsung_cnct/eventrouter

**Queryable Datastore:** ElasticSearch
* Github Container Repo: https://github.com/samsung-cnct/container-elasticsearch
* Github Chart Repo: https://github.com/samsung-cnct/chart-elasticsearch
* Image: https://quay.io/repository/samsung_cnct/elasticsearch-container
* Chart: https://quay.io/application/samsung_cnct/elasticsearch-chart

**Index Manager for Elasticsearch** Curator
* Github Container Repo: https://github.com/samsung-cnct/container-curator
* Github Chart Repo: https://github.com/samsung-cnct/chart-curator
* Image: https://quay.io/repository/samsung_cnct/curator-container
* Chart: https://quay.io/application/samsung_cnct/curator

**Data Visualization:** Kibana
* Github Container Repo: https://github.com/samsung-cnct/container-kibana
* Github Chart Repo: https://github.com/samsung-cnct/chart-kibana
* Image: https://quay.io/repository/samsung_cnct/kibana-container
* Chart: https://quay.io/application/samsung_cnct/kibana-chart

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits

Created and maintained by the Samsung Cloud Native Computing Team.
