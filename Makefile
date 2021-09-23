all: generate open

generate:
	@ echo "\033[1;37mGenerating project files and installing dependencies\033[0m"
	@ (cd App; xcodegen -c && pod install --deployment)
	@ echo "\033[1;37mRunning SwiftGen\033[0m"
	@ App/Pods/SwiftGen/bin/swiftgen config run --config config/swiftgen.yml
	@ echo "\033[1;37mAdding generated files to project\033[0m"
	@ (cd App; xcodegen -c && pod install --deployment)

open:
	@ open App/Royals.xcworkspace

clean:
	@ echo "\033[1;37mCleaning up project files\033[0m"
	@ rm -rf App/Royals.xc* App/Pods
	@ find App/Royals/Resources/Generated ! -name '.gitkeep' -type f -exec rm -f {} +

dependencies:
	@ (cd App; pod install)

PRE_COMMIT=.git/hooks/pre-commit
hooks:
	@ if [ ! -e $(PRE_COMMIT) ]; then echo "\033[1;37mDownloading git pre-commit hook file\033[0m" && curl -s https://gist.githubusercontent.com/vcoutasso/5933653035713e5e9a53be8e93e5ac0b/raw/fbcf7fd7a50a569e55bd68ed9bb31ac9a70a3d45/pre-commit > $(PRE_COMMIT) && sed -i "" "s/Pods/App\/Pods/g" $(PRE_COMMIT) && chmod +x $(PRE_COMMIT) && sed -i "" "s/--swiftversion 5/--config config\/swiftformat/g" $(PRE_COMMIT); else echo "File already exists. Remove and run \`make hooks\` again to create a new one."; fi

remake: clean generate open
