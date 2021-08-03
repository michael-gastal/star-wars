class LinksController < ApplicationController

  def history
    @links = Link.where(user: current_user).order('id DESC')
  end
end
