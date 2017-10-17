# Logging for Kubernetes Cluster
This is a light-weight logging solution for a production grade Kubernetes cluster. This system ensures events are safely pulled from pods, enriched with Kubernetes metadata, saved in a data store and made available for visualizing and querying - without ever leaving the kubernetes cluster.  Currently this system does not handle etcd logs, nor Kubernetes event stream logs. We are working towards including these logs in future iterations of this pipeline.

## How to install on running Kubernetes cluster with `helm`
Get Helm [here](https://github.com/kubernetes/helm/blob/master/docs/install.md).
Make sure your cluster has at least 6 clusterNodes and update the providerConfig.type to m4.xlarge
Install Helm and the Helm registry plugin with [these](https://github.com/app-registry/appr-helm-plugin/blob/master/README.md#install-the-helm-registry-plugin) instructions.

```
helm registry install quay.io/samsung_cnct/logging
```


Or add the following to your [K2](https://github.com/samsung-cnct/kraken-lib) configuration template:

```
helmConfigs:
  - &defaultHelm
    name: defaultHelm
    kind: helm
    repos:
      - name: atlas
        url: http://atlas.cnct.io
      - name: stable
        url: https://kubernetes-charts.storage.googleapis.com
    charts:
      - name: logging
        registry: quay.io
        chart: samsung_cnct/logging
        version: # will update soon
        namespace: kube-system
```

Once this system is set up, you can see your logs by running `kubectl get svc kibana-logging -owide`, then view your logs at ``<EXTERNAL_IP>:5601`

Get [kraken](https://github.com/samsung-cnct/kraken) to help you deploy a Kubernetes cluster.

## Assets
Assets for each component in the centralized logging system including github repo, quay repo for the container and quay app registry for the chart.

**On Node Collector:** A Fluent-bit daemonset is responsible for collecting logs from applications on pods.
* Github Container Repo: https://github.com/samsung-cnct/container-fluent-bit
* Github Chart Repo: https://github.com/samsung-cnct/chart-fluent-bit
* Image: https://quay.io/repository/samsung_cnct/fluent-bit-container
* Chart: https://quay.io/application/samsung_cnct/fluent-bit

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
