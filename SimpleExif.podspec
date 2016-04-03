
Pod::Spec.new do |s|

  s.name         = "SimpleExif"
  s.version      = "0.0.1"
  s.summary      = "Simple exif is a pod that allows you to add Exif data to any UIImage in your app. You can add location, timestamp and user comments."
  s.homepage     = "https://github.com/Nikita2k/SimpleExif"
  s.license      = { :type => "MIT", :file => "LICENCE" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.0'

  s.requires_arc = true
  
  s.author    = "Nikita Took"

  s.source       = { :git => "https://github.com/Nikita2k/SimpleExif.git", :tag => s.version.to_s }

  s.source_files  = "Classes", "Classes/*.{h,m}"
  s.ios.source_files = 'Classes/ios/**/*.{h,m}'
  s.osx.source_files = 'Classes/osx/**/*.{h,m}'

  s.exclude_files = "Classes/Exclude"

end
