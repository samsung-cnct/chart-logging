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
        name: stable
        url: https://kubernetes-charts.storage.googleapis.com
    charts:
      -
        name: curator
        repo: quay.io
        chart: samsung_cnct/curator
        channel: stable

        # or you may you version instead of channel
        # version: 0.1.0  or  visit https://quay.io/application/samsung_cnct/curator for most recent stable version
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
