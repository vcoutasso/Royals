generate:
	@ echo "\033[1;37mGenerating project files\033[0m"
	@ (cd App; xcodegen -c && pod install)

open:
	@ open App/Skatable.xcworkspace

clean:
	@ echo "\033[1;37mCleaning up project files\033[0m"
	@ rm -rf App/Skatable.xc* App/Podfile.lock App/Pods
	@ find App/Skatable/Resources/Generated ! -name '.gitkeep' -type f -exec rm -f {} +
