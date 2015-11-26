class CreateAudioFiles < ActiveRecord::Migration
  def change
    create_table :audio_files do |t|
      def up
        add_attachment :audio_files, :audio
      end

      def down
        remove_attachment :audio_files, :audio
      end

      t.timestamps null: false
    end
  end
end
