windows_package 'Microsoft .Net Core SDK Uninstall Tool (x86)' do
  source 'https://github.com/dotnet/cli-lab/releases/download/1.6.0/dotnet-core-uninstall-1.6.0.msi'
  checksum '30bd7f95034d32a0830d9fdd089a176a84c77455e20dc07e433a1d8679feba9f'
  version '4.96.657'
  action :install
end