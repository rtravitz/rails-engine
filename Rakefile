# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'csv'

namespace :load_data do
  
  task :customers => :environment do
    data = File.read("data/customers.csv")
    parsed = CSV.parse(data, headers: true)
    parsed.each do |row|
      Customer.create(row.to_hash)
    end
  end
  
  task :invoice_items => :environment do
    data = File.read("data/invoice_items.csv")
    parsed = CSV.parse(data, headers: true)
    parsed.each do |row|
      InvoiceItem.create(row.to_hash)
    end
  end
  
  task :invoices => :environment do
    data = File.read("data/invoices.csv")
    parsed = CSV.parse(data, headers: true)
    parsed.each do |row|
      Invoice.create(row.to_hash)
    end
  end
  
  task :items => :environment do
    data = File.read("data/items.csv")
    parsed = CSV.parse(data, headers: true)
    parsed.each do |row|
      Item.create(row.to_hash)
    end
  end
  
  task :merchants => :environment do
    data = File.read("data/merchants.csv")
    parsed = CSV.parse(data, headers: true)
    parsed.each do |row|
      Merchant.create(row.to_hash)
    end
  end
  
  task :transactions => :environment do
    data = File.read("data/transactions.csv")
    parsed = CSV.parse(data, headers: true)
    parsed.each do |row|
      Transaction.create(row.to_hash)
    end
  end

  task :all => ["load_data:customers","load_data:invoice_items","load_data:invoices",
  "load_data:items", "load_data:merchants", "load_data:transactions"]
  
end

Rails.application.load_tasks
