module StringExt

  class ::String

    def snakeize
      self.downcase.gsub(/\W+/, '_').gsub(/_$/, '')
    end unless method_defined?(:snakeize)

  end

end
