require_relative 'bank_statement'

class BankAccount

  attr_reader :balance, :statement

  def initialize
    @balance = 0
    @statement = BankStatement.new
  end

  def deposit(amount)
    return false unless amount_valid?(amount)
    @balance += amount
    @statement.add_record(:credit, amount, @balance)
    true
  end

  def withdraw(amount)
    return false unless amount_valid?(amount)
    @balance -= amount
    @statement.add_record(:debit, amount, @balance)
    true
  end

  private

  def amount_valid?(amount)
    amount.is_a?(Numeric) && amount > 0
  end

end
