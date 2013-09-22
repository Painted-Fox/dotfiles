@echo off
:: Run me with admin permissions

echo "Setting HOME."
setx HOME "%USERPROFILE%"

:: The dotfiles dir
set DOT="%USERPROFILE%\dotfiles"

echo "Linking Mercurial configuration."
mklink "%HOME%\.hgrc" "%DOT%\hgrc"

echo "Linking git configuration."
mklink "%HOME%\.gitconfig" "%DOT%\gitconfig"

echo "Linking kdiff3 configuration."
mklink "%HOME%\.kdiff3rc" "%DOT%\kdiff3rc"

echo "Linking KiTTY."
mkdir "C:\tools\KiTTY"
mklink /d "C:\tools\KiTTY\Sessions" "%DOT%\KiTTY\Sessions"
mklink "C:\tools\KiTTY\kitty.ini" "%DOT%\KiTTY\kitty.ini"

echo "Linking Vim."
mklink /d "%HOME%\.vim"  "%DOT%\vim"
mklink "%HOME%\.vimrc"   "%DOT%\vim\vimrc"
mklink "%HOME%\.gvimrc"  "%DOT%\vim\gvimrc"
mklink "%HOME%\.vsvimrc" "%DOT%\vim\vsvimrc"

echo "Linking Mintty."
mklink "%HOME%\.minttyrc" "%DOT%\minttyrc"

echo "Linking Bash"
mklink "%HOME%\.profile" "%DOT%\profile"
mklink "%HOME%\.bashrc" "%DOT%\bashrc"
