require_relative 'bank_account'

class BankApp

  attr_reader :account

  def initialize
    @account = BankAccount.new
  end

  def start
    puts 'Welcome to your bank account.'
    program_loop
  end

  def program_loop
    exit = false
    loop do
      print_balance
      show_menu
      selection = gets.chomp
      case selection
      when "1"
        select_deposit
      when "2"
        select_withdraw
      when "3"
        print_statement
      when "9"
        puts 'See you later!'
        exit = true
      else
        puts 'Invalid selection'
      end
      break if exit
    end
  end

  def show_menu
    puts "1. Deposit"
    puts "2. Withdraw"
    puts "3. Print Statement"
    puts "9. Exit"
  end

  def select_deposit
    loop do
      print "Enter the amount to deposit: "
      amount = gets.chomp.to_i
      success = @account.deposit(amount)
      break if success
    end
  end

  def select_withdraw
    loop do
      print "Enter the amount to withdraw: "
      amount = gets.chomp.to_i
      success = @account.withdraw(amount)
      break if success
    end
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
