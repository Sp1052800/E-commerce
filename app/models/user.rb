class User < ApplicationRecord
	validates :name, presence: true ,length:{minimum: 4,too_short:%{tooshort}}
  validates :emailid,presence:true,uniqueness:true
  validates_format_of :emailid, :with=> /\A([^@\s]+)@((?:[a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password,presence:true
  validates :confirmpassword, presence:true
  validates :mobileno,presence:true,numericality:true#,length:{is:10} 
  has_one :image
  has_and_belongs_to_many :roles 
  accepts_nested_attributes_for :image
  before_save :check_name
  before_save :encrypt_password
  before_validation :verify_password
  #scope :admin? ->{true if self.email=admin@gmail.com}
  def admin?
     self.roles.pluck(:name).include?("admin")
  end
  def check_name
     if name.blank?
       self.name="unknow"
     end
  end
  def self.omniauth(auth)
    #where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      #byebug
      user.provider = auth.provider
      user.uid = auth.uid
      user.mail = auth.info.email
      user.name = auth.info.name
      user.profile_image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save(validate: false)
    end
  end

  def encrypt_password
    unless password.nil?
       self.password = Digest::MD5.hexdigest(password)
       self.confirm_password = Digest::MD5.hexdigest(confirm_password)
       puts self.inspect
    end
  end
    def verify_password
      unless password.nil?
      if password != confirmpassword
           errors.add(:base, "password & confirm_password are not equal!" )
      end
    end
    end


def self.authenticate(mail, password)
    if @user = User.where(mail: mail, password:Digest::MD5.hexdigest(password)).last
      @user
       else
        nil
       end
  end
end
