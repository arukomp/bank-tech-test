require 'date'

class BankStatement

  def initialize
    @history = []
  end

  def history
    @history.dup
  end

  def add_record(type, amount, new_balance)
    new_entry = {
      date: Date.today,
      type: type,
      amount: amount,
      balance: new_balance
    }
    @history.unshift new_entry
  end
end
