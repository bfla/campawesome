FactoryGirl.define do
  

  factory :campsite do
    name        "Majestic Campground"
    org         "Federal"
    res_phone   8002345678
    camp_phone  8001231234
    res_url     "http://whatever.com"
    camp_url    "http://whocares.com"
    reservable  true
    walkin      true
    latitude    44.9131
    longitude   -83.9131
    address     "12345 Main Street, Ann Arbor, MI 48104"
    state
    city
    vibe
    avg_rating  4.67
    city_rank   2
    rv_length   36
    sequence(:slug) { |n| "majestic campground #{n}" }
  end

  factory :state do
    name        "Utopia"
    abbreviation "UT"
    hashtag     "FuckYeah"
    description "This state is da shit"
    latitude    44.9131
    longitude   -83.9131
    zoom        6
    sequence(:slug) { |n| "calming state #{n}" }
  end

  factory :city do
    name        "El Dorado"
    description "This city is rollin in it"
    latitude    44.9131
    longitude   -83.9131
    zoom        6
    sequence(:slug) { |n| "serene city #{n}" }
  end

  factory :tribe do
    name        "Justice League"
    description "Heroic tribe"
    vibe       "Heroic"
    association :vibe, factory: :vibe
  end

  factory :vibe do
    campsite
    tribe
  end

end