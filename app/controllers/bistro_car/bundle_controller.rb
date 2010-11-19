class BistroCar::BundleController < ActionController::Base
  caches_page :show

  def show
    headers['Content-Type'] = "application/javascript"
    render :text => BistroCar::Bundle.new(params[:bundle]).to_javascript
    
    # if we're in developement, render out the javascript file, too
    if Rails.env.development?
      path = "public/javascripts/coffeescripts.js"
      BistroCar.minify = true
      File.open(path, "w") { |file| file << BistroCar::Bundle.new('default').to_javascript }
    end

  end
end