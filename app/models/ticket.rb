class Ticket < ApplicationRecord
  validates :barcode, presence: true, uniqueness: true
  after_initialize :generate_barcode, :if => :new_record?

  def generate_barcode
    unless self.valid?
      assign_barcode
    end
    self.valid? ? true : generate_barcode
  end

  def assign_barcode
    self.barcode = SecureRandom.hex(8)
  end
end
