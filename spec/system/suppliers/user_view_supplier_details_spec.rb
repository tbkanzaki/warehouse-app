require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do 
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    #Assert
    expect(page).to have_content('ACME LTDA')
    expect(page).to have_content('Registro: 4344726000102')
    expect(page).to have_content('Endereço: Av das Palmas, 100 - Bauru - SP')
    expect(page).to have_content('E-mail: contato@acme.com')
  end

  it 'e voltar para tela inicial' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq root_path
  end

  it 'e vê todos os seus modelos de produtos' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    supplier_samsung = Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                                        registration_number: '4344726000102',
                                        full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                        state: 'SP', email: 'contato@samsung.com')

    supplier_acme =  Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                      registration_number: '4344726000102',
                                      full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                      state: 'SP', email: 'contato@acme.com')

    ProductModel.create!(name: 'TV 32', weight: 10000, width: 600, height: 900, depth: 10, 
                        sku: 'TV32-SAMSU-XPTO', supplier: supplier_samsung )   

    ProductModel.create!(name: 'Airfryer', weight: 5000, width: 400, height: 600, depth: 50, 
                        sku: 'AIRF-ACME-XYZ', supplier: supplier_acme ) 

    ProductModel.create!(name: 'Microondas', weight: 5000, width: 400, height: 600, depth: 50, 
                        sku: 'MICRO-ACME-ABC', supplier: supplier_acme ) 

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    #Assert
    expect(page).not_to have_content('Samsung')
    expect(page).to have_content('Produtos do Fornecedor ACME')
    expect(page).to have_content('Airfryer')
    expect(page).to have_content('AIRF-ACME-XYZ')
    expect(page).to have_content('Microondas')
    expect(page).to have_content('MICRO-ACME-ABC')
  end
end
