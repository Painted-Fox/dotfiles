# This script will install Sublime Text 2 packages.

# Script dir.
$dir = Resolve-Path "$MyInvocation.MyCommand.Path\.."

# Sublime packages dir.
$packages = Resolve-Path "$env:UserProfile\AppData\Roaming\Sublime Text 2\Packages"

# Creates a symbolic link
Function SymLink($link, $target, [bool] $directory=$False)
{
  $linkDir = Split-Path $link -parent
  if (!(Test-Path $linkDir)) {
    echo "Making directory: $linkDir"
    md -Path $linkDir
  }

  #if (Test-Path $link) { rm $link }

  if ($directory) { cmd /c mklink /D $link $target }
  else { cmd /c mklink $link $target }
}

# Creates a directory symbolic link
Function SymDirLink($link, $target)
{
  SymLink $link $target $True
}

cd $packages

# VintageEx - An implementation of Vim's command-line mode for Sublime Text 2
# https://github.com/SublimeText/VintageEx
git clone git://github.com/SublimeText/VintageEx.git

# Sass syntax highlighting
# https://github.com/n00ge/sublime-text-haml-sass
git clone git://github.com/n00ge/sublime-text-haml-sass.git
SymDirLink("$packages\SASS", "$packages\sublime-text-haml-sass\SASS")
SymDirLink("$packages\Ruby Haml", "$packages\sublime-text-haml-sass\Ruby Haml")

# Adds TextMate-like autocompletion to Sublime Text 2
# https://github.com/alexstaubo/sublime_text_alternative_autocompletion
git clone git://github.com/alexstaubo/sublime_text_alternative_autocompletion.git

# Sublime Text 2 plugin for running ruby tests! (Unit, RSpec, Cucumber)
# https://github.com/maltize/sublime-text-2-ruby-tests
git clone https://github.com/maltize/sublime-text-2-ruby-tests.git RubyTest

cd $dir
