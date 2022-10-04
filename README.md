# Kadras Application Platform

This project provides a curated set of [Carvel packages](https://carvel.dev/kapp-controller/docs/latest/packaging) to build an application platform or internal developer platform (IDP) on Kubernetes. 

## Components

* application-platform

## Prerequisites

* Install the [`kctrl`](https://carvel.dev/kapp-controller/docs/latest/install/#installing-kapp-controller-cli-kctrl) CLI to manage Carvel packages in a convenient way.
* Ensure [kapp-controller](https://carvel.dev/kapp-controller) is deployed in your Kubernetes cluster. You can do that with Carvel
[`kapp`](https://carvel.dev/kapp/docs/latest/install) (recommended choice) or `kubectl`.

```shell
kapp deploy -a kapp-controller -y \
  -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml
```

## Installation

You can install the Kadras Application Platform package directly or rely on the [Kadras package repository](https://github.com/arktonix/kadras-packages)
(recommended choice).

Follow the [instructions](https://github.com/arktonix/kadras-packages) to add the Kadras package repository to your Kubernetes cluster.

If you don't want to use the Kadras package repository, you can create the necessary `PackageMetadata` and
`Package` resources for the Kadras Application Platform package directly.

```shell
kubectl create namespace carvel-packages
kapp deploy -a application-platform-package -n carvel-packages -y \
    -f https://github.com/arktonix/application-platform/releases/latest/download/metadata.yml \
    -f https://github.com/arktonix/application-platform/releases/latest/download/package.yml
```

Either way, you can then install the Kadras Application Platform package using [`kctrl`](https://carvel.dev/kapp-controller/docs/latest/install/#installing-kapp-controller-cli-kctrl).

```shell
kctrl package install -i application-platform \
    -p application-platform.packages.kadras.io \
    -v 0.1.2 \
    -n carvel-packages
```

You can retrieve the list of available versions with the following command.

```shell
kctrl package available list -p application-platform.packages.kadras.io
```

You can check the list of installed packages and their status as follows.

```shell
kctrl package installed list -n carvel-packages
```

## Configuration

The Kadras Application Platform package has the following configurable properties.

| Config | Default | Description |
|-------|-------------------|-------------|
| `packages.namespace` | `""` | The namespace where to install the platform. |
| `packages.exclusions` | `[]` | A list of packages to exclude from being installed. |
| `cartographer.blueprints` | `{}` | Configuration for the Cartographer Blueprints package. |
| `cartographer.delivery` | `{}` | Configuration for the Cartographer Delivery package. |
| `cartographer.golden_path_web` | `{}` | Configuration for the Cartographer Golden Path Web package. |
| `cert_manager` | `{}` | Configuration for the Cert Manager package. |
| `contour` | `{}` | Configuration for the Contour package. |
| `conventions.spring_boot` | `{}` | Configuration for the Spring Boot Conventions package. |
| `knative.serving` | `{}` | Configuration for the Knative Serving package. |
| `kpack` | `{}` | Configuration for the Kpack package. |
| `metrics_server` | `{}` | Configuration for the Metrics Server package. |
| `namespace_setup` | `{}` | Configuration for the Namespace Setup package. |
| `secretgen_controller` | `{}` | Configuration for the Secretgen Controller package. |
| `tekton.pipelines` | `{}` | Configuration for the Tekton Pipelines package. |

You can define your configuration in a `values.yml` file.

```yaml
packages:
  namespace: ""
  exclusions:
    - ""

cartographer:
  blueprints: {}
  delivery: {}
  golden_path_web: {}

cert_manager:
  namespace: cert-manager

contour: {}

conventions:
  spring_boot: {}

knative:
  serving: {}

kpack: {}

metrics_server: {}

namespace_setup: {}

secretgen_controller: {}

tekton:
  pipelines: {}
```

Then, reference it from the `kctrl` command when installing or upgrading the package.

```shell
kctrl package install -i application-platform \
    -p application-platform.packages.kadras.io \
    -v 0.1.2 \
    -n carvel-packages \
    --values-file values.yml
```

## Documentation

For documentation specific to Cartographer, check out [cartographer.sh](https://cartographer.sh).

## References

This package is inspired by:

* the [App Toolkit](https://github.com/vmware-tanzu/community-edition/tree/main/addons/packages/app-toolkit) package used in Tanzu Community Edition;
* the [OSS Stack](https://github.com/vrabbi/tap-oss) example of [Tanzu Application Platform](https://tanzu.vmware.com/application-platform).

## Supply Chain Security

This project is compliant with level 2 of the [SLSA Framework](https://slsa.dev).

<img src="https://slsa.dev/images/SLSA-Badge-full-level2.svg" alt="The SLSA Level 2 badge" width=200>
