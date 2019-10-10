
Changelog
=========

`0.6.0 <https://github.com/saltstack-formulas/exim-formula/compare/v0.5.0...v0.6.0>`_ (2019-10-08)
------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **pillar:** accept 'true'/True/true for booleans in pillars (\ `afe3e70 <https://github.com/saltstack-formulas/exim-formula/commit/afe3e70>`_\ )
* **pillar:** some config values can be treated as lists (\ `481966d <https://github.com/saltstack-formulas/exim-formula/commit/481966d>`_\ )

`0.5.0 <https://github.com/saltstack-formulas/exim-formula/compare/v0.4.0...v0.5.0>`_ (2019-10-05)
------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **pillars:** extract default values to pillars (\ `72299cc <https://github.com/saltstack-formulas/exim-formula/commit/72299cc>`_\ )

Features
^^^^^^^^


* **tofs:** add TOFS pattern (\ `7222790 <https://github.com/saltstack-formulas/exim-formula/commit/7222790>`_\ )

`0.4.0 <https://github.com/saltstack-formulas/exim-formula/compare/v0.3.0...v0.4.0>`_ (2019-10-04)
------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **states:** add missing require sls (\ `726df07 <https://github.com/saltstack-formulas/exim-formula/commit/726df07>`_\ )
* **states:** re-generate Exim aliases DB after update (\ `6a0aecf <https://github.com/saltstack-formulas/exim-formula/commit/6a0aecf>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** install required packages to bootstrapped ``opensuse`` [skip ci] (\ `63a132e <https://github.com/saltstack-formulas/exim-formula/commit/63a132e>`_\ )
* **kitchen:** use bootstrapped ``opensuse`` images until ``2019.2.2`` [skip ci] (\ `f1efdc9 <https://github.com/saltstack-formulas/exim-formula/commit/f1efdc9>`_\ )
* **platform:** add ``arch-base-latest`` (commented out for now) [skip ci] (\ `89918b2 <https://github.com/saltstack-formulas/exim-formula/commit/89918b2>`_\ )

Features
^^^^^^^^


* **states:** add exim.mailname and exim.aliases states (\ `68bb801 <https://github.com/saltstack-formulas/exim-formula/commit/68bb801>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **states:** reuse already fetched pillars (\ `c466c86 <https://github.com/saltstack-formulas/exim-formula/commit/c466c86>`_\ )

Tests
^^^^^


* **inspec:** check that smtp port is opened (\ `a6418d3 <https://github.com/saltstack-formulas/exim-formula/commit/a6418d3>`_\ )

`0.3.0 <https://github.com/saltstack-formulas/exim-formula/compare/v0.2.1...v0.3.0>`_ (2019-09-25)
------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **map:** sync map.jinja with template-formula (\ `5ddd1c9 <https://github.com/saltstack-formulas/exim-formula/commit/5ddd1c9>`_\ )

`0.2.1 <https://github.com/saltstack-formulas/exim-formula/compare/v0.2.0...v0.2.1>`_ (2019-09-23)
------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **states:** split exim metastate in .package/.config/.service (\ `a947ba9 <https://github.com/saltstack-formulas/exim-formula/commit/a947ba9>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** change ``log_level`` to ``debug`` instead of ``info`` (\ `56d9573 <https://github.com/saltstack-formulas/exim-formula/commit/56d9573>`_\ )

`0.2.0 <https://github.com/saltstack-formulas/exim-formula/compare/v0.1.0...v0.2.0>`_ (2019-09-19)
------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **inspec:** remove not supported platforms (\ `2e2de5e <https://github.com/saltstack-formulas/exim-formula/commit/2e2de5e>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** add Kitchen tests (\ `a5e936d <https://github.com/saltstack-formulas/exim-formula/commit/a5e936d>`_\ )
* **travis:** reduce test matrix (\ `a136c60 <https://github.com/saltstack-formulas/exim-formula/commit/a136c60>`_\ )

Documentation
^^^^^^^^^^^^^


* **fix:** fix formula description (\ `04cb323 <https://github.com/saltstack-formulas/exim-formula/commit/04cb323>`_\ )
* **pillar:** update link to Debian documentation (\ `2cd96e4 <https://github.com/saltstack-formulas/exim-formula/commit/2cd96e4>`_\ )

Features
^^^^^^^^


* **semantic-release:** add semantic-release (\ `d00a7bf <https://github.com/saltstack-formulas/exim-formula/commit/d00a7bf>`_\ )

Styles
^^^^^^


* **yaml:** fix yaml linter warning (\ `3a219ab <https://github.com/saltstack-formulas/exim-formula/commit/3a219ab>`_\ )
