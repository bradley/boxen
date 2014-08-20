class people::bradley {
    $home_directory = '/'    
    $base = "/Library/Application Support"

    include chrome
    include divvy
    include dropbox
    include elasticsearch
    include firefox
    include imagemagick
    include iterm2::stable
    include java
    include mysql
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
    sublime_text_3::package { 'ColorSublime': source => 'ColorSublime/ColorSublime-Plugin' }
    exec { 'Own base':
      command => "chmod 755 /Library && chmod 755 '${base}'"
    }
    exec { 'Idempotent creation of User preferences directory':
      command => "mkdir -p '${base}/Sublime Text/Packages/User/Preferences' && mkdir -p '${base}/Sublime Text/Packages/Default/Preferences'",
      user => root,
    }
    file { "${base}/Sublime Text/Packages/User/Preferences.sublime-settings":
      require => Class["sublime_text_3"],
      source => 'puppet:///modules/people/bradley/User-Preferences.sublime-settings',
    }
    file { "${base}/Sublime Text/Packages/Default/Preferences.sublime-settings":
      require => Class["sublime_text_3"],
      source => 'puppet:///modules/people/bradley/Default-Preferences.sublime-settings',
    }
    file { "${base}/Sublime Text/Packages/gitmo.tmTheme":
      require => Class["sublime_text_3"],
      source => 'puppet:///modules/people/bradley/gitmo.tmTheme',
    }
    file { "/bin/subl":
      ensure => link,
      target => "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
    }

    Boxen::Osx_defaults {
      user => $::luser,
    }

    osx::recovery_message { 'If found, please email bradley.j.griffith@gmail.com': }
    
    include osx::global::disable_autocorrect
    include osx::global::expand_save_dialog
    include osx::global::disable_autocorrect
    include osx::global::tap_to_click
    include osx::finder::show_external_hard_drives_on_desktop
    include osx::finder::show_removable_media_on_desktop
    include osx::finder::empty_trash_securely
    include osx::finder::unhide_library
    include osx::disable_app_quarantine
    
    class { 'osx::global::key_repeat_delay':
      delay => 10,
    }
    
    class { 'osx::global::key_repeat_rate':
      rate => 0,
    }
   
    class { 'osx::dock::hot_corners':
      bottom_left => "Start Screen Saver",
    }    


    ## Git
    git::config::global { 'alias.co': value => 'checkout' }
    git::config::global { 'alias.gst': value => 'git status' }
    git::config::global { 'color.ui': value => 'true' }
    git::config::global { 'user.name': value => 'Bradley Griffith' }
    git::config::global { 'user.email': value => 'bradley.j.griffith@gmail.com' }

    ## zsh config
    file { "${home_directory}.zshrc":
      source => 'puppet:///modules/people/bradley/zshrc',
    }

    ## zsh config
    file { "${home_directory}.vimrc":
      source => 'puppet:///modules/people/bradley/vimrc',
    }

    ## Place iterm2 theme on desktop.
    file { "/Users/bradley/Desktop/saturn.itermcolors":
      source => 'puppet:///modules/people/bradley/saturn.itermcolors'
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
}
