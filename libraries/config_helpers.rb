require 'yaml'

def hash_to_yaml_string(hash)
  return hash.to_hash.to_yaml
end
