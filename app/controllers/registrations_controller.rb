class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
    if params['user-type'] == 'organizer'
      resource.update(organizer: true)
      resource.update(performer: false)
      resource.contents.create(role: 0, content_type: 1, content: params[:name])
    elsif params['user-type'] == 'performer'
      resource.update(organizer: false)
      resource.update(performer: true)
      resource.contents.create(role: 1, content_type: 1, content: params[:name])
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

end 
