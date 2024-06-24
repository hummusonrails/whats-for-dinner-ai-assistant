class UploadsController < ApplicationController
  def show
    path = params[:path]
    send_file Rails.root.join('public', 'uploads', path), disposition: 'inline'
  end
end
