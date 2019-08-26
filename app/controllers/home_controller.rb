require 'json'
require 'fedex'
class HomeController < ApplicationController
  def Index
    @packages=Package.all
     
  end
  def destroy
    @packages=Package.destroy_all
  end
  
  def filldb
    #reading the Json File
    @data_hash=readJsonFile
    #Geting package info from API Fedex
    @largo=@data_hash.length
    
    #saving the info of Json file and APi fedex (one single row for tracking number)
    savingdb(@data_hash)

  end

  def savingdb(data_hash)


    for index in (0...data_hash.length)
        
    
        fedexhash=getPackgeApiFedex(data_hash[index]['tracking_number'])

        Package.create(tracking_number: data_hash[index]['tracking_number'],
        flength:fedexhash[0]['details']['package_dimensions']['length'],
        fwidth:fedexhash[0]['details']['package_dimensions']['width'],
        fheight:fedexhash[0]['details']['package_dimensions']['height'],
        fweight:fedexhash[0]['details']['package_weight']['value'],
        fdistance_unit:fedexhash[0]['details']['package_dimensions']['units'],
        fmass_unit:fedexhash[0]['details']['package_weight']['units'],
        jlength:data_hash[index]['parcel']['length'],
        jwidth:data_hash[index]['parcel']['width'],
        jheight:data_hash[index]['parcel']['height'],
        jweight:data_hash[index]['parcel']['weight'],
        jdistance_unit:data_hash[index]['parcel']['distance_unit'],
        jmass_unit:data_hash[index]['parcel']['mass_unit'],
        eweight: "0")
    end   

  end

  def getExceededWeight(length,width,height,distance_unit,weight,mass_unit,length2,width2,height2,distance_unit2,weight2,mass_unit2)
      #peso volumentrico del paquete del Json label file
      measure=(length.to_i*width.to_i*height.to_i)/5000
      #1 pulgada cubica = 16.387cm cubicos
      #peso volumentrico del paquete de la API FEDEX API
      measure2=((length2.to_i*width2.to_i*height2.to_i)/5000)*16.387

      #1lb =0.454 kg
      weight2=(weight2.to_i)*0.454
      if(measure>=weight.to_i)
        ExceededWeight=(measure-measure2).ceil
      else   
        ExceededWeight=(weight-(weight2)).ceil

      return ExceededWeight
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
