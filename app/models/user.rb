class User < ApplicationRecord
  before_save :geocode_full_address
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  attachment :profile_image
  attachment :image

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction,length: { maximum: 50 }
  has_many :books,dependent: :destroy



  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: self.prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def geocode_full_address
    coords = Geocoder.coordinates(
      self.prefecture_name + self.address_city + self.address_street # 県名 + 市町村名 + 丁目番地
    )
    if coords
      self.latitude = coords[0]
      self.longitude = coords[1]
    end
  end


end
