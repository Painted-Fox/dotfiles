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

echo "Linking gemrc."
mklink "%HOME%\.gemrc" "%DOT%\gemrc"

echo "Linking kdiff3 configuration."
mklink "%HOME%\.kdiff3rc" "%DOT%\kdiff3rc"

echo "Linking Ag, the Silver Search, configuration."
mklink "%HOME%\.agignore" "%DOT%\agignore"

echo "Linking KiTTY."
mkdir "C:\tools\KiTTY"
mklink /d "C:\tools\KiTTY\Sessions" "%DOT%\KiTTY\Sessions"
mklink "C:\tools\KiTTY\kitty.ini" "%DOT%\KiTTY\kitty.ini"

echo "Linking Vim."
mklink /d "%HOME%\.vim"  "%DOT%\vim"
mklink "%HOME%\.vimrc"   "%DOT%\vimrc"
mklink "%HOME%\.vsvimrc"   "%DOT%\vsvimrc"
