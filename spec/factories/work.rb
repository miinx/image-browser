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

    trait :make_without_model do
      make "Make Without Model"
    end

    trait :model_without_make do
      model "Model Without Make"
    end
  end

end
