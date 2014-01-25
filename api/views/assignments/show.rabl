object @assignment
attributes :id, :text, :due, :complete

child :course do
  attributes :id, :name, :code
end

child :user do
  attributes :id, :email
end
