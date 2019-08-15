Pod::Spec.new do |spec|

  spec.name           = 'BookstoreModule'
  spec.version        = '0.0.1'
  spec.summary        = 'A short description of Bookstore Module.'
  spec.description    = <<-DESC
  Bookstore Module
  DESC

  spec.homepage       = 'https://ibuldapp.com'
  spec.license        = 'COMMERCIAL'
  spec.author         = { 'Anton Boyarkin' => 'anton.boyarkin@icloud.com' }
  spec.platform       = :ios, '10.0'
  spec.source         = { :git => 'git@gitlab.vladimir.ibuildapp.com:ios/bookstorewidget.git', :tag => '#{spec.version}' }
  spec.source_files   = 'Sources/*.swift', 'Sources/**/*.swift'
  spec.frameworks     = 'UIKit', 'Foundation'
  spec.dependency       'IBACore'
  spec.dependency       'IBACoreUI'

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/*.swift'
    test_spec.dependency 'Quick'
    test_spec.dependency 'Nimble'
  end

end
