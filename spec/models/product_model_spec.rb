require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name  is empty' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                                    registration_number: '4344726000102',
                                    full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                    state: 'SP', email: 'contato@samsung.com')

        pm = ProductModel.new(name: '', weight: 10000, width: 600, height: 900, depth: 10, 
                            sku: 'TV32-SAMSU-XPTO', supplier: supplier ) 

        # Act
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end
      it 'false when sku  is empty' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                                    registration_number: '4344726000102',
                                    full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                    state: 'SP', email: 'contato@samsung.com')

        pm = ProductModel.new(name: 'TV 32', weight: 10000, width: 600, height: 900, depth: 10, 
                            sku: '', supplier: supplier ) 

        # Act
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
