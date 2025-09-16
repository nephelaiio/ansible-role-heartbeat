.PHONY: all ${MAKECMDGOALS}

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

MOLECULE_ELASTICSEARCH_MAJOR_VERSION ?= 9
MOLECULE_SCENARIO ?= install
MOLECULE_DOCKER_IMAGE ?= ubuntu2204
GALAXY_API_KEY ?=
GITHUB_REPOSITORY ?= $$(git config --get remote.origin.url | cut -d':' -f 2 | cut -d. -f 1)
GITHUB_ORG = $$(echo ${GITHUB_REPOSITORY} | cut -d/ -f 1)
GITHUB_REPO = $$(echo ${GITHUB_REPOSITORY} | cut -d/ -f 2)
REQUIREMENTS = requirements.yml

all: install version lint test

test: lint
	uv run molecule test -s ${MOLECULE_SCENARIO}

install:
	uv sync

lint: install
	uv run yamllint .
	ANSIBLE_COLLECTIONS_PATH=$(MAKEFILE_DIR) \
	uv run ansible-lint .

dependency create prepare converge idempotence side-effect verify destroy login reset:
	ANSIBLE_COLLECTIONS_PATH=$(MAKEFILE_DIR) \
	MOLECULE_DOCKER_IMAGE=${MOLECULE_DOCKER_IMAGE} \
	MOLECULE_ELASTICSEARCH_MAJOR_VERSION=${MOLECULE_ELASTICSEARCH_MAJOR_VERSION} \
	uv run molecule $@ -s ${MOLECULE_SCENARIO}

ignore:
	uv run ansible-lint --generate-ignore

publish:
	@echo publishing repository ${GITHUB_REPOSITORY}
	@echo GITHUB_ORGANIZATION=${GITHUB_ORG}
	@echo GITHUB_REPOSITORY=${GITHUB_REPO}
	uv run ansible-galaxy role import \
		--api-key ${GALAXY_API_KEY} ${GITHUB_ORG} ${GITHUB_REPO}

debug:
	@uv export --dev
