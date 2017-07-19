Pod::Spec.new do |s|
  s.name = 'WeakPointerArray'
  s.version = '1.0'
  s.license = 'MIT'
  s.summary = 'The WeakPointerArray represents a mutable collection created over Array, but it holds weak references for objects(not strong as in Array).'
  s.homepage = 'https://github.com/NickRybalko/WeakPointerArray'
  s.authors = { 'iOS engineer Nick Rybalko' => 'https://github.com/NickRybalko' }
  s.source = { :git => 'https://github.com/NickRybalko/WeakPointerArray.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/*.swift'
end
