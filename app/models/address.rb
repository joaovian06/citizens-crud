class Address < ApplicationRecord
  belongs_to :citizen

  validates :cep,
           :street,
           :district,
           :city,
           :uf,
           presence: true

  validates :citizen_id,
            presence: true,
            uniqueness: true

  validates :cep,
            format: {
              with: %r(\A(\d{5})([-])(\d{3})\z)
            },
            presence: true,
            correios_cep: true
end
