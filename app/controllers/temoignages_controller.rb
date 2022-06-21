class TemoignagesController < ApplicationController
  def index
    @temoignages = Temoignage.all
  end
end
