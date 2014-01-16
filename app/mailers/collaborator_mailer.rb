class CollaboratorMailer < ActionMailer::Base
  default from: "Happy Team <happyteam@getskilled.eu>"

  def daily_email(collaborator)
    @collaborator = collaborator
    mail(:to => collaborator.email, :subject => "Olá, como te sentes hoje?")
  end


  def new_early_adopter(early_adopter)
  	@early_adopter = early_adopter
    mail(:to => "happyteam@getskilled.eu", :subject => "[HappyTeam] Novo registo!")
  end
end
