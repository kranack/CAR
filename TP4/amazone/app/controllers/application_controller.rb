#	File application_controller.rb
#	Classe Principale de l'application (géré par le framework Spree)


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
