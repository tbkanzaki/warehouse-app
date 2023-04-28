require 'rails_helper'

describe 'Usuario se autentica' do
  it 'com sucesso' do
    # Arrange
    User.create!(email:'tereza@provedor.com', password:'senha_nova')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'tereza@provedor.com'
      fill_in 'Senha', with: 'senha_nova'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'tereza@provedor.com'
    end
  end

  it 'e faz logout' do
    # Arrange
    User.create!(email:'tereza@provedor.com', password:'senha_nova')

    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'tereza@provedor.com'
    fill_in 'Senha', with: 'senha_nova'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'tereza@provedor.com'
  end
end
