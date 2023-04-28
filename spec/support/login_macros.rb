def login(usuario)
  click_on 'Entrar'
  fill_in 'E-mail', with: 'tereza@provedor.com'
  fill_in 'Senha', with: 'senha_nova'
  within('form') do
    click_on 'Entrar'
  end
end