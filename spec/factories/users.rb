FactoryGirl.define do
  factory :user do
    email     'user@example.com'
    password  'passw0rd'
    name      'user'
  end

  factory :admin_user, :parent => :user do
    role       'admin'
  end

end
