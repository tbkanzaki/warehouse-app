require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate_name  is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '4344726000102',
        full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end
      it 'false when brand_name  is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME Fac', brand_name: '', registration_number: '4344726000102',
        full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
