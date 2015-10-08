# Painted-Fox/dotfiles

These are my personal dotfiles.  Everyone has their own way to organize and
handle their dotfiles and everyone's configurations are personal.  My dotfiles
will unlikely serve your needs, so beware if you try to install them, but it's
certainly safe to read them for inspiration for how you want to organize and
handle your own dotfiles.

I use my dotfiles on Linux and Windows.

## Installing Prerequisites

Before installing the dotfiles, there are some prerequisites.  These are just
prerequisites for installing the dotfiles, not a list of all the tools the
dotfiles configure.

* **[Mercurial][hg]** (also known as the command `hg`) is needed to get the
  dotfiles themselves.  [TortoiseHg][thg] is highly recommended for Windows and
  comes with dulwich.
* **[Git][git]** is needed to grab git subrepositories listed in `.hgsub` (if
  it exists).  It's also required to install Vim plugins.
* **[Python][py]** is needed to run the `bin/bootstrap` script.  Version 3.2 or
  higher is required on Windows.
* **[dulwich][dulwich]** is a python library that provides an interface to git
  repos.  This is a requirement for the Mercurial extension [hg-git][hg-git],
  which enables using Mercurial with git repos.  It's enabled in my `hgrc` so
  it's nice to install this early to avoid errors when running the `hg` command.

On Ubuntu, run the following to install prerequisites:

    sudo apt-get install mercurial git python-dulwich

[hg]:      https://www.mercurial-scm.org/
[thg]:     http://tortoisehg.bitbucket.org/
[git]:     https://git-scm.com/
[py]:      https://www.python.org/
[dulwich]: https://github.com/jelmer/dulwich
[hg-git]:   https://hg-git.github.io/

## Getting the Dotfiles

My dotfiles expect to be saved to `~/lib/dotfiles` and they can be retrieved via
ssh...

    hg clone ssh://hg@bitbucket.org/Painted-Fox/dotfiles ~/lib/dotfiles

...or via https:

    hg clone https://Painted-Fox@bitbucket.org/Painted-Fox/dotfiles ~/lib/dotfiles

## Installing the Dotfiles

On Linux, run the following command in the terminal:

    ~/lib/dotfiles/bin/bootstrap

On Windows, run a command prompt as administrator and run the following
(assuming `python` is in your PATH):

    python %USERPROFILE%\lib\dotfiles\bin\bootstrap

## Installing Vim Plugins

After installing the dotfiles, the next step is usually to install Vim plugins.
I use [vim-plug][vim-plug], a minimalist Vim plugin manager.  To install the
plugins, run Vim and run the following command within Vim:

    :PlugInstall

[vim-plug]: https://github.com/junegunn/vim-plug
