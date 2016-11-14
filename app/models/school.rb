class School < ApplicationRecord
  has_many :users, dependent: :destroy

  before_save :downcase_email
  validates   :name, presence: true,
              length: { minimum: 3 }
  VALID_SCHOOL_REGEX = /\A([\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+)?\z/i
  validates :email, length: { maximum: 255 },
            format: { with: VALID_SCHOOL_REGEX }

  def name=(s)
    write_attribute(:name, s.to_s.strip.titleize)
  end

  def email=(s)
    write_attribute(:email, s.to_s.strip)
  end

  private

  def downcase_email
    if !email.nil?
      email.downcase!
    end
  end
end
