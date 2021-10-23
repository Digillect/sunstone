R.deployment :hello do
  match_labels component: :hello

  container do
    image 'tutum/hello-world'

    expose_default_http_port
  end
end

R.service :hello do
  match_labels component: :hello

  expose_default_http_port
end

R.ingress :hello do
  add_service_rule 'hello.example.org', :hello # <-- Expose service "hello" as a host with name hello.example.org
end
