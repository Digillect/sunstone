R.scope :hello do
  deployment do
    match_labels component: :hello

    container do
      image 'tutum/hello-world'

      expose_default_http_port

      liveness_probe do
        use_http '/'

        initial_delay 10
        period 20
      end
    end
  end

  service do
    match_labels component: :hello

    expose_default_http_port
  end

  ingress do
    add_service_rule V.host # <-- Using "host" value
  end
end
