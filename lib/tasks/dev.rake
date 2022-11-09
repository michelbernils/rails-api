namespace :dev do
  desc "Setup development environment"
  task setup: :environment do

    %x(rails db:drop db:create db:migrate)

      p "Creating contact types"
      kinds = %w(Friend College Enemy)

      kinds.each do |kind|
        Kind.create!(
          description: kind
        )
      end

    p "Finished creating contact types"

    p "Creating contact"

    100.times do |i| 
        Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
        )
    end

    p "Contacts creation finished"

    p "Phone number creating"

    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        contact.phones.create!(number: Faker::PhoneNumber.cell_phone)
        contact.save!
      end
    end

    p "Phone number finished"

    p "Creating address"

    Contact.all.each do |contact|
      # contact.address.create!(street: Faker::Address.street_address, city: Faker::Address.city)
      Address.create!(street: Faker::Address.street_address, city: Faker::Address.city, contact: contact)
    end

    p "Finished Address"

  end
end
