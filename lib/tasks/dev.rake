class DevTasks
  include Rake::DSL

  def initialize
    namespace :dev do
      task seed: :environment do
        puts 'Seeding users'
        seed_users
        puts 'Seeding tags'
        seed_tags
        puts 'Seeding custom designs'
        seed_custom_designs
        puts 'Seeding bookmarks'
        seed_bookmarks
        puts 'Seeding hearts'
        seed_hearts
      end
    end
  end

  private

  def seed_users
    200.times do
      user = User.create!(email: Faker::Internet.unique.safe_email, password: 'test123')
      code = Faker::Number.unique.number(digits: 12).to_s
      user.creator.update!(
        name: Faker::Internet.username(specifier: 3..10),
        creator_id: "MA-#{code[0..3]}-#{code[4..7]}-#{code[8..11]}"
      )
    end
  end

  def seed_tags
    100.times do
      Tag.create(name: Faker::Games::Pokemon.unique.name)
    end

    20.times do
      Tag.create(name: Faker::Games::SuperSmashBros.unique.fighter)
    end

    50.times do
      Tag.create(name: Faker::Games::Zelda.unique.character)
    end
  end

  def seed_custom_designs
    2000.times do
      creator = random_creator
      categories = random_categories(Faker::Number.between(from: 0, to: 5))
      tags = random_tags(Faker::Number.between(from: 0, to: 5))
      code = Faker::Number.unique.number(digits: 12).to_s
      image = File.new(Rails.root.join('lib/assets/img-placeholder.png'))

      CustomDesign.create!(
        name: Faker::Game.title[0..19],
        design_id: "MO-#{code[0..3]}-#{code[4..7]}-#{code[8..11]}",
        creator_id: creator.id,
        category_ids: categories.pluck(:id),
        tag_ids: tags.pluck(:id),
        main_picture_attributes: {
          image: image
        }
      )
    end
  end

  def seed_bookmarks
    Creator.all.each do |creator|
      custom_design_ids = random_custom_designs(Faker::Number.between(from: 0, to: 100)).pluck(:id)
      custom_design_ids.map { |id| creator.bookmarks.create!(custom_design_id: id) }
    end
  end

  def seed_hearts
    Creator.all.each do |creator|
      custom_design_ids = random_custom_designs(Faker::Number.between(from: 0, to: 300)).pluck(:id)
      custom_design_ids.map { |id| creator.hearts.create!(custom_design_id: id) }
    end
  end

  def random_creator
    Creator.order(Arel.sql('RANDOM()')).first
  end

  def random_custom_designs(count)
    CustomDesign.order(Arel.sql('RANDOM()')).first(count)
  end

  def random_categories(count)
    Category.order(Arel.sql('RANDOM()')).first(count)
  end

  def random_tags(count)
    Tag.order(Arel.sql('RANDOM()')).first(count)
  end
end

DevTasks.new
