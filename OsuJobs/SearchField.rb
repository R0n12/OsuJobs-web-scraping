#Created 2/18/2020 by Juhee Park
#Class for Search Field


class SearchField

    # attribute readers
    attr_reader :label, :name, :type, :options

=begin
    Parameters:
        label: search field label, string
        field_name: search field name attribute, string
        type: "input" or "select"
        options: hash with key = option text attribute, value = option value attribute
    Created 2/18/2020 by Juhee Park
=end
  def initialize (label, field_name, type, options)
     @label = label
     @name = field_name
     @type = type
     @options = options
  end

=begin
 Created 2/18/2020 by Ern Chi Khoo and Juhee Park
 Checking the equality of the SearchField object for testing purposes
=end
 def cmp(other)
    self.label == other.label &&
    self.name == other.name &&
    self.type == other.type &&
    self.options == other.options
  end

end