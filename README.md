# Sunstone

[![Build Status](https://travis-ci.com/Digillect/sunstone.svg?branch=master)](https://travis-ci.com/Digillect/sunstone)

Ruby-style DSL preprocessor for Kubernetes resource manifests.

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
