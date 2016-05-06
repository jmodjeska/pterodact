class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :offer_dates, through: :enrollments
  has_many :courses, through: :offer_dates
  validates_presence_of :first_name, :last_name, :moz_number, :manager_id
  validates_uniqueness_of :moz_number

  CSV_COLUMNS_REQUIRED = [  # Moz Workday Nomenclature
    :first_name,            # Legal Name - First Name
    :last_name,             # Legal Name - Last Name
    :moz_number,            # Mozzer ID
    :manager_id,            # Mozzer's Manager
    :department             # Business Units
  ]

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.import(file)
    row_id = 0
    response = {
      :new => 0,
      :updated => 0,
      :skipped => [],
      :bad_format => false
    }

    CSV.foreach(file.path,
      :headers => true,
      :converters => :all,
      :header_converters => lambda { |h| convert_column_name(h) }
    ) do |row|
        row = row.to_hash.extract!( *CSV_COLUMNS_REQUIRED )

        if ( row_id == 0 ) && !validate_header(row)
          response[:bad_format] = true
          break
        end

        if validate_row(row)
          s = Student.where( moz_number: row[:moz_number] ).first_or_initialize
          row[:manager_id] = get_manager_id(row)

          if s.update_attributes!(row)
            s.reload
            type = ( s.created_at == s.updated_at ) ? :new : :updated
            response[type] += 1
          else
            response[:skipped].push(row.values)
          end

        else
          # Validation failed
          response[:skipped].push(row.values)
        end

        row_id += 1
      end
    return response
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

  def self.validate_header(row)
    ( CSV_COLUMNS_REQUIRED - row.keys ).empty?
  end

  def self.validate_row(row)
    ( row[:moz_number].is_a? Integer ) && ( row.all? { |k,v| !v.nil? } )
  end

  def self.get_manager_id(row)
    row[:manager_id][/\((\d+)\)/, 1]
  end
end
