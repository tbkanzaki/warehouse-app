User.create!(name: 'Tereza', email:'tereza@provedor.com', password:'senha_nova')
User.create!(name: 'Maria', email:'maria@provedor.com', password:'senha_nova')

Warehouse.create!(name:'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                  description: 'Galpão destinado para cargas internacionais')

Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                address: 'Rua de Maceio, 1000', cep: '7000-000', 
                description: 'Galpão de Maceio')

Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                registration_number: '4344726000102', full_address: 'Av das Palmas, 100', 
                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

Supplier.create!(corporate_name: 'Samsung Eletronic LTDA', brand_name: 'Samsung', 
                registration_number: '4344726000102', full_address: 'Av das Palmas, 100', 
                city: 'Bauru', state: 'SP', email: 'contato@samsung.com')

Order.create!(warehouse_id: 1, supplier_id: 1, user_id: 1, estimated_delivery_date: 1.day.from_now)
Order.create!(warehouse_id: 1, supplier_id: 1, user_id: 2, estimated_delivery_date: 1.day.from_now)

Order.create!(warehouse_id: 1, supplier_id: 2, user_id: 1, estimated_delivery_date: 1.week.from_now)
Order.create!(warehouse_id: 1, supplier_id: 2, user_id: 2, estimated_delivery_date: 1.week.from_now)

Order.create!(warehouse_id: 2, supplier_id: 1, user_id: 1, estimated_delivery_date: 1.month.from_now)
Order.create!(warehouse_id: 2, supplier_id: 1, user_id: 2, estimated_delivery_date: 1.month.from_now)

Order.create!(warehouse_id: 2, supplier_id: 2, user_id: 1, estimated_delivery_date: 2.months.from_now)
Order.create!(warehouse_id: 2, supplier_id: 2, user_id: 2, estimated_delivery_date: 2.months.from_now)
