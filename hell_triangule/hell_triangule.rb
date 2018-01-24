class HellTriangule
  attr_reader :triangule

  def initialize(triangule)
    @triangule = triangule
  end

  def resolve
    return if invalid?

    index = 0

    triangule.reduce(0) do |sum, current|
      chosen = current.slice(index..index + 1).max
      index = current.index(chosen)
      sum += chosen
    end
  end

  private

  def invalid?
    triangule.empty?
  end
end
