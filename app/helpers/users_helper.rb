module UsersHelper
  def submit_button_for(user, form)
    user.new_record? ? form.submit("Create Account") : form.submit("Update Account")
  end
end
