# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Article.create(title: 'sample1', body: 'sample article1')
Article.create(title: 'sample2', body: 'sample article2')
Article.create(title: 'sample3', body: 'sample article3')

user = User.new do |user|
  user.username = 'ntaoo'
  user.password = 'aoeuidht'
  user.email = 'ntaoo.g+github@gmail.com'
end
user.save!
