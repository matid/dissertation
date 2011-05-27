Dir[Dissertation.root + "common" + "initializers" + "*.rb"].each do |initializer|
  require initializer
end