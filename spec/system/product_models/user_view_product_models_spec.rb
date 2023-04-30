require 'rails_helper'

describe 'Usuário visita página de modelos de produtos' do
  it 'a partir do menu' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')
    
    #Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    
    #Assert
    expect(current_path).to eq product_models_path
  end

  it 'e vê os modelos de produtos cadastrados' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                                registration_number: '4344726000102',
                                full_address: 'Av das Palmas, 100', city: 'Bauru', 
                                state: 'SP', email: 'contato@samsung.com')

    ProductModel.create!(name: 'TV 32', weight: 10000, width: 600, height: 900, depth: 10, 
                          sku: 'TV32-SAMSU-XPTO', supplier: supplier )   

    ProductModel.create!(name: 'Airfryer', weight: 5000, width: 400, height: 600, depth: 50, 
                          sku: 'AIRF-SAMSU-XYZ', supplier: supplier ) 

    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produto' 

    #Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Airfryer'
    expect(page).to have_content 'AIRF-SAMSU-XYZ'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existe modelos de produtos cadastrados' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produto' 

    #Assert
    expect(page).to have_content 'Não existem modelos de produtos cadastrados'
  end
end
