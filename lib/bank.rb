require 'bank_account'

class Bank

  attr_reader :account

  def initialize
    @account = BankAccount.new
  end

  def start
    puts 'Welcome to your bank account.'
    show_menu
  end

  def show_menu
    puts "1. Deposit"
    puts "2. Withdraw"
    puts "3. Print Statement"
    puts "9. Exit"
  end

  def print_balance
    puts "Account balance: £#{ @account.balance }"
  end

  def print_statement
    puts "date || credit || debit || balance"
    @account.statement.history.each do |entry|
      puts statement_entry_to_string(entry)
    end
  end

  private

  def statement_entry_to_string(entry)
    text = entry[:date].strftime('%d/%m/%Y') + " || "
    text += entry[:type] == :credit ? "%.2f" % entry[:amount] + " || " : "|| "
    text += entry[:type] == :debit ? "%.2f" % entry[:amount] + " || " : "|| "
    text += "%.2f" % entry[:balance]
  end

end
