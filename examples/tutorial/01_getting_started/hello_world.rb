R.deployment :hello do # <-- Name of the deployment
  container do
    image 'tutum/hello-world' # <-- Image is mandatory
  end
end
