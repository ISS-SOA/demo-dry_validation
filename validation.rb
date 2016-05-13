require 'dry-validation'

AccountSchema = Dry::Validation.Schema do
  key(:name).required

  key(:email).required(format?: /@/)

  key(:age).maybe(:int?)

  key(:address).schema do
    key(:street).required
    key(:city).required
    key(:zipcode).required
  end
end

# Happy
params_happy = {
  name: 'Jane',
  email: 'jane@doe.org',
  age: 26,
  address: { street: 'Street 1', city: 'NYC', zipcode: '1234' }
}

AccountSchema.call(params_happy)

# Sad
AccountSchema.call(
  name: 'Jane',
  email: 'janedoe.org',
  address: { street: 'Street 1', city: 'NYC', zipcode: '1234' }
)

# Creating custom predicates and messages
FileSchema = Dry::Validation.Schema do
  key(:filename).required(:no_path?)

  key(:document).required(:str?)

  configure do
    config.messages_file = 'custom_errors.yml'

    def no_path?(value)
      !(value =~ %r{/})
    end
  end
end

# should trigger custom :no_path error and message
msgs = FileSchema.call(
  filename: 'path/file.txt',
  document: '---'
).messages

puts msgs
