platform :ios, '15.0'

target 'keanus_checkout_ios' do
  use_frameworks!

  # Pods for keanus_checkout_ios
  pod 'SnapKit', '~> 5.6.0'
  pod 'lottie-ios'
  pod 'CombineCocoa'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
