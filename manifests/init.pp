# == Class: msuac
#
# == Parameters
#
# $prompt_value is one of the three option:
#
# 0x00000000
# This option SHOULD be used to allow the Consent Admin to perform an
# operation that requires elevation without consent or credentials.
#
# 0x00000001
# This option SHOULD be used to prompt the Consent Admin to enter his or her
# user name and password (or another valid admin) when an operation requires
# elevation of privilege.
#
# 0x00000002 (default)
# This option SHOULD be used to prompt the administrator in Admin Approval
# Mode to select either "Permit" or "Deny" an operation that requires
# elevation of privilege. If the Consent Admin selects Permit, the operation
# will continue with their highest available privilege. "Prompt for consent"
# removes the inconvenience of requiring that users enter their name and
# password to perform a privileged task.
#
# == Authors
#
# Thomas Linkin <tom@puppetlabs.com>
# Jon Mosco <jonny.mosco@gmail.com>
#
class msuac (
  $enabled = true,
  $prompt  = 'consentprompt',
) {

  if $::operatingsystem != 'Windows' {
    fail ("Class[msuac] can only be applied to Windows systems. It cannot be used on \"${::operatingsystem}.\"")
  }

  validate_bool($enabled)
  validate_re($prompt, '^(consentprompt|authprompt|disabled)$')

  $prompt_data = $prompt ? {
    'disabled'      => '0x00000000',
    'authprompt'    => '0x00000001',
    'consentprompt' => '0x00000002',
  }

  if $enabled {
    $uac_data = '0x00000001'
  } else {
    $uac_data = '0x00000000'
  }

  registry::value { 'EnableLUA':
    key  => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',
    type => 'dword',
    data => $uac_data,
  }

  registry::value { 'ConsentPromptBehaviorAdmin':
    key    => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System',
    type   => 'dword',
    data   => $prompt_data,
  }
}
