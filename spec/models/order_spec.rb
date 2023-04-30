require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'true (errors.include) when estimated_delivery_date is empty' do
      # Arrange
      order = Order.new(estimated_delivery_date: '')

      # Act
      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      # Assert
      expect(result).to be true
    end

    it 'a estimated_delivery_date não deve ser uma data no passado' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.ago)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser maior que a data de hoje.")
    end

    it 'a estimated_delivery_date não deve ser a data de hoje' do
      # Arrange
      order = Order.new(estimated_delivery_date: Date.today)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(" deve ser maior que a data de hoje.")
    end

    it 'a estimated_delivery_date deve ser igual ou maior que a data de hoje' do
      # Arrange
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      # Act
      order.valid?

      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end

  end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
  
      warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                        description: 'Galpão destinado para cargas internacionais')
    
      supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                  registration_number: '4344726000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                  state: 'SP', email: 'contato@acme.com')

      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, 
                      estimated_delivery_date: '2023-10-01')

      # Act
      order.save!
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e o código é único' do
      # Arrange
      user = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
  
      warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                        description: 'Galpão destinado para cargas internacionais')
    
      supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                  registration_number: '4344726000102',
                                  full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                  state: 'SP', email: 'contato@acme.com')

      first_order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, 
                      estimated_delivery_date: '2023-10-01')

      second_order = Order.new(warehouse: warehouse, supplier: supplier, user: user, 
                      estimated_delivery_date: '2023-11-01')

      # Act
      second_order.save!
      result = second_order.code

      # Assert
      expect(result.length).not_to eq first_order.code
    end
  end
  
end
