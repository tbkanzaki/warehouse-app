require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da tela de detalhes' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    #Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome Fantasia', with:'ACME LTDA')
    expect(page).to have_field('Razão Social', with:'ACME')
    expect(page).to have_field('CNPJ', with:'4344726000102')
    expect(page).to have_field('Endereço', with:'Av das Palmas, 100')
    expect(page).to have_field('Cidade', with:'Bauru')
    expect(page).to have_field('Estado', with:'SP')
    expect(page).to have_field('E-mail', with:'contato@acme.com')
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    #Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Endereço', with: 'Av Bauru, 500'
    fill_in 'E-mail', with: 'fale_conosco@acme.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Fornecedor alterado com sucesso'
    expect(page).to have_content 'Endereço: Av Bauru, 500'
    expect(page).to have_content 'E-mail: fale_conosco@acme.com'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '4344726000102',
                    full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Endereço', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Não foi possível alterar o fornecedor'
  end
end
