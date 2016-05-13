require 'dry-validation'

StudentForm = Dry::Validation.Form do
  key(:name).required
  key(:age).required(:int?, gt?: 15, lt?: 150)
end

params = { 'name' => 'Adam Smith', 'age' => '18' }

student = StudentForm.call(params)

student.messages
# => {"name"=>"Adam Smith", "age"=>13}

student.errors
# => [#<Dry::Validation::Error name=:age result=#<Dry::Logic::Result::Named success?=false input={:name=>"Adam Smith", :age=>13} rule=#<Dry::Logic::Rule::Key predicate=#<Dry::Logic::Predicate id=:gt? args=[15]> options={:evaluator=>#<Dry::Logic::Evaluator::Key path=[:age]>, :name=>:age}>>>]
