require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do 
  it 'a partir da tela inicial' do
    #Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    #Act
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
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq root_path
  end
end
