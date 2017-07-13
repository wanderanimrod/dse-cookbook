require 'yaml'

RSpec::Matchers.define :has_yaml_key do |expected|
  match do |actual|
    steps = expected.split('.')
    index = 0
    act_yaml = YAML.load(actual)
    found = true
    while found && index < steps.length
      next_step = steps[index]
      found = act_yaml.key? next_step
      act_yaml = act_yaml[next_step] if found
      index += 1
    end
    found
  end
end
