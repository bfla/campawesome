class AddHighlightsAndThingsToDoAndCampingTipsToDestination < ActiveRecord::Migration
  def change
    add_column :destinations, :highlights, :text
    add_column :destinations, :things_to_do, :text
    add_column :destinations, :camping_tips, :text
  end
end
