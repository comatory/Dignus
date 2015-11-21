class RegistrationsController < Devise::RegistrationsController
  before_action :check_signup_params, only: [:new]

  def new
      super
  end

  def create
    super
    if resource.save
      set_user_role(resource)
    end
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  def cancel
    super
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(resource.id)
  end

  def check_signup_params
    # handle agains `/users/sign_up` without correct params
    unless params['user-type'] == 'organizer' || params['user-type'] == 'performer'
      redirect_to root_path
    end
  end

  private

  def set_user_role(resource)
    if params['user-type'] == 'organizer'
      resource.update(organizer: true)
      resource.update(performer: false)
      name = resource.contents.create(role: 0, content_type: 1)
    elsif params['user-type'] == 'performer'
      resource.update(organizer: false)
      resource.update(performer: true)
      name = resource.contents.create(role: 1, content_type: 1)
    end
    name.update(content: set_default_user_name(resource))
  end

  def set_default_user_name(resource)
    name_safe_params[:name].empty? ? resource.email : name_safe_params[:name]
  end


  def name_safe_params
    params.require(:user).permit(:name)
  end

end 
