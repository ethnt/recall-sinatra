object @assignment
attributes :id, :text, :due, :complete, :render

node :due_in_words do |a|
  a.due_in_words
end

child :course do
  attributes :id, :name, :code
end

child :user do
  attributes :id, :email
end
