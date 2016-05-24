# Basic example showing how to convert input from a web form into data
# - user input needs validation because it will frequently be wrong
# - coercion needed because web forms only return string fields
require 'dry-validation'

StudentForm = Dry::Validation.Form do
  key(:name).required
  key(:age).required(:int?, gt?: 15, lt?: 150)
end

# Rack stores all HTTP body form data into params
params = { 'name' => 'Adam Smith', 'age' => '18' }

student = StudentForm.call(params)

student.messages
# => {"name"=>"Adam Smith", "age"=>13}

student.errors
# => [#<Dry::Validation::Error name=:age result=#<Dry::Logic::Result::Named success?=false input={:name=>"Adam Smith", :age=>13} rule=#<Dry::Logic::Rule::Key predicate=#<Dry::Logic::Predicate id=:gt? args=[15]> options={:evaluator=>#<Dry::Logic::Evaluator::Key path=[:age]>, :name=>:age}>>>]

student.success?
# => true

# student object can now be passed onto service or persisted
