class PagesController < ApplicationController
  def home
  end

  def register   
    CollaboratorMailer.new_early_adopter(params[:email]).deliver

  	flash[:success] = "Obrigado por se registar. Entraremos em contacto muito brevemente."
  	redirect_to action: "home"
  end

  def about
  end
end
