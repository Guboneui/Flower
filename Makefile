
.PHONY generate:
generate:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate

LoginDemoApp:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate LoginDemoApp

SearchFilterDemoApp:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate SearchFilterDemoApp

MainDemoApp:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate MainDemoApp

ChattingDemoApp:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate ChattingDemoApp

MapDemoApp:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate MapDemoApp
