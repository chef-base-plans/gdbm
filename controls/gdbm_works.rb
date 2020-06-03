title 'Tests to confirm gdbm works as expected'

plan_name = input('plan_name', value: 'gdbm')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-gdbm-works' do
  impact 1.0
  title 'Ensure gdbm works as expected'
  desc '
  '
  gdbm_path = command("hab pkg path #{plan_ident}")
  describe gdbm_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  gdbm_pkg_ident = ((gdbm_path.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  describe command("DEBUG=true; hab pkg exec #{ gdbm_pkg_ident} gdbmtool --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /gdbmtool \(gdbm\) 1.18.1/ }
    its('stderr') { should be_empty }
  end
end
