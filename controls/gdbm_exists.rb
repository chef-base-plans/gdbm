title 'Tests to confirm gdbm exists'

plan_name = input('plan_name', value: 'gdbm')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
gdbm_relative_path = input('command_path', value: '/bin/gdbmtool')
gdbm_installation_directory = command("hab pkg path #{plan_ident}")
gdbm_full_path = gdbm_installation_directory.stdout.strip + "#{ gdbm_relative_path}"
 
control 'core-plans-gdbm-exists' do
  impact 1.0
  title 'Ensure gdbm exists'
  desc '
  '
   describe file(gdbm_full_path) do
    it { should exist }
  end
end
