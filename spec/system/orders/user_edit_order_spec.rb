require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    tereza = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')

    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    order = Order.create!(warehouse: warehouse, supplier: supplier, user: tereza, 
                  estimated_delivery_date: 1.day.from_now)
                  
    #Act
    visit edit_order_path(order.id)

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    #Arrange
    tereza = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')

    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                    registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', 
                    state: 'SP', email: 'contato@samsung.com')

    order = Order.create!(warehouse: warehouse, supplier: supplier, user: tereza, 
                          estimated_delivery_date: 1.day.from_now)
                  
    #Act
    login_as(tereza)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '25/07/2023'
    select 'Samsung Eletronic LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: Samsung Eletronic LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 25/07/2023'
  end

  it 'caso seja o responsável' do
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
    visit edit_order_path(order.id)

    #Assert
    expect(current_path).to eq root_path
  end
end
