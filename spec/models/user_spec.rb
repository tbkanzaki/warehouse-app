require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#descrition' do
    it 'exibe o nome e o email' do
      # Arrange
      u = User.new(name: 'Júlia Almeida', email: 'julia@yahoo.com')

      # Act
      result = u.description()

      # Assert
      expect(result).to eq('Júlia Almeida - julia@yahoo.com')
    end
  end
end
