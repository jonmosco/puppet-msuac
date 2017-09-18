# msuac

### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with msuac](#setup)
    * [What msuac affects](#what-msuac-affects)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The msuac module allows you to manage Microsoft User account control (MSUAC).
UAC is a feature in Windows to help protect you from intrusive software by warning
you if changes are being made.  When a change to the computer is being made that requires
administrative privileges, UAC will prompt you based on its configuration.  This module will
allow you to change those settings.

## Module Description

This module will change the registry key values based on the desired UAC configuration.

## Setup

### What msuac affects

* If UAC is set to 'Disabled', a reboot will be required for changes to take effect.

### Setup Requirements

Depends on the following modules:

[puppetlabs/registry](https://forge.puppetlabs.com/puppetlabs/registry)

[puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)

## Usage

Class: msuac

        class { 'msuac':
          enabled => false,
          prompt  => disabled,
        }

## Parameters:

$prompt_value is one of the three option:

0x00000000 (disabled)

This option SHOULD be used to allow the Consent Admin to perform an
operation that requires elevation without consent or credentials.

0x00000001 (authprompt)

This option SHOULD be used to prompt the Consent Admin to enter his or her
user name and password (or another valid admin) when an operation requires
elevation of privilege.

0x00000002 (default, consentprompt)

This option SHOULD be used to prompt the administrator in Admin Approval
Mode to select either "Permit" or "Deny" an operation that requires
elevation of privilege. If the Consent Admin selects Permit, the operation
will continue with their highest available privilege. "Prompt for consent"
removes the inconvenience of requiring that users enter their name and
password to perform a privileged task.

## Limitations

Windows Versions supported:

        - Windows Visa
        - Windows 7
        - Server 2008
        - Server 2012 R2

## Development

## Release Notes/Contributors/Etc

Contributors:

        Thomas Linkin <tom@puppetlabs.com>
