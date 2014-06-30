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
    puts "Running find_for_facebook_oauth..."
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name if auth.info.first_name.present?
      user.last_name = auth.info.last_name if auth.info.last_name.present?
      user.location = auth.info.location if auth.info.location.present? #from Facebook data
      user.fb_id = auth.uid
      user.fb_token = auth['credentials']['token']
      if user.state_id.blank? && auth.info.location.present?
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
        user.last_name = data['last_name'] if user.last_name.blank?
        user.location = data['user_location'] if user.location.blank?
        user.fb_id = data['id'] if user.fb_id.blank?
        user.fb_token = data['credentials']['token'] if user.fb_token != data['credentials']['token']
      end
    end
  end
  def coin_tally
    self.points - (self.coins_spent || 0)
  end
  def fb_friends
    if self.fb_token.blank?
      []
    else
      fb_user = FbGraph::User.me(self.fb_token)
      fb_user.friends
    end
  end
  def likeify # ensure the user likes us on Facebook
    me = FbGraph::User.me(self.fb_token)
    page = FbGraph::Page.new('1412101645730094') if Rails.env.development?
    page = FbGraph::Page.new('1412101645730094') if Rails.env.production?
    if me.like?(page)
      self.likes_me = true
      self.save
    end
  end
end
