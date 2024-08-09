SHELL := bash

PYTHON ?= $(shell command -v python3)
PYTHON ?= $(shell command -v python)

ifndef PYTHON
$(error Can't find 'python3'. Set PYTHON=/path/to/bin/python3)
endif

ifeq (,$(shell $(PYTHON) --version | grep -E 'Python 3\.([6789]|1[0-9])\.' || true))
$(error Unsupported python version. Needs 3.6+)
endif

VENV ?= .venv

export PATH := $(VENV)/bin:$(PATH)

o ?=

.DELETE_ON_ERROR:

default:

test: venv
	PYYAML_FORCE_LIBYAML=0 pytest $o

test-ext: venv
	PYYAML_FORCE_LIBYAML=1 pytest $o

build: venv
	python setup.py build $o

build-ext: venv
	python setup.py --with-libyaml build $o

install: venv
	python setup.py install $o

installext: venv
	python setup.py --with-libyaml install $o

clean:
	$(RM) -r \
	    .pytest_cache/ \
	    build/ \
	    lib/PyYAML.egg-info/ \
	    lib/yaml/__pycache__/ \
	    tests/__pycache__/ \
	    tests/legacy_tests/__pycache__/
	$(RM) yaml/_yaml.c \
	    lib/yaml/_yaml.cpython-*

distclean: clean
	$(RM) -r $(VENV)

venv: $(VENV)

$(VENV):
	$(PYTHON) -m venv $@
	pip install --upgrade pip
	pip install pytest
	pip install -e .
