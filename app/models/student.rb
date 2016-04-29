class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :offer_dates, through: :enrollments
  has_many :courses, through: :offer_dates
  validates_presence_of :first_name, :last_name, :moz_number, :manager_id
  validates_uniqueness_of :moz_number

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.import(file)
    saved_records = 0
    CSV.foreach(file.path,
      :headers => true,
      :converters => :all,
      :header_converters => lambda { |h| convert_header_name(h) }
    ) do |row|
      student = find_or_create_by(moz_number: row['moz_number'])
      student.attributes = row.to_hash.extract!(
        :manager_id,
        :department,
        :moz_number,
        :first_name,
        :last_name
      )
      saved_records += 1 if student.save!
    end
      return saved_records
  end

  private
  def self.convert_header_name(h)
    # Change column names
    h.downcase.gsub(' - ', '').gsub(' ', '_').gsub('\'', '')
      .gsub('mozzers_manager', 'manager_id')
      .gsub('business_units', 'department')
      .gsub('employee_id', 'moz_number')
      .gsub('legal_name', '')
      .to_sym
  end
end
