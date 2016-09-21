require 'bank_statement'

class BankAccount

  attr_reader :balance, :statement

  def initialize
    @balance = 0
    @statement = BankStatement.new
  end

  def deposit(amount)
    return false unless amount.is_a?(Numeric) && amount > 0
    @balance += amount
    @statement.add_record(:credit, amount, @balance)
    true
  end

  def withdraw(amount)
    return false unless amount.is_a?(Numeric) && amount > 0
    @balance -= amount
    @statement.add_record(:debit, amount, @balance)
    true
  end

end
