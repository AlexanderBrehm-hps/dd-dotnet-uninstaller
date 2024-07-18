# Chef InSpec test for recipe dd-dotnet-uninstaller::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe command('C:\Program Files (x86)\dotnet-core-uninstall\dotnet-core-uninstall.exe') do
  its('exit_status') { should eq 0 }
end
