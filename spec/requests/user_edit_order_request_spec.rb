require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    #Arrange
    tereza = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
    maria = User.create!(name: 'Maria', email:'maria@provedor.com', password:'senha_nova')

    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    order = Order.create!(warehouse: warehouse, supplier: supplier, user: maria, 
                  estimated_delivery_date: 1.day.from_now)
                  
    #Act
    login_as(tereza)
    patch(order_path(order.id), params: {order: {supplier_id: supplier.id}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end
