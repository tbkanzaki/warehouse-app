require 'rails_helper'

describe 'Usuário deleta um galpão' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Warehouse.create!(name:'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10000,
                      address: 'Avenida dos Jacarés, 1000', cep: '56000-000',
                      description: 'Galpão no centro do país')

    # Act
    login_as(user)
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do
    # Arrange
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    first_warehouse = Warehouse.create!(name:'Cuiabá', code: 'CWB', city: 'Cuiabá', area: 10000,
                                        address: 'Avenida dos Jacarés, 1000', cep: '56000-000',
                                        description: 'Galpão no centro do país')

    second_warehouse = Warehouse.create!(name:'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20000,
                                        address: 'Av Tiradentes, 20', cep: '46000-000',
                                        description: 'Galpão para compras mineiras')

    # Act
    login_as(user)
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert - espero que o galpão não apareça
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'
  end
end
