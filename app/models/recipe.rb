require 'couchbase-orm'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

class Recipe < CouchbaseOrm::Base
  OPENAI = Rails.application.config.openai
  include Rails.application.routes.url_helpers
  attribute :image, :string
  attribute :recipe_titles, default: []
  attribute :date, :datetime, default: -> { Time.now }

  validates :image, presence: true, on: :update

  after_create :analyze_image_and_store_recipes
  def analyze_image_and_store_recipes
    uploader = ImageUploader.new
    uploader.retrieve_from_store!(image)

    image_path = uploader.path
    image_path = image_path.sub(Rails.root.to_s + '/public', '')

    messages = [
      { "type": "text", "text": "You are an assistant tasked with listing the items in a refrigerator. Only return items in a comma-separated list and nothing else. Do not include any other information or any other text."},
      { "type": "image_url",
        "image_url": {
          "url": "http://#{ENV.fetch('NGROK_URL')}#{image_path}",
        },
      }
    ]

    response = OPENAI.chat(
      parameters: {
        model: "gpt-4o",
        messages: [{ role: "user", content: messages}]
      }
    )

    items_in_fridge = response.dig("choices", 0, "message", "content")

    self.recipe_titles = fetch_recipes_from_openai(items_in_fridge)
    self.date = Time.current

    save!
  end

  private

  def fetch_recipes_from_openai(items_in_fridge)
    response = OPENAI.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "system", content: "You are an assistant tasked with listing recipes that can be made with the following items in the fridge: #{items_in_fridge}."},
          { role: "system", content: "List the recipes in a comma-separated list and nothing else. Do not include any other information or any other text." },
        ]
      }
    )

    response.dig("choices", 0, "message", "content").split(',').map(&:strip)
  end
end
