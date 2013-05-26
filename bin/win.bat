@echo off
:: Run me with admin permissions

echo "Setting HOME."
setx HOME "%USERPROFILE%"

:: The dotfiles dir
set DOT="%USERPROFILE%\dotfiles"

echo "Linking Mercurial extensions."
mklink "%HOME%\.hgrc" "%DOT%\hgrc"

echo "Linking Vim."
mklink /d "%HOME%\.vim" "%DOT%\dotfiles\vim"
mklink "%HOME%\.vimrc" "%DOT%\dotfiles\vim\vimrc"
mklink "%HOME%\.gvimrc" "%DOT%\dotfiles\vim\gvimrc"
mklink "%HOME%\.vsvimrc" "%DOT%\dotfiles\vim\vsvimrc"

