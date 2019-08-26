class HomeController < ApplicationController
  def Index
    $packages=Package.all
  end
end
