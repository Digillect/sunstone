R.deployment :hello do
  match_labels component: :hello

  container do
    image 'tutum/hello-world'

    expose_default_http_port
  end
end

R.service :hello do
  match_labels component: :hello # <-- Match Pods with the component label set to "hello"

  expose_default_http_port # <-- And expose their HTTP ports
end
