class Hash
  # very naive implementation of to_query
  def to_query
    map { |key, value| "#{key}=#{value}" }.join('&')
  end
end