class UsersController < ApplicationController
  def index
    @users = User.by_karma.page(params[:page])
    params[:page] == '1' || params[:page].nil? ? @previous_page = '#' : @previous_page = "?page=#{params[:page].to_i - 1}"
    params[:page] == "#{User.count / 50}" ? @next_page = '#' : @next_page = "?page=#{params[:page].to_i + 1}"
  end


end
