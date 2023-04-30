require 'rails_helper'

describe 'Usuario se registra' do
  it 'com sucesso' do
    # Arrange
    
    # Act
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'João'
    fill_in 'E-mail', with: 'joao@provedor.com'
    fill_in 'Senha', with: 'senha_nova'
    fill_in 'Confirme sua senha', with: 'senha_nova'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'joao@provedor.com'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'João'
    end
  end
  