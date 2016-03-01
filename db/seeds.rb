# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group_detail = GroupDetail.create(id: 13, name: "Testing", start_date: Time.now, end_date: Time.now
+ 10.days, email: "testing@example.com", user_id: "testing123", secret_key: "secret123",
authorized_urls: ["localhost:6379"])
