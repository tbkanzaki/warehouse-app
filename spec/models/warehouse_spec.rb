require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
          warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
          address: 'Rua do Rio, 1000', cep: '6000-000', description: 'Galpão do Rio')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when code is empty' do
        # Arrange
          warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', area: 60_000,
          address: 'Rua do Rio, 1000', cep: '6000-000', description: 'Galpão do Rio')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: '', area: 60_000,
        address: 'Rua do Rio, 1000', cep: '6000-000', description: 'Galpão do Rio')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end
    
    it 'false when code is already in use' do
      # Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Rua do Rio, 1000', cep: '6000-000', description: 'Galpão do Rio')
 
      second_warehouse = Warehouse.new(name: 'Niteroi', code: 'SDU', city: 'Niteroi', area: 70_000,
      address: 'Rua de Niteroi, 4000', cep: '7000-000', description: 'Galpão de Niteroi')
 
      # Act
      result = second_warehouse.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
