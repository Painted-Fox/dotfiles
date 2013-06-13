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

echo "Linking Vim."
mklink /d "%HOME%\.vim"  "%DOT%\vim"
mklink "%HOME%\.vimrc"   "%DOT%\vim\vimrc"
mklink "%HOME%\.gvimrc"  "%DOT%\vim\gvimrc"
mklink "%HOME%\.vsvimrc" "%DOT%\vim\vsvimrc"

echo "Linking Mintty."
mklink "%HOME%\.minttyrc" "%DOT%\minttyrc"

echo "Linking zsh"
mklink "%HOME%\.zshenv"    "%HOME%\.prezto\runcoms\zshenv"
mklink "%HOME%\.zprofile"  "%HOME%\.prezto\runcoms\zprofile"
mklink "%HOME%\.zshrc"     "%HOME%\.prezto\runcoms\zshrc"
mklink "%HOME%\.zpreztorc" "%HOME%\.prezto\runcoms\zpreztorc"
mklink "%HOME%\.zlogin"    "%HOME%\.prezto\runcoms\zlogin"
mklink "%HOME%\.zlogout"   "%HOME%\.prezto\runcoms\zlogout"

echo "Linking Bash"
mklink "%HOME%\.profile" "%DOT%\profile"
mklink "%HOME%\.bashrc" "%DOT%\bashrc"
