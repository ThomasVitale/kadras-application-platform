# Kadras Application Platform

<a href="https://slsa.dev/spec/v0.1/levels"><img src="https://slsa.dev/images/gh-badge-level3.svg" alt="The SLSA Level 3 badge"></a>

This project provides a curated set of [Carvel packages](https://carvel.dev/kapp-controller/docs/latest/packaging) to build an application platform or internal developer platform (IDP) on Kubernetes. 

## Prerequisites

* Kubernetes 1.24+
* Carvel [`kctrl`](https://carvel.dev/kapp-controller/docs/latest/install/#installing-kapp-controller-cli-kctrl) CLI.
* Carvel [kapp-controller](https://carvel.dev/kapp-controller) deployed in your Kubernetes cluster. You can install it with Carvel [`kapp`](https://carvel.dev/kapp/docs/latest/install) (recommended choice) or `kubectl`.

  ```shell
  kapp deploy -a kapp-controller -y \
    -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml
  ```

## Installation

First, add the [Kadras package repository](https://github.com/arktonix/kadras-packages) to your Kubernetes cluster.

  ```shell
  kubectl create namespace kadras-packages
  kctrl package repository add -r kadras-repo \
    --url ghcr.io/arktonix/kadras-packages \
    -n kadras-packages
  ```

Then, install the Kadras Application Platform package.

  ```shell
  kctrl package install -i application-platform \
    -p application-platform.packages.kadras.io \
    -v 0.5.1 \
    -n kadras-packages
  ```

### Verification

You can verify the list of installed Carvel packages and their status.

  ```shell
  kctrl package installed list -n kadras-packages
  ```

### Version

You can get the list of Kadras Application Platform versions available in the Kadras package repository.

  ```shell
  kctrl package available list -p application-platform.packages.kadras.io -n kadras-packages
  ```

## Configuration

The Kadras Application Platform package has the following configurable properties.

| Config | Default | Description |
|-------|-------------------|-------------|
| `packages.namespace` | `""` | The namespace where to install the platform. |
| `packages.exclusions` | `[]` | A list of packages to exclude from being installed. |
| `cartographer.blueprints` | `{}` | Configuration for the Cartographer Blueprints package. |
| `cartographer.delivery` | `{}` | Configuration for the Cartographer Delivery package. |
| `cartographer.supply_chains` | `{}` | Configuration for the Cartographer Supply Chains package. |
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
    supply_chains: {}

  cert_manager: {}

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
    -v 0.5.1 \
    -n kadras-packages \
    --values-file values.yml
  ```

## Upgrading

You can upgrade an existing package to a newer version using `kctrl`.

  ```shell
  kctrl package installed update -i application-platform \
    -v <new-version> \
    -n kadras-packages
  ```

You can also update an existing package with a newer `values.yml` file.

  ```shell
  kctrl package installed update -i application-platform\
    -n kadras-packages \
    --values-file values.yml
  ```

## Other

The recommended way of installing the Kadras Application Platform package is via the [Kadras package repository](https://github.com/arktonix/kadras-packages). If you prefer not using the repository, you can install the package by creating the necessary Carvel `PackageMetadata` and `Package` resources directly using [`kapp`](https://carvel.dev/kapp/docs/latest/install) or `kubectl`.

  ```shell
  kubectl create namespace kadras-packages
  kapp deploy -a application-platform-package -n kadras-packages -y \
    -f https://github.com/arktonix/application-platform/releases/latest/download/metadata.yml \
    -f https://github.com/arktonix/application-platform/releases/latest/download/package.yml
  ```

## References

This package is inspired by:

* the App Toolkit package used in [Tanzu Community Edition](https://github.com/vmware-tanzu/community-edition) before its retirement;
* the [OSS Stack](https://github.com/vrabbi/tap-oss) example of [Tanzu Application Platform](https://tanzu.vmware.com/application-platform).

## Supply Chain Security

This project is compliant with level 3 of the [SLSA Framework](https://slsa.dev).

<img src="https://slsa.dev/images/SLSA-Badge-full-level3.svg" alt="The SLSA Level 3 badge" width=200>
