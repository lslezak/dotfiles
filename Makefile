SCRIPTS := $(shell find . -type f -name "*.sh" -not -path "*/.git/*")
DOCKERFILE := .devcontainer/Dockerfile
DEVCONTAINER_FILE := .devcontainer/devcontainer.json

# schema for validating the devcontainer.json files
DEVCONTAINER_SCHEMA := https://raw.githubusercontent.com/devcontainers/spec/main/schemas/devContainer.base.schema.json

.PHONY: check format reformat lint-dockerfile check-devcontainer

# run shellcheck on all scripts
check:
	shellcheck $(SCRIPTS)

# check the formatting of the scripts, print the diff if not formatted properly
format:
	shfmt -d .

# format the scripts in place
reformat:
	shfmt -w .

# lint the Dockerfile, see .hadolint.yaml for the configuration
lint-dockerfile:
	hadolint --config .hadolint.yaml $(DOCKERFILE)

# validate the devcontainer.json file against the schema, the file is 
# JSONC (JSON with comments) so parse them as JSON5
check-devcontainer:
	check-jsonschema --force-filetype json5 --schemafile $(DEVCONTAINER_SCHEMA) $(DEVCONTAINER_FILE)
