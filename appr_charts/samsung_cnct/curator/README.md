# A Helm Chart for Curator

## Installation

Add the following to your [Kraken](https://github.com/samsung-cnct/kraken-lib) configuration template:
```
helmConfigs:
  - &defaultHelm
    name: defaultHelm
    kind: helm
    repos:
      -
        name: atlas
        url: http://atlas.cnct.io
    charts:
      -
        name: curator
        repo: quay.io
        chart: samsung_cnct/curator
        version: 0.1.0
        namespace: kube-logging
```

Get [Kraken](https://github.com/samsung-cnct/kraken) to help you deploy a Kubernetes cluster.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credit

Created and maintained by the Samsung Cloud Native Computing Team.
