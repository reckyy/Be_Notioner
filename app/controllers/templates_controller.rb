class TemplatesController < ApplicationController

  def index
    @templates = Template.all.includes(:user).order(created_at: :desc)
  end

  def new
    @template = Template.new
  end

  def create
    @template = current_user.templates.build(template_params)
    if @template.save
      redirect_to templates_path, success: (t '.success')
    else
      flash.now[:danger] = (t '.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def template_params
    params.require(:template).permit(:name, :url)
  end
end
