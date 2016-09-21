require 'bank_statement'

describe BankStatement do

  subject(:statement) { BankStatement.new }

  describe 'initialized bank statement' do
    it 'has an empty statement history' do
      expect(statement.history).to eq []
    end
  end

  describe 'add_record' do

    let(:record_sample) {
      {
        date: Date.today,
        type: :credit,
        amount: 500,
        balance: 500
      }
    }

    it 'adds a deposit record to the statement history' do
      statement.add_record(:credit, 500, 500)
      expect(statement.history).to include record_sample
    end

    it 'adds a withdrawal record to the statement history' do
      statement.add_record(:debit, 500, -500)
      expect(statement.history).to_not include record_sample
      expect(statement.history[0][:type]).to eq :debit
    end

    it 'adds the record in the front of the history (desc order)' do
      statement.add_record(:debit, 1000, 0)
      statement.add_record(:credit, 500, 500)
      expect(statement.history[0]).to eq record_sample
    end
  end

  describe '#to_s' do

    let(:statement_history) {
      [
        {date: Date.today, type: :debit, amount: 200, balance: 100},
        {date: Date.today.prev_day, type: :credit, amount: 300, balance: 300}
      ]
    }

    it 'returns the correct formatted string for the statement' do
      allow(statement).to receive(:history).and_return(statement_history)
      statement_text = "date || credit || debit || balance\n" +
        Date.today.strftime('%d/%m/%Y') + " || || 200.00 || 100.00\n" +
        Date.today.prev_day.strftime('%d/%m/%Y') + " || 300.00 || || 300.00"
      expect(statement.to_s).to eq statement_text
    end

    it 'returns the header if the history is empty' do
      allow(statement).to receive(:history).and_return([])
      statement_text = "date || credit || debit || balance"
      expect(statement.to_s).to eq statement_text
    end
  end

  it 'does not allow changing history' do
    history = statement.history
    expect{ history.push('asd') }.to_not change{ statement.history }
  end

end
