require 'bank'

describe 'Bank App' do

  subject(:bank) { Bank.new }

  describe 'starting the banking app' do
    it 'should display a welcome message' do
      expect{ bank.start }.to output(/Welcome to your bank account./).to_stdout
    end
    it 'should call the show_menu method' do
      expect(bank).to receive(:show_menu).once
      bank.start
    end
    it 'should have a bank account associated with it' do
      expect(bank.account).to be_a BankAccount
    end
  end

  describe 'showing the menu' do
    it 'should display the menu' do
      menu_text = "1. Deposit\n" +
                  "2. Withdraw\n" +
                  "3. Print Statement\n" +
                  "9. Exit\n"
      expect{ bank.show_menu }.to output(menu_text).to_stdout
    end
  end

  describe 'print_balance' do
    it 'prints the balance' do
      allow(bank.account).to receive(:balance).and_return(1234)
      balance_text = /Account balance: £1234/
      expect{ bank.print_balance }.to output(balance_text).to_stdout
    end
  end

  describe 'print_statement' do

    let(:statement_history) { 
      [
        {date: Date.today, type: :debit, amount: 200, balance: 100},
        {date: Date.today.prev_day, type: :credit, amount: 300, balance: 300}
      ]
    }
    let(:statement) { double('statement', history: statement_history) }

    it 'prints the bank statement' do
      allow(bank.account).to receive(:statement).and_return statement
      statement_text = "date || credit || debit || balance\n" +
        Date.today.strftime('%d/%m/%Y') + " || || 200.00 || 100.00\n" +
        Date.today.prev_day.strftime('%d/%m/%Y') + " || 300.00 || || 300.00\n"
      expect{ bank.print_statement }.to output(statement_text).to_stdout
    end
  end

end
