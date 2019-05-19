Add-Type -AssemblyName System.IO.Compression.FileSystem

function Unzip {
  param([string]$zipfile, [string]$outpath)
  [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function dl_and_install($name, $url, $ag) {
  $Path = $env:TEMP
  $Installer = $name
  $Ptarget = "$Path\$Installer"
  $ProgressPreference = 'SilentlyContinue'
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  Write-Output "downloading $url to $Ptarget"
  Invoke-WebRequest $url -OutFile $Ptarget
  if ($Installer -like '*.zip') {
    Unzip "$Ptarget" "$ag"
  }
  if ($Installer -like '*exe') {
    "installing exe $name with $ag"
    Start-Process -FilePath $Ptarget -Args "$ag" -Verb RunAs -Wait
  }
  if ($Installer -like '*msi') {
    "installing msi $name with $ag"
    Start-Process -FilePath 'msiexec.exe' -Args "/i $Ptarget $ag" -Verb RunAs -Wait
  }
  Remove-Item $Ptarget
}

function install_hab {
  dl_and_install "habitat.zip" "https://api.bintray.com/content/habitat/stable/windows/x86_64/hab-%24latest-x86_64-windows.zip?bt_package=hab-x86_64-windows" "C:\habitat"
}

function install_vs_code {
  dl_and_install "vscode-install.exe" "https://go.microsoft.com/fwlink/?Linkid=852157" "/VERYSILENT /MERGETASKS=!runcode"
}

function install_google_chrome {
  dl_and_install "goole_chrome.exe" "https://dl.google.com/chrome/install/latest/chrome_installer.exe" "/silent /install"
}

function install_ws {
  dl_and_install "chefws.msi" "${chef_workstation_dl_url}" "/quiet /passive"
}

function make_profile {
  Write-Output '$env:Path = "C:\ProgramData\DockerDesktop\version-bin;C:\Program Files\Docker\Docker\Resources\bin;C:\Windows\system32;C:\Windows;C:\Program Files\Microsoft VS Code\bin;C:\habitat;C:\opscode\chef-workstation\bin\";' >> C:\profile.ps1
  setx PATH "%PATH%;C:\Windows;C:\Program Files\Microsoft VS Code\bin;C:\habitat;C:\opscode\chef-workstation\bin"
}

function hab_dir {
  Move-Item C:\habitat\hab*.*\* C:\habitat\
}

function hab_accept {
  hab license accept
}

%{ if use_chocolatey }
choco install habitat -y
choco install git -y
choco install googlechrome -y
choco install vscode -y
%{ else }
install_hab
hab_dir
install_vs_code
install_google_chrome
make_profile
%{ endif }

install_ws
hab_accept
