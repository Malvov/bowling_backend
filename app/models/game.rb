# == Schema Information
#
# Table name: games
#
#  id          :bigint(8)        not null, primary key
#  player_name :string
#  final_score :integer          default(0)
#  is_over     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Game < ApplicationRecord

end
