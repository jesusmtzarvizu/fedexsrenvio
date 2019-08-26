require 'json'
require 'fedex'
class HomeController < ApplicationController
  def Index
    $packages=Package.all
  end
  def destroy
    $packages=Package.destroy_all
  end
  
  def filldb
    #reading the Json File
    @data_hash=readJsonFile
    #Geting package info from API Fedex
    @fedexhash=getPackgeApiFedex(@data_hash[0]['tracking_number'])
    #saving the info of Json file and APi fedex (one single row for tracking number)
    savingdb(@data_hash,@fedexhash)

  end

  def savingdb(data_hash,fedexhash)
    Package.create(tracking_number: data_hash[0]['tracking_number'],
    flength:fedexhash[0]['details']['package_dimensions']['length'],
    fwidth:fedexhash[0]['details']['package_dimensions']['width'],
    fheight:fedexhash[0]['details']['package_dimensions']['height'],
    fweight:fedexhash[0]['details']['package_weight']['value'],
    fdistance_unit:fedexhash[0]['details']['package_dimensions']['units'],
    fmass_unit:fedexhash[0]['details']['package_weight']['units'],
    jlength:data_hash[0]['parcel']['length'],
    jwidth:data_hash[0]['parcel']['width'],
    jheight:data_hash[0]['parcel']['height'],
    jweight:data_hash[0]['parcel']['weight'],
    jdistance_unit:data_hash[0]['parcel']['distance_unit'],
    jmass_unit:data_hash[0]['parcel']['mass_unit'],
    eweight: "0"
    )   

  end

  def getPackgeApiFedex(tracking_number)
       
    @fedex = Fedex::Shipment.new(:key => 'jfjwKS65xft8r8mh',
                             :password => 'QYrbniTyMafyj4LXm4tV7nsq5',
                             :account_number => '802388543',
                             :meter => '119147906',
                             :mode => 'development')
     @fedexpackage=@fedex.track(:tracking_number=>tracking_number)
     @fedexjson=(@fedexpackage).to_json
     @fedexhash=JSON.parse(@fedexjson)
    return @fedexhash
  end


  def readJsonFile
    @path=(Rails.root).to_s + "/app/labels.json"
    @file = File.read(@path)
    @data_hash = JSON.parse(@file) #Array
    return @data_hash
  end
end
