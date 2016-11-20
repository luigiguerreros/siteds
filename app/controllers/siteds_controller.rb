class SitedsController < ApplicationController
	def index
		@lista = Xnombre.new(params[:nombres], params[:a_paterno], params[:a_materno])
	end
end
