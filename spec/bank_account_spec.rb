require 'bank_account'

describe BankAccount do

  subject(:account) { BankAccount.new }

  describe 'initialization' do
    it 'starts with 0 balance' do
      expect(account.balance).to eq 0
    end
    it 'has a statement' do
      expect(account.statement).to be_a BankStatement
    end
  end

  describe 'deposit' do
    it 'can be made' do
      expect(account.deposit(500)).to eq true
    end
    it 'must take a number' do
      expect(account.deposit('asd')).to eq false
      expect(account.deposit([500])).to eq false
    end
    it 'takes only a positive amount of money' do
      expect{ account.deposit(-500) }.to_not change{ account.balance }
    end
    it 'increases the balance' do
      expect{ account.deposit(500) }.to change{ account.balance }.by(500)
    end
    it 'adds a statement record' do
      expect(account.statement).to receive(:add_record).with(:credit, 500, 500)
      account.deposit(500)
    end
  end

  describe 'withdrawal' do
    it 'can be made' do
      expect(account.withdraw(500)).to eq true
    end
    it 'must take a number' do
      expect(account.withdraw('asd')).to eq false
      expect(account.withdraw([500])).to eq false
    end
    it 'takes only a positive amount of money' do
      expect{ account.withdraw(-500) }.to_not change{ account.balance }
    end
    it 'decreases the balance' do
      expect{ account.withdraw(500) }.to change{ account.balance }.by(-500)
    end
    it 'adds a statement record' do
      expect(account.statement).to receive(:add_record).with(:debit, 500, -500)
      account.withdraw(500)
    end
  end

  it 'cannot change the balance deliberately' do
    balance = account.balance
    expect{ balance = 10000 }.to_not change{ account.balance }
  end

  it 'cannot manipulate the statement deliberately' do
    statement = account.statement
    expect{ statement = "something" }.to_not change{ account.statement }
  end

end
