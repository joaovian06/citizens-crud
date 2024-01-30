class Citizen < ApplicationRecord
    mount_uploader :avatar, AvatarUploader
    NOT_FORMATTED_PHONE_REGEX = %r(\A(\d{2})(\d{2})(\d{4,5})(\d{4})\z)

    has_one :address

    accepts_nested_attributes_for :address
    
    before_save :format_cpf
    before_validation :format_phone

    validates :birthdate,
              :status,
              :phone_number,
              presence: true

    validate :birthdate_allowed_range

    validates :full_name,
              presence: true,
              uniqueness: true

    validate :valid_cpf?
    validates :cpf,
              presence: true,
              uniqueness: { case_sensitive: false }

    validates :cns,
              presence: true,
              length: { is: 15 },
              format: { 
                with: %r(\A[0-9]{3}[0-9]{4}[0-9]{4}[0-9]{4}),
                message: I18n.t(".unformatted")
              },
              uniqueness: true

    validates :email,
              presence: true,
              format: {
                with: URI::MailTo::EMAIL_REGEXP
              },
              uniqueness: true

    enum status: {
      active: 0,
      inactive: 1
    }
    
    private

      def valid_cpf?
        if BRDocuments::CPF.invalid?(cpf)
          errors.add(:cpf, I18n.t('.invalid'))
        end
      end

      def format_cpf
        formatted_cpf = BRDocuments::CPF.pretty(cpf)

        self.cpf = formatted_cpf
      end

      def format_phone
        if phone_number && phone_number.match?(NOT_FORMATTED_PHONE_REGEX)
          replace_string = '+\1 \2 \3-\4'
          formatted_phone = self.phone_number.gsub(NOT_FORMATTED_PHONE_REGEX, replace_string)

          self.phone_number = formatted_phone
        end
      end

      def birthdate_allowed_range
        if birthdate && birthdate > Date.today
          errors.add(:birthdate, I18n.t('.not_greater'))
        elsif birthdate && birthdate <= Date.parse("22nd, Apr 1500")
          errors.add(:birthdate, I18n.t('.not_less'))
        end
      end
end
