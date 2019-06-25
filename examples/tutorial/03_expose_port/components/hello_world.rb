R.deployment :hello do
  match_labels component: :hello

  container do
    image 'tutum/hello-world'

    expose_default_http_port # <-- Expose container's TCP port 80 with name "http". Good old classic!
  end
end
