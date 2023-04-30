require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e precisa se autenticar' do
    #Arrange

    #Act 
    visit root_path

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e vê o nome da app' do
    # Arrange (preparação)
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    # Act (execução)
    login_as(user)
    visit(root_path)

    # Assert (garantias)
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end

  it 'e vê os galpões cadastrados' do
    # Arrange (preparação)
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                    address: 'Rua do Rio, 1000', cep: '6000-000', description: 'Galpão do Rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                    address: 'Rua de Maceio, 1000', cep: '7000-000', description: 'Galpão de Maceio')

    # Act (execução)
    login_as(user)
    visit(root_path) 

    # Assert (garantias)
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')   

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')  
  end

  it 'e não existem galpões cadastrados' do
    # Arrange (preparação)
    user = User.create!(email:'tereza@provedor.com', password:'senha_nova')

    # Act (execução)
    login_as(user)
    visit(root_path)

    # Assert (garantias)
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end
