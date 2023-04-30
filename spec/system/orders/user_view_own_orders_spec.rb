require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve se autenticar' do
    #Arrange
    
    #Act
    visit root_path
    within('nav') do
      click_on 'Meus Pedidos'
    end

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
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

    first_order = Order.create!(user: tereza, warehouse: warehouse, supplier: supplier,  
                  estimated_delivery_date: 1.day.from_now)

    second_order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier,  
                  estimated_delivery_date: 1.day.from_now)

    third_order = Order.create!(user: tereza, warehouse: warehouse, supplier: supplier, 
                  estimated_delivery_date: 1.week.from_now)

    #Act
    login_as(tereza)
    visit root_path
    click_on 'Meus Pedidos'

    #Assert
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end

  it 'e visita um pedidos - detalhes' do
    #Arrange
    tereza = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
        
    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    first_order = Order.create!(user: tereza, warehouse: warehouse, supplier: supplier,  
                                estimated_delivery_date: 1.day.from_now)

    #Act
    login_as(tereza)
    visit root_path
    click_on 'Meus Pedidos'
    click_on first_order.code

    #Assert
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content first_order.code
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do
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

    first_order = Order.create!(user: tereza, warehouse: warehouse, supplier: supplier,  
                                estimated_delivery_date: 1.day.from_now)

    #Act
    login_as(maria)
    visit order_path(first_order.id)

    #Assert
    expect(page).not_to eq order_path(first_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e não existem pedidos cadastrados' do
    #Arrange
    user = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')

    #Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Meus Pedidos'
    end

    #Assert
    expect(page).to have_content 'Não existem pedidos cadastrados'
  end
end
