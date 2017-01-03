class AddEmailAndBackupTelephoneToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :email, :string, limit: 50
    add_column :patients, :backup_telephone, :string, limit: 20
  end
end
