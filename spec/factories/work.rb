FactoryGirl.define do

  factory :work do
    sequence(:thumb) { |n| "thumb_#{n}.jpg" }

    trait :canon_d80 do
      make "Canon"
      model "D80"
    end

    trait :canon_snappy do
      make "Canon"
      model "Snappy"
    end

    trait :nikon_d80 do
      make "Nikon"
      model "D80"
    end

  end

end
