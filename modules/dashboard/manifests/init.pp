class dashboard {

  # Hack to fix issue with both puppet modules wanting to add the sensu apt repo
  Package['sensu'] -> Package['uchiwa']

}
