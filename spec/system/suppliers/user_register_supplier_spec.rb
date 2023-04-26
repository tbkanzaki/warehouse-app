require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir do menu' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Novo Fornecedor'

    #Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Registro')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
  end

  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Novo Fornecedor'
    fill_in 'Nome', with: 'ACME LTDA'
    fill_in 'Marca', with: 'ACME'
    fill_in 'Registro', with: '4344726000102'
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
  end

  it 'com dados incompletos' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Novo Fornecedor'
    fill_in 'Nome', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Registro', with: ''
    fill_in 'Endereço', with: 'Av das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'contato@acme.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o fornecedor'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
  end
end
