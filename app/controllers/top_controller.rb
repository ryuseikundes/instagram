class TopController < ApplicationController
  def index
    @pictures = Picture.all
  end
end
