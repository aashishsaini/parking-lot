class Ticket < ApplicationRecord
  validates :barcode, presence: true, uniqueness: true
  after_initialize :generate_barcode, :if => :new_record?
  enum payment_option: [:credit_card, :debit_card, :cash]

  def generate_barcode
    unless self.valid?
      assign_barcode
    end
    self.valid? ? true : generate_barcode
  end

  def assign_barcode
    self.barcode = SecureRandom.hex(8)
  end

  def calc_ticket_price
    return "€0" if status == 'paid'
    parked_time = ((Time.now - self.created_at)/1.hour).round
    (parked_time += 1) if parked_time == 0
    "€#{parked_time*2}"
  end
end
