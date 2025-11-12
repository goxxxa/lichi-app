.PHONY: get codegen gen fix precommit

precommit:
	@dart format .
	@dart fix --apply

get:
	@flutter pub get

codegen: get
	@dart pub global activate protoc_plugin
	@dart run build_runner build --delete-conflicting-outputs
	@dart format .
	@dart fix --apply

gen: codegen packages-codegen


fix: get
	@dart fix --apply .
	@dart format --fix -l 60 .


build-apk:
	@flutter build apk --release

build-ios:
	@flutter build ios --release --no-sign

upgrade-packages:
	@(flutter pub outdated && flutter pub upgrade --major-versions)