FactoryBot.define do
  factory :message_to_bob, class: Message do
    content { "Hello Bob!" }
  end
end
