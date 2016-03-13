require_relative '../../app/services/transaction_importer'
namespace :import do
  task transactions: :environment do
    LiftPass.where.not(wtp_number: "").each do |lift_pass|
      ti = TransactionImporter.new(lift_pass)
      ti.get_transactions
      ti.create_records
    end
  end

end
