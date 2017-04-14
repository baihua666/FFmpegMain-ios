Pod::Spec.new do |s|
  s.name = 'FFmpegMain'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'ffmpeg ios cmd util'
  s.homepage = 'https://github.com/abc19abc91/FFmpegMain-ios'
  s.authors = { 'kale' => 'tubao1985@163.com' }
  s.source = { :git => 'https://github.com/abc19abc91/FFmpegMain-ios.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Demo/**/*.swift'
end