class SignedInController < ApplicationController
  before_filter :require_login, :except => [:not_authenticated]

  protected

  def not_authenticated   
    redirect_to sign_in_path
  end
end