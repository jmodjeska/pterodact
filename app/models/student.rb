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
    saved_records = [0, 0] # [new, updated]
    CSV.foreach(file.path,
      :headers => true,
      :converters => :all,
      :header_converters => lambda { |h| convert_column_name(h) }
    ) do |row|
      student = Student.where(moz_number: row[:moz_number]).first_or_initialize
      updates = row.to_hash.extract!(
        :manager_id,
        :department,
        :moz_number,
        :first_name,
        :last_name
      )

      if student.update_attributes!(updates)
        student.reload
        # Increment saved_records[new=0, updated=1] counters
        inc_type = ( student.created_at == student.updated_at ) ? 0 : 1
        saved_records[inc_type] += 1
      else
        # Do something if we failed to save the record?
      end
    end
      return saved_records
  end

  private
  def self.convert_column_name(h)
    h.downcase.gsub(' - ', '').gsub(' ', '_').gsub('\'', '')
      .gsub('mozzers_manager', 'manager_id')
      .gsub('business_units', 'department')
      .gsub('employee_id', 'moz_number')
      .gsub('legal_name', '')
      .to_sym
  end
end
