# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# mymy = User.create(email: "mymy_ekpa@gmail.com", password:"1234567a", admin: true)
# mymy.admin = true
# mymy.save
Inscription.destroy_all
Formation.destroy_all
Theme.destroy_all

THEMES = %i(marketing digital programmation)

LIEUX = ["Remote", "A définir"]

DUREES = ["semaines", "heures"]

THEMES.each { |theme| Theme.create(sujet: theme) }

CERTIFIEES = [true, false]

puts "thèmes créés"

20.times do
  Formation.create(titre: Faker::Lorem.sentence(word_count: 3), prix: rand(100..1000), description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 30), theme: Theme.all.sample, lieu: LIEUX.sample, note: rand(5..10), duree: "#{rand(5..10)} #{DUREES.sample}", certifiee: CERTIFIEES.sample)
end

puts "formations créées"
