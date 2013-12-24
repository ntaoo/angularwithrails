json.key_format! :camelize => :lower

json.articles @articles do |article|
  json.(article, :id, :title, :body)
end
