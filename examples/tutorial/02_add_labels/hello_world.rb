R.deployment :hello do
  match_labels component: :hello # <-- Will add component label to Pod Template and, therefore, deployment pods

  container do
    image 'tutum/hello-world'
  end
end
