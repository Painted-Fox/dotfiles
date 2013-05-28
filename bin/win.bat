@echo off
:: Run me with admin permissions

echo "Setting HOME."
setx HOME "%USERPROFILE%"

:: The dotfiles dir
set DOT="%USERPROFILE%\dotfiles"

echo "Linking Mercurial extensions."
mklink "%HOME%\.hgrc" "%DOT%\hgrc"

echo "Linking Vim."
mklink /d "%HOME%\.vim" "%DOT%\vim"
mklink "%HOME%\.vimrc" "%DOT%\vim\vimrc"
mklink "%HOME%\.gvimrc" "%DOT%\vim\gvimrc"
mklink "%HOME%\.vsvimrc" "%DOT%\vim\vsvimrc"

echo "Linking Mintty."
mklink "%HOME%\.minttyrc" "%DOT%\minttyrc"