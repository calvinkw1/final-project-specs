# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  first_name: "Nick",
  last_name: "Marazzo",
  email: "designmarz@gmail.com",
  password: "password",
  phone_num: "4088075583"
  )
User.create(
  first_name: "Calvin",
  last_name: "Wang",
  email: "calvinkw1@gmail.com",
  password: "password",
  phone_num: "6503888988"
  )

 # 2   Sale Price: USD211.10
           # VX 936 SFO 2015-03-31T16:10-07:00 LAX 2015-03-31T17:30-07:00

 # 3   Sale Price: USD211.10
           # VX 948 SFO 2015-03-31T20:55-07:00 LAX 2015-03-31T22:15-07:00

 # 4   Sale Price: USD211.10
           # VX 928 SFO 2015-03-31T13:25-07:00 LAX 2015-03-31T14:45-07:00

 # 5   Sale Price: USD211.10
           # VX 932 SFO 2015-03-31T15:30-07:00 LAX 2015-03-31T16:50-07:00

 # 6   Sale Price: USD211.10
           # VX 922 SFO 2015-03-31T06:45-07:00 LAX 2015-03-31T08:00-07:00

 # 7   Sale Price: USD211.10
           # VX 938 SFO 2015-03-31T17:50-07:00 LAX 2015-03-31T19:10-07:00

 # 8   Sale Price: USD211.10
           # VX 330 SFO 2015-03-31T11:10-07:00 LAX 2015-03-31T12:30-07:00

 # 9   Sale Price: USD211.10
           # VX 334 SFO 2015-03-31T08:00-07:00 LAX 2015-03-31T09:20-07:00

# 10   Sale Price: USD213.10
# UA 653 SFO 2015-03-31T11:00-07:00 LAX 2015-03-31T12:30-07:00

# 11   Sale Price: USD213.10
# UA 706 SFO 2015-03-31T15:20-07:00 LAX 2015-03-31T16:48-07:00

# 12   Sale Price: USD213.10
# UA1070 SFO 2015-03-31T12:14-07:00 LAX 2015-03-31T13:48-07:00

# 13   Sale Price: USD213.10
# UA1278 SFO 2015-03-31T22:34-07:00 LAX 2015-03-31T23:59-07:00

# 14   Sale Price: USD213.10
# UA 479 SFO 2015-03-31T08:56-07:00 LAX 2015-03-31T10:30-07:00

# 15   Sale Price: USD213.10
# UA1560 SFO 2015-03-31T17:58-07:00 LAX 2015-03-31T19:30-07:00

# 16   Sale Price: USD213.10
# UA1120 SFO 2015-03-31T17:22-07:00 LAX 2015-03-31T18:54-07:00

# 17   Sale Price: USD213.10
# UA1234 SFO 2015-03-31T14:51-07:00 LAX 2015-03-31T16:20-07:00

# 18   Sale Price: USD213.10
# UA1169 SFO 2015-03-31T19:00-07:00 LAX 2015-03-31T20:33-07:00

# 19   Sale Price: USD213.10
# UA1232 SFO 2015-03-31T13:36-07:00 LAX 2015-03-31T15:10-07:00

# 20   Sale Price: USD213.10
# UA1089 SFO 2015-03-31T20:51-07:00 LAX 2015-03-31T22:20-07:00


 # 1   Sale Price: USD211.10
# VX 942 SFO 2015-03-31T18:45-07:00 LAX 2015-03-31T20:05-07:00


Alert.create(
  uid: "1",
  max_price: "1000",
  date_outbound: "2015-03-31",
  date_inbound: "2015-03-31",
  origin: "SFO",
  destination: "LAX",
  round_tri: true,
  adults: "1",
  children: "0",
  cabin_type: "COACH",
  airline: "VX",
  stops: "0",
  outbound_time: "18:45-07:00",
  inbound_time: "20:05-07:00"
  )