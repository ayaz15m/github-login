class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    info = request.env["omniauth.auth"]

    uid = info["uid"]
    username = info.fetch("info").fetch("nickname")
    access_token = info.fetch("credentials").fetch("token")
    email = info.fetch("info").fetch("email")
    photo_url = info.fetch("info").fetch("image")

    user = User.find_by uid: uid
    if user
      user.update(username: username, access_token: access_token, email: email, photo_url: photo_url)
    else
      User.create!(uid: uid, username: username, access_token: access_token, email: email, photo_url: photo_url)
    end

    sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
  end
end
