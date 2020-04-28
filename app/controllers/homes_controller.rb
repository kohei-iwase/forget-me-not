class HomesController < ApplicationController
  # homeとropはログインしなくてもアクセス可能
  before_action :authenticate_user!, except: %i[about top]

  def top; end

  def about; end
end
