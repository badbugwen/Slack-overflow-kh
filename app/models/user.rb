# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  intro                  :string
#  company                :string
#  job_title              :string
#  website                :string
#  twitter                :string
#  github                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  validates_uniqueness_of :email
  validates_presence_of :name, :email

  has_many :questions
  has_many :solutions

  has_many :upvotes, dependent: :destroy
  has_many :upvoted_questions, through: :upvotes, source: :question
  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question

   def self.from_omniauth(auth)
    #case 1: Find existing user bt github uid
    user = User.find_by_gh_uid(auth.uid)
    if user
      user.gh_token = auth.credentials.token
      user.save!
      return user
    end
    
    #case 2: find exsition user by enail
    existing_user = User.find_by_email(auth.info.email)
    if existing_user
      existing_user.gh_uid = auth.uid
      existing_user.gh_token =   auth.credentials.token 
      existing_user.save!
      return existing_user
    end

    #case 3: create new password
    user = User.new
    user.gh_uid = auth.uid
    user.gh_token = auth.credentials.token
    user.name = auth.info.name
    user.email = auth.info.email
    user.intro = auth.info.bio
    user.company = auth.info.company
    user.website = auth.info.blog
    user.github = auth.info.html_url
    user.password = Devise.friendly_token[0,20]
    user.save!  
    return user
  end  
end

