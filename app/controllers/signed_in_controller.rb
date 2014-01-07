class SignedInController < ApplicationController
  before_filter :require_login, :except => [:not_authenticated]

  protected

  def not_authenticated
    render(
      status: 401,
      json: {
        info: "Not Signed in"
      }
    )
  end
end