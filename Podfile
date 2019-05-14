# Uncomment this line to define a global platform for your project
platform :ios, '10.0'

target 'BMSTUSchedule' do
  use_frameworks!

  # Pods for BMSTUSchedule
  inhibit_all_warnings!

  # Notifications & statistics
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  
  # Networking
  pod 'Alamofire'
  
  # Cache
  pod 'RealmSwift'
  
  # Image cache
  pod 'Kingfisher'
  
  # Code quality
  pod 'SwiftLint'
  pod 'R.swift'

  # Apple Music stork
  pod 'SPStorkController'
  
  # Debug
  pod 'Reveal-SDK', :configurations => ['Debug']
  
  target 'BMSTUScheduleTests' do
    inherit! :search_paths
  end

  target 'BMSTUScheduleUITests' do
    inherit! :complete
  end

end
