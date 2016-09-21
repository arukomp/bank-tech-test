require 'bank'

describe 'Bank App' do

  subject(:bank) { BankApp.new }

  describe 'starting the banking app' do

    before do
      allow(bank).to receive(:program_loop).and_return(true)
    end

    it 'should display a welcome message' do
      expect{ bank.start }.to output(/Welcome to your bank account./).to_stdout
    end
    it 'should call the program_loop method' do
      expect(bank).to receive(:program_loop).once
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
      balance_text = "Account balance: £1234\n"
      expect{ bank.print_balance }.to output(balance_text).to_stdout
    end
  end

  describe 'print_statement' do
    it 'prints the statement' do
      statement_text = "date || credit || debit || balance\n"
      expect{ bank.print_statement }.to output(statement_text).to_stdout
    end
  end

end
