# Library provides functions for using version control.

Function GitClone([string] $source, [string] $destination)
{
  if (Test-Path $destination) {
    echo "Clone skipped. Destination $destination already exists."
  } else {
    echo "Cloning..."
    echo "Source: $source"
    echo "Destination: $destination"

    git clone $source $destination
  }
}
