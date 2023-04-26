require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                    registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', 
                    state: 'SP', email: 'contato@samsung.com')

    other_supplier = Supplier.create!(corporate_name: 'LG Eletronic LTDA', brand_name: 'LG', 
                    registration_number: '6344726000102',
                    full_address: 'Av das Rios, 100', city: 'Rio de Janeiro', 
                    state: 'RJ', email: 'contato@lg.com')

    #Act
    visit root_path
    click_on 'Modelos de Produto'
    click_on 'Novo Modelo de Produto'
    fill_in 'Nome', with: 'TV 32'
    fill_in 'Peso', with: 10000
    fill_in 'Altura', with: 600
    fill_in 'Largura', with: 900
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO'
    expect(page).to have_content 'Samsung'
  end

  it 'com dados incompletos' do
    #Arrange
    Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                    registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', 
                    state: 'SP', email: 'contato@samsung.com')

    #Act
    visit root_path
    click_on 'Modelos de Produto'
    click_on 'Novo Modelo de Produto'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
  end
end
