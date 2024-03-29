# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

christmas_vest = GayApparel.find_or_create_by(name: 'Christmas Vest')

SEEDED_MODELS = [
  :users,
  :donnings
].freeze

SEEDED_MODELS.each do |model_name|
  csv_text = File.read(Rails.root.join('db', 'seeds', "#{model_name}.csv"))
  csv_data = CSV.parse(csv_text, :headers => true)

  csv_data.each do |row|
    case model_name
    when :users
      member = Member.find_or_initialize_by(name_first: row['name_first'], name_last: row['name_last'])
      member.name_middle = row['name_middle']
      member.birthdate = row['birthdate']
      member.is_approved = true
      member.save

      if row['user_email'].present? && row['user_password'].present?
        user = User.new
        user.member = member
        user.email = row['user_email']
        user.password = row['user_password']
        user.is_admin = row['user_is_admin'] == 'TRUE'
        user.save
      end
    when :donnings
      year = Year.find_or_create_by(num: row['year_num'])
      member = Member.find_or_create_by(name_first: row['member_name_first'], name_last: row['member_name_last'])
      location = Location.find_or_create_by(name: row['location_name'])
      Donning.find_or_create_by(member: member, year: year, location: location, gay_apparel: christmas_vest)
    else
      raise 'Unknown Model!'
    end
  end
end