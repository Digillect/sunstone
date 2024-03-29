# Sunstone

[![ci](https://github.com/Digillect/sunstone/actions/workflows/ci.yml/badge.svg)](https://github.com/Digillect/sunstone/actions/workflows/ci.yml)

Declarative language for Kubernetes resource manifests and Helm charts.

## Why

Writing simple Kubernetes manifests is simple. Writing simple Helm charts is also simple. The moment
you find out that you are writing the same YAML with slight modifications for your twenty third microservice
you understand that you need more power Helm's Go templates can provide - enters Sunstone.

Sunstone is the addition to the Helm templates that do not allow you to create "real" macros or functions
and where you have to write the same code with the different arguments over and over again and then, when refactoring,
you have to be very careful and not to forget to change all affected files. Sunstone saves the time and increases
manageability of the Kubernetes resource manifests by providing ability to setup common parameters for resource types,
write macros that, when applied to resource, change several values at once and by organizing resources with
scoping under the same name. Here is the example resource declaration that creates Hello World web server:

```ruby
R.deployment 'hello' do
  container do
    image 'tutum/hello-world'
  end
end
```

And here is the full chain of deployment, service and ingress that exposes that server to the world:

```ruby
R.scope 'hello' do
  deployment do
    match_labels component: 'hello'

    container do
      image 'tutum/hello-world'

      expose_default_http_port
    end
  end

  service do
    match_labels component: 'hello'

    expose_default_http_port
  end

  ingress do
    add_service_rule 'hello.example.org'
  end
end
```

Just like [Ksonnet](https://ksonnet.io), which is unfortunately discontinued, Sunstone is the tool to make
deployment to Kubernetes fast, easy and manageable.

More examples can be found in the [Tutorial](examples/tutorial), documentation and API Reference
is in [Wiki](https://github.com/Digillect/sunstone/wiki).

## Installation

On MacOS Sunstone can be installed using Homebrew. First you'll need to install Digillect tap (if not already installed),
and then Sunstone:

```bash
$ brew tap digillect/core
...
$ brew install sunstone
``` 

That will install latest stable version of Sunstone. If you wish to play with the bleeding edge version use `--HEAD` flag to brew:

```bash
$ brew install --HEAD sunstone
```

## Use Docker image

Docker image contains bundled sunstone that runs in `/data` directory, so it is
simple to map your files and pickup results. This image is also a base for the
[Sunstone/Helm/Kubectl image](https://github.com/Digillect/sunstone-helm-kubectl) that
is suitable to use in your CI/CD pipelines.

```bash
docker run -i --rm -v `PWD`:/data digillect/sunstone sunstone [flags]
```

## Usage

Run `sunstone` to convert a directory with resource definitions into Kubernetes
manifests.

`sunstone examples/tutorial/01_getting_started`

Convert content of `examples/tutorial/01_getting_started` directory and output it to the
standard output as a YAML stream.

`sunstone -o out.yaml examples/tutorial/01_getting_started`

Convert input directory and output resources to the single YAML file `out.yaml`

Run `sunstone --help` for the full list of options.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/digillect/sunstone.

## License

Sunstone is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
