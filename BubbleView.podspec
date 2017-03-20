
Pod::Spec.new do |spec|
    spec.name            = 'BubbleView'
    spec.version          = '1.0.1'
    spec.summary          = 'Custom BubbleView'
    spec.description      = <<-DESC
                            Custom BubbleView
                            DESC
    spec.homepage        = 'https://github.com/woshishui1243/'
    spec.license          = { :type => 'MIT', :file => 'LICENSE' }
    spec.author          = { 'DaYu' => 'https://github.com/woshishui1243/' }
    spec.source          = { :git => 'https://github.com/woshishui1243/BubbleView.git', :tag => spec.version.to_s }
    spec.ios.deployment_target = '7.0'
    spec.source_files = 'BubbleView/Classes/*.{h,m}'
end
