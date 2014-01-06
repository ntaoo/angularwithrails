class AppController < ApplicationController
  def boot
    render :file => 'public/index.html'
    return
  end
end
