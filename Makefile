
.PHONY generate:
generate:
	TUIST_ROOT_DIR=${PWD} tuist clean
	TUIST_ROOT_DIR=${PWD} tuist fetch
	TUIST_ROOT_DIR=${PWD} tuist generate
