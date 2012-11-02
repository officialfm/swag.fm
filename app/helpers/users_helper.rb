module UsersHelper
  def user_page_title
    if current_user == @user
      'Your favorite tracks'
    else
      "#{@user.name}'s favorite tracks"
    end
  end
end
