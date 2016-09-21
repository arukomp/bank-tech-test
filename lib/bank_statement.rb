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

  def to_s
    elements = ["date || credit || debit || balance"]
    history.each do |entry|
      elements.push statement_entry_to_string(entry)
    end
    elements.join("\n")
  end

  private

  def statement_entry_to_string(entry)
    text = entry[:date].strftime('%d/%m/%Y') + " || "
    text += entry[:type] == :credit ? "%.2f" % entry[:amount] + " || " : "|| "
    text += entry[:type] == :debit ? "%.2f" % entry[:amount] + " || " : "|| "
    text += "%.2f" % entry[:balance]
  end

end
