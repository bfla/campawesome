class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_one :tribal_membership, dependent: :destroy
  has_one :tribe, through: :tribal_membership
  belongs_to :state
  has_many :beens, dependent: :destroy
  has_many :campsites, through: :beens
  has_many :wants, dependent: :destroy
  has_many :campsites, through: :wants
  has_many :lists, dependent: :destroy
  has_many :photos
  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :activities

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.location = auth.info.location #from Facebook data
      if user.state_id.blank?
        parsed_location = user.location.split(', ') #try to split the location string into ["CITY", "STATE"]
        unless State.find_by_name(parsed_location[1]).blank?
          user.state_id = State.find_by_name(parsed_location[1]).id
        end
      end
      # FIXIT This triggers an error if the email is taken.  What should I do???
      user.save!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data['first_name'] if user.first_name.blank?
        user.location = data['user_location']
      end
    end
  end
  def coin_tally
    self.points
  end
end
