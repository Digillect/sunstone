R.scope :hello do
  deployment do
    match_labels component: :hello

    container do
      image 'tutum/hello-world'

      expose_default_http_port
    end
  end

  service do
    match_labels component: :hello

    expose_default_http_port
  end

  ingress do
    add_rule V.host # <-- Using "host" value
  end
end
