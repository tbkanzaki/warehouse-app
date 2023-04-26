require 'rails_helper'

describe 'Usuário visita página de fornecedores' do
  it 'a partir do menu' do
    #Arrange

    #Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    
    #Assert
    expect(current_path).to eq suppliers_path
  end

  it 'e vê os fornecedores cadastrados' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '43447260001-01',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com.br')
    
    Supplier.create!(corporate_name: 'Spark Industries LTDA', brand_name: 'Spark', registration_number: '34447260001-01',
                    full_address: 'Torre da Industria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')

    # Act
    visit(root_path) 
    click_on 'Fornecedores'

    # Assert
    expect(page).not_to have_content('Não existem fornecedores cadastrados')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru - SP')
    expect(page).to have_content('Spark')
    expect(page).to have_content('Teresina - PI')   
  end

  it 'e não existem fornecedores cadastrados' do
    # Arrange
    
    # Act
    visit(root_path) 
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Não existem fornecedores cadastrados')
  end
end
