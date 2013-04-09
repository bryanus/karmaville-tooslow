FactoryGirl.define do
  sequence(:email)    { |i| "email_#{i}@example.com" }
  sequence(:username) { |i| "user_#{i}" }

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    username
    email
    # uwk = UserWithKarma(:points => 1, :total => 10)
    factory :user_with_karma do
      ignore do
        points 1
        total  10
      end

      after :create do |user, evaluator|
        points    = evaluator.points
        value_per = evaluator.total/evaluator.points
        puts "*" * 30
        puts points
        puts "*" * 30
        p create_list(:karma_point, points, :user => user, :value => value_per)
      end
    end
  end

  factory :karma_point do
    user
    value 0
    label { Faker::Lorem.word }
  end
end
