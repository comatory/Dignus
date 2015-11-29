class AddAttachmentPosterToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :poster
    end
  end

  def self.down
    remove_attachment :events, :poster
  end
end
