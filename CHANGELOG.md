# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2024-05-06

### Added

* Files: Add basic Dockerfile.

* Files: CHANGELOG.md file.

* Files: README.md file.

* Files: LICENSE file. Selected license is BSD-2.

* Dockerfile: `Google Test` and `FFF` dependencies.

* Dockerfile: OpenWRT libraries (`ubox`, `ubus`, `uci`).

* Dockerfile: `nixio` lua binding.

* Dockerfile: `junit2html` tool.

* Dockerfile: Libs for build OpenWRT-23 firmware.

* Dockerfile: `xorriso` for build x86 target.

* Dockerfile: `shellcheck` for bash scripts linting.

* Dockerfile: Device tree compiler.

* Dockerfile: python `cffi` and cryptography libraries.

* Dockerfile: `mkisofs` installation.

* Dockerfile: `qemu-utils` installation for generate images for virtualization.

* Dockerfile: Different versions of `gcc` - 9, 10, 11.

* Dockerfile: Different versions of `g++` - 9, 10, 11.

* Dockerfile: Different versions of `python` - 3, 2.7.

* Dockerfile: support for Lua dev environment.

* Dockerfile: support for C dev environment.

* Dockerfile: support for OpenWRT dev environment.

### Changed

* Dockerfile: Change default `gcc` to 9.x.x.

* Dockerfile: Change default `g++` to 9.x.x.
