# Import the PowerShell Community Extensions (Pscx)
Import-Module Pscx

Set-Alias subl "C:\Program Files\Sublime Text 2\sublime_text.exe"

# Uninstalls all Ruby Gems.
Function Gem-Clean
{
  # Source: http://stackoverflow.com/questions/6373160
  gem list | %{ $_.split(' ')[0] } | %{ gem uninstall -Iax $_ }
}
