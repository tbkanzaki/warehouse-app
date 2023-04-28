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

    it 'false when sku is already in use' do
      # Arrange
      supplier_acme =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                                        full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', 
                                        email: 'contato@acme.com')

      product_01 = ProductModel.create!(name: 'Microondas 32L', weight: 5000, width: 400, height: 600, 
                                        depth: 50, sku: 'MICRO-ACME-ABC', supplier: supplier_acme )

      product_02 = ProductModel.new(name: 'Microondas 26L', weight: 4000, width: 300, height: 500, 
                                    depth: 40, sku: 'MICRO-ACME-ABC', supplier: supplier_acme )

      # Act
      result = product_02.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
