class ImportWorker
  include Sidekiq::Worker

  def perform
    LiftPass.where.not(wtp_number: "").each do |lift_pass|
      ti = TransactionImporter.new(lift_pass)
      ti.get_transactions
      ti.create_records
    end

  end

end
