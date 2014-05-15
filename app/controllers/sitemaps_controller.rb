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
      '/states/browse_destinations?id=michigan-camping',
      '/states/browse_cities?id=michigan-camping',
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
