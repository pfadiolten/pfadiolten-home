class ApplicationPresenter < Oprah::Presenter
  class << self
    def present_all(query)
      self::Collection.new(query.map(&method(:new)))
    end
  end

  class Collection < ApplicationPresenter

  end
end