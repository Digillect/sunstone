R.scope :hello do # <-- Scope name is used as a default for resource names (and more) if omitted
  deployment do # <-- Name is omitted, so "hello" will be used
    match_labels component: :hello

    container do
      image 'tutum/hello-world'

      expose_default_http_port
    end
  end

  service do # <-- Name is omitted, so "hello" will be used
    match_labels component: :hello

    expose_default_http_port
  end

  ingress do # <-- Name is omitted, so "hello" will be used
    add_rule 'hello.example.org' # <-- Service name is omitted, will use Ingress' name (which is hello, by coincidence)
  end
end
