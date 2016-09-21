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
    loop do
      print_balance
      show_menu
      selection = gets.chomp
      case selection
      when "1"
        select_action(:deposit)
      when "2"
        select_action(:withdraw)
      when "3"
        print_statement
      when "9"
        puts 'See you later!'
        break
      else
        puts 'Invalid selection'
      end
    end
  end

  def show_menu
    puts "1. Deposit"
    puts "2. Withdraw"
    puts "3. Print Statement"
    puts "9. Exit"
  end

  def select_action(action)
    loop do
      print "Enter the amount to #{ action.to_s }: "
      amount = gets.chomp.to_i
      success = @account.deposit(amount) if action == :deposit
      success = @account.withdraw(amount) if action == :withdraw
      break if success
    end
  end

  def print_balance
    puts "Account balance: £#{ @account.balance }"
  end

  def print_statement
    puts @account.statement.to_s
  end

end
