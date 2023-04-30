require 'rails_helper'

describe 'Usuário busca por um pedidos' do
  it 'e deve estar autenticada' do
    #Arrange

    #Act
    visit root_path

    #Assert
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'a partir do menu' do
    #Arrange
    user = User.create!(name:'Tereza', email:'tereza@provedor.com', password:'senha_nova')

    #Act
    login_as(user)
    visit root_path

    #Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
    #Arrange
    user = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
    
    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, 
                  estimated_delivery_date: 1.day.from_now)

    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "#{order.code}"
    expect(page).to have_content "1 pedido encontrado"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content ''
  end

  it 'e encontra vários pedidos' do
    #Arrange
    user = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
    
    first_warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    second_warehouse = Warehouse.create!(name:'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 100_000,
                      address: 'Avenida do Rio, 1000', cep: '65000-000',
                      description: 'Galpão destinado para cargas internacionais')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU0987654')
    first_order = Order.create!(warehouse: first_warehouse, supplier: supplier, user: user, 
                  estimated_delivery_date: 1.day.from_now)
                  
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU6758493')
    second_order = Order.create!(warehouse: first_warehouse, supplier: supplier, user: user, 
                  estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU4567890')
    third_order = Order.create!(warehouse: second_warehouse, supplier: supplier, user: user, 
                  estimated_delivery_date: 1.day.from_now)

    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content 'GRU0987654'
    expect(page).to have_content 'GRU6758493'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content "2 pedidos encontrados"
    expect(page).not_to have_content 'SDU4567890'
    expect(page).not_to have_content 'Galpão Destino: SDU - Aeroporto Rio'
  end
end
