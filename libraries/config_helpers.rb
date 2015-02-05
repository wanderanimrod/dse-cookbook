require 'yaml'

def hash_to_yaml_string(hash)
  hash.to_hash.to_yaml
end
