require 'dry-validation'

UserSchema = Dry::Validation.Schema do
  key(:name).required

  key(:email).required(format?: /@/)

  key(:age).maybe(:int?)

  key(:address).schema do
    key(:street).required
    key(:city).required
    key(:zipcode).required
  end
end

UserSchema.call(
  name: 'Jane',
  email: 'janedoe.org',
  address: { street: 'Street 1', city: 'NYC', zipcode: '1234' }
)

require 'dry-validation'

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

FileSchema.call(
  filename: 'path/file.txt',
  document: '---'
).messages

test = FileSchema.(
  filename: 'config.ini',
  document: '---'
).messages
