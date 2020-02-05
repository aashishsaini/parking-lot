class Ticket < ApplicationRecord
  validates :barcode, presence: true, uniqueness: true
  after_initialize :generate_barcode, :if => :new_record?
  enum payment_option: [:credit_card, :debit_card, :cash]
  PARKING_CAPACITY = 54
  scope :free_spaces, -> { PARKING_CAPACITY - where("status = 'unpaid'").count }

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

  def exit_check
    if self.status == 'paid' && (((Time.now - self.payment_time)/15.minutes) > 1)
      self.created_at = payment_time
      self.status = 'unpaid'
      save
    end
  end

  def is_space_available?
    errors.add(:base, 'No Space left in parking lot') if self.class.free_spaces == 0
    self.class.free_spaces > 0
  end
end
