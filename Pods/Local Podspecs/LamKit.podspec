Pod::Spec.new do |s|

  s.name         = "LamKit"
  s.version      = "0.0.1"
  s.summary      = "L'Atelier du mobile's internal iOS development framework."
  s.license      = {
      :type => 'MIT',
      :text => <<-LICENSE
                Copyright (C) 2014 L'Atelier du mobile
      LICENSE
    }	
  s.homepage     = "http://www.atelierdumobile.com"
  s.author       = { "Nicolas Lauquin" => "nicolas@atelierdumobile.com", "Mathieu Godart" => "mathieu@atelierdumobile.com" }
  s.platform     = :ios
  s.ios.deployment_target = "6.0"
  s.source       = { :git => 'https://github.com/atelierdumobile/LamKit-iOS.git' }#, :tag => 0.0.1
  s.source_files  = '*.{h,m}'
  s.requires_arc = true
  s.frameworks = 'CoreGraphics', 'QuartzCore'
 
  s.dependency 'NSLogger'
  s.dependency 'LOG_EXPR'
  
  s.xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => '${inherited} LAM_BUILD_USERNAME="${USER}"'
  }
  
end
