# Contains the business logic for flower bundles and orders
class Flower
  attr_reader :name, :code, :batch_attributes
  def initialize(name, code, batch_attributes)
    @name             = name
    @code             = code
    @batch_attributes = batch_attributes
  end

  def ==(other)
    name == other.name &&
      code == other.code &&
      batch_attributes == other.batch_attributes
  end
end
