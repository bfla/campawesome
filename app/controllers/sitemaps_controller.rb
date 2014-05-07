class SitemapsController < ApplicationController
  
  def show
    @domain = "http://#{request.host_with_port}"

    @static_sites = [
      '',
      '/terms',
      '/takedown',
      '/privacy',
      '/smallbiz',
      '/bloggers',
      '/reasons',
      '/sign_up',
      '/sign_in',
    ]

    @campsites = Campsite.all()
    @states = State.all()
    @cities = City.all()
    @destinations = Destination.all()

    respond_to do |format|
      format.xml
    end
  end
end
