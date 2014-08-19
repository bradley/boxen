class people::bradley {
    include chrome
    include divvy
    include dropbox
    include elasticsearch
    include firefox
    include imagemagick
    include iterm2::stable
    include mysql
    include osx
    include postgresql
    include redis
    include skype
    include slack
    include spotify
    include sublime_text_3
    include zsh
    include ohmyzsh

    include sublime_text_3::package_control
    sublime_text_3::package { 'GitGutter': source => 'jisaacks/GitGutter' }
    
    file { "${home_directory}/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings":
      source => 'puppet:///modules/people/bradley/User-Preferences.sublime-settings',
    }
    exec { 
      'ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl':
    }

    osx::recovery_message { 'If found, please call 2147184671 or email bradley.j.griffith@gmail.com': }
    osx::global::expand_save_dialog
    osx::global::disable_autocorrect
    osx::global::tap_to_click
    osx::finder::show_external_hard_drives_on_desktop
    osx::finder::show_removable_media_on_desktop
    osx::finder::empty_trash_securely
    osx::finder::unhide_library
    osx::disable_app_quarantine
    ## The amount of time (ms) before a key repeats (defaults to 35)
    class { 'osx::global::key_repeat_delay':
      delay => 10
    }
    ## The amount of time (ms) befor a key repeate 'presses' (defaults to 0)
    class { 'osx::global::key_repeat_rate':
      rate => 2
    }

    ## Git
    git::config::global { 'color.ui': value => 'true' }
    git::config::global { 'user.name': value => 'Bradley Griffith' }
    git::config::global { 'user.email': value => 'bradley.j.griffith@gmail.com' }
    
    ## zsh config
    file { "${home_directory}/.zshrc":
      source => 'puppet:///modules/people/bradley/zshrc',
    }

    ## This is how to install Homebrew packages
    ## You can get a list of your current packages with
    ## `brew list`
    package {
      [
        'libxml2',
        'tig',
        'tree',
        'wdiff',
        'wget'
      ]:
      ensure => present,
    }

    $home = "/Users/${::boxen_user}"
}
