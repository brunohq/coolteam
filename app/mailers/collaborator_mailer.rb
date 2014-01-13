class CollaboratorMailer < ActionMailer::Base
  default from: "Happy Team <happyteam@getskilled.eu>"

  def daily_email(collaborator)
    @collaborator = collaborator
    mail(:to => collaborator.email, :subject => "#{@user.name}, como estás hoje?")
  end
end
