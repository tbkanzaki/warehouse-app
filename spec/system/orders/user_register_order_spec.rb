require 'rails_helper'

describe 'Usuario cadastra um pedido' do
  it 'e precisa se autenticar' do
    #Arrange

    #Act 
    visit root_path

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Tereza Barros', email:'tereza@provedor.com', password:'senha_nova')
    
    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                      address: 'Rua de Maceio, 1000', cep: '7000-000', 
                      description: 'Galpão de Maceio')

    Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                      registration_number: '4344726000102',
                      full_address: 'Av das Palmas, 100', city: 'Bauru', 
                      state: 'SP', email: 'contato@samsung.com')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC4567890')

    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2023'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Pedido cadastrado com sucesso'
    expect(page).to have_content "Pedido: ABC4567890"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Tereza Barros - tereza@provedor.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2023'
    expect(page).not_to have_content 'Maceio'
    expect(page).not_to have_content 'Samsung Eletronic LTDA'
  end

  it 'com dados incompletos' do
    #Arrange
    user = User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
    
    warehouse = Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                      address: 'Rua de Maceio, 1000', cep: '7000-000', 
                      description: 'Galpão de Maceio')

    Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                      registration_number: '4344726000102',
                      full_address: 'Av das Palmas, 100', city: 'Bauru', 
                      state: 'SP', email: 'contato@samsung.com')

    supplier =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@acme.com')

    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o pedido'
    expect(page).not_to have_content 'Pedido cadastrado com sucesso'
  end
end
